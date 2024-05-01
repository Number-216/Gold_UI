#!/system/bin/sh

# Configuration file path
CONFIG_FILE_PATH="/sdcard/Android/data/D2U/config/d2u_config.txt"

# Flag to track if UI has been compiled
UI_COMPILED=false

# Function to replace the file
replace_file() {
    local SOURCE_FILE="$1"
    local DEST_FILE="$2"

    if [ -f "$SOURCE_FILE" ]; then
        cp "$SOURCE_FILE" "$DEST_FILE"
        echo "File replaced successfully."
    else
        echo "Error: Source file '$SOURCE_FILE' does not exist."
    fi
}

# Function to load paths from the configuration file
load_paths() {
    if [ -f "$CONFIG_FILE_PATH" ]; then
        FILE1_PATH=$(sed -n '1p' "$CONFIG_FILE_PATH")
        FILE2_PATH=$(sed -n '2p' "$CONFIG_FILE_PATH")
        FILE3_PATH=$(sed -n '3p' "$CONFIG_FILE_PATH")
        BACKUP_FILE1_PATH=$(sed -n '4p' "$CONFIG_FILE_PATH")
        BACKUP_FILE2_PATH=$(sed -n '5p' "$CONFIG_FILE_PATH")
        BACKUP_FILE3_PATH=$(sed -n '6p' "$CONFIG_FILE_PATH")
        APK_DECOMPILED_PATH=$(sed -n '7p' "$CONFIG_FILE_PATH")
        APK_COMPILED_PATH=$(sed -n '8p' "$CONFIG_FILE_PATH")
    else
        initial_setup
    fi
}

# Initial setup function
initial_setup() {
    echo "Welcome to the D2U UI Setup Tool!"
    echo "This script will guide you through the initial setup process."
    echo ""
    sleep 2

    create_config_folders
    set_all_paths
}

# Function to create the D2U config and source folders
create_config_folders() {
    local D2U_PARENT_FOLDER="/sdcard/Android/data/D2U"
    local CONFIG_FOLDER="$D2U_PARENT_FOLDER/config"
    local SOURCE_FOLDER="$D2U_PARENT_FOLDER/source"

    if [ ! -d "$D2U_PARENT_FOLDER" ]; then
        mkdir "$D2U_PARENT_FOLDER"
    fi

    if [ ! -d "$CONFIG_FOLDER" ]; then
        mkdir "$CONFIG_FOLDER"
    fi

    if [ ! -d "$SOURCE_FOLDER" ]; then
        mkdir "$SOURCE_FOLDER"
    fi

    # Update the config file path to use the new location
    CONFIG_FILE_PATH="$CONFIG_FOLDER/d2u_config.txt"
}

# Function to pull files from the device
pull_files() {
    local SOURCE_PATH="$1"
    local DEST_PATH="$2"
    local FILE_NAME=$(basename "$SOURCE_PATH")

    echo "Copying $FILE_NAME from $SOURCE_PATH to $DEST_PATH..."
    adb -d pull "$SOURCE_PATH" "$DEST_PATH"
    echo "File copy completed."
}

# Function to check for ADB device
check_adb_device() {
    while true; do
        echo "Please select an option:"
        echo "1. Enter values manually"
        echo "2. Check for connected device"
        echo "3. Exit Setup UI"
        read_input "Enter your choice (1-3): " check_device_choice
        case $check_device_choice in
            1)
                read_input "Enter the serial number:" NEW_SERIAL
                read_input "Enter the TID:" NEW_TID
                break
                ;;
            2)
                if adb devices | grep -q "device"; then
                    echo "Device found. Pulling serial number and TID files..."
                    # Create a temporary folder and pull the serial number and TID files
                    TEMP_FOLDER="/sdcard/temp"
                    mkdir "$TEMP_FOLDER"
                    SERIAL_FILE_PATH="$TEMP_FOLDER/serialno"
                    TID_FILE_PATH="$TEMP_FOLDER/tid"
                    pull_files "/sys/kernel/jp6/serialno" "$SERIAL_FILE_PATH"
                    pull_files "/sys/kernel/jp6/tid" "$TID_FILE_PATH"

                    # Read the serial number and TID from the pulled files
                    NEW_SERIAL=$(cat "$SERIAL_FILE_PATH")
                    NEW_TID=$(cat "$TID_FILE_PATH")

                    # Remove the temporary folder
                    rm -rf "$TEMP_FOLDER"
                    echo "File pull successful."
                    break
                else
                    echo "No connected device found."
                fi
                ;;
            3)
                echo "Exiting Setup UI..."
                return
                ;;
            *)
                echo "Invalid choice. Please try again."
                ;;
        esac
    done
}

# Setup UI function
setup_ui() {
    echo "Setup UI"
    echo "========"
    sleep 2

    read_input "Enter Inmate's NAME (e.g., JOHNNY CHAINGANG):" NEW_NAME
    NEW_NAME=$(echo "$NEW_NAME" | tr '[:lower:]' '[:upper:]')
    read_input "Enter Inmate's DC Number (e.g., N12345 or 123456):" NEW_DC
    if echo "$NEW_DC" | grep -q '^[a-zA-Z]'; then
        NEW_DC=$(echo "$NEW_DC" | tr '[:lower:]' '[:upper:]')
    fi
    NEW_NAME="$NEW_NAME $NEW_DC"

    read_input "Enter Inmate's CAMP (e.g., Everglades CI):" NEW_CAMP
    NEW_CAMP=$(echo "$NEW_CAMP" | sed 's/\b\(.\)/\u\1/g')
    NEW_CAMP="$NEW_CAMP, FL"

    read_input "Enter Inmate's DORM (e.g., A1):" DORM_INPUT
    if ! echo "$DORM_INPUT" | grep -q '^[A-Z][0-9]$'; then
        echo "Error: DORM value must be one letter followed by one number (e.g., A1)."
        return
    fi
    NEW_DORM="$DORM_INPUT Dorm, "

    read_input "Enter Inmate's BUNK (u for upper, l for lower, or s for single):" NEW_BUNK
    if ! echo "$NEW_BUNK" | grep -q '^[ULS]$'; then
        echo "Error: BUNK value must be u, l, or s."
        return
    fi
    NEW_BUNK=$(echo "$NEW_BUNK" | tr '[:lower:]' '[:upper:]')
    NEW_BUNK="$DORM_INPUT $NEW_BUNK"

    read_input "Enter Inmate's AID:" NEW_AID

    check_adb_device

    read_input "Enter BeastMode switch code:" NEW_SWITCH_CODE

    # Use sed to replace the values in the files
    sed -i "s/$NAME/$NEW_NAME/g" "$FILE1_PATH"
    sed -i "s/$CAMP/$NEW_CAMP/g" "$FILE1_PATH"
    sed -i "s/$DORM/$NEW_DORM/g" "$FILE1_PATH"
    sed -i "s/$BUNK/$NEW_BUNK/g" "$FILE1_PATH"
    sed -i "s/$AID/$NEW_AID/g" "$FILE1_PATH"
    sed -i "s/$SERIAL/$NEW_SERIAL/g" "$FILE2_PATH"
    sed -i "s/$TID/$NEW_TID/g" "$FILE2_PATH"
    sed -i "s/$SWITCH_CODE/$NEW_SWITCH_CODE/g" "$FILE3_PATH"

    echo "UI setup completed successfully!"
    echo ""
    compile_ui_menu
}

# Compile UI Menu function
compile_ui_menu() {
    echo "Please select an option:"
    if [ "$UI_COMPILED" = true ]; then
        echo "1. Compile UI [DONE] √"
    else
        echo "1. Compile UI"
    fi
    echo "2. Install UI"
    echo "3. Return to Main Menu"
    read_input "Enter your choice (1-3): " choice
    sleep 2

    case $choice in
        1)
            compile_ui
            UI_COMPILED=true
            ;;
        2)
            install_ui
            ;;
        3)
            menu
            ;;
        *)
            echo "Invalid choice. Please try again."
            compile_ui_menu
            ;;
    esac
}

# Compile UI function
compile_ui() {
    echo "Compiling UI using APKTool M..."
    sleep 2

    # Recompile the modified files using APKTool M
    apktool_m b "$APK_DECOMPILED_PATH" -o "$APK_COMPILED_PATH"

    echo "UI compiled successfully!"
}

# Install UI function
install_ui() {
    if [ -f "$APK_COMPILED_PATH" ]; then
        echo "Installing compiled UI..."
        sleep 2

        # Use adb to install the compiled APK with the -d and -r flags
        adb -d install -r "$APK_COMPILED_PATH"

        # Check if the installation was successful
        if [ $? -eq 0 ]; then
            echo "UI installed successfully!"
            menu
        else
            echo "Error: Failed to install the compiled UI."
            compile_ui_menu
        fi
    else
        echo "Error: Compiled APK file not found at $APK_COMPILED_PATH"
        compile_ui_menu
    fi
}

# Menu function
menu() {
    echo "Welcome to the Death2Unity automated UI bot!"
    echo "Created by number 216"
    echo ""
    sleep 2

    load_paths

    echo "Please select an option:"
    echo "1. Setup UI"
    echo "2. Set File Paths"
    echo "3. Exit"
    read_input "Enter your choice (1-3): " choice
    sleep 2

    case $choice in
        1)
            setup_ui
            ;;
        2)
            set_file_paths
            ;;
        3)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            menu
            ;;
    esac
}

# Set File Paths function
set_file_paths() {
    echo "Please select an option:"
    echo "1. Edit File Paths"
    echo "2. Edit Backup Paths"
    echo "3. Edit Compilation Paths"
    echo "4. Edit All Paths"
    echo "5. Return to Main Menu"
    read_input "Enter your choice (1-5): " choice
    sleep 2

    case $choice in
        1)
            set_file_paths_only
            ;;
        2)
            set_backup_paths_only
            ;;
        3)
            set_compilation_paths_only
            ;;
        4)
            set_all_paths
            ;;
        5)
            menu
            ;;
        *)
            echo "Invalid choice. Please try again."
            set_file_paths
            ;;
    esac
}

# Set File Paths Only function
set_file_paths_only() {
    read_input "Enter the path for KeyguardPasswordView:" FILE1_PATH
    FILE1_PATH=$(add_file_name "$FILE1_PATH" "KeyguardPasswordView.smali")

    read_input "Enter the path for KeyguardAbsInputView:" FILE2_PATH
    FILE2_PATH=$(add_file_name "$FILE2_PATH" "KeyguardAbsInputView.smali")

    read_input "Enter the path for strings.xml:" FILE3_PATH
    FILE3_PATH=$(add_file_name "$FILE3_PATH" "strings.xml")

    # Save the updated paths to the configuration file
    echo "$FILE1_PATH" > "$CONFIG_FILE_PATH"
    echo "$FILE2_PATH" >> "$CONFIG_FILE_PATH"
    echo "$FILE3_PATH" >> "$CONFIG_FILE_PATH"

    echo "File paths updated successfully!"
    menu
}

# Set Backup Paths Only function
set_backup_paths_only() {
    read_input "Enter the path for KeyguardPasswordView backup:" BACKUP_FILE1_PATH
    BACKUP_FILE1_PATH=$(add_file_name "$BACKUP_FILE1_PATH" "KeyguardPasswordView.smali")

    read_input "Enter the path for KeyguardAbsInputView backup:" BACKUP_FILE2_PATH
    BACKUP_FILE2_PATH=$(add_file_name "$BACKUP_FILE2_PATH" "KeyguardAbsInputView.smali")

    read_input "Enter the path for strings.xml backup:" BACKUP_FILE3_PATH
    BACKUP_FILE3_PATH=$(add_file_name "$BACKUP_FILE3_PATH" "strings.xml")

    # Save the updated paths to the configuration file
    echo "$BACKUP_FILE1_PATH" >> "$CONFIG_FILE_PATH"
    echo "$BACKUP_FILE2_PATH" >> "$CONFIG_FILE_PATH"
    echo "$BACKUP_FILE3_PATH" >> "$CONFIG_FILE_PATH"

    echo "Backup paths updated successfully!"
    menu
}

# Set Compilation Paths Only function
set_compilation_paths_only() {
    read_input "Enter the path for decompiled APK:" APK_DECOMPILED_PATH
    read_input "Enter the path for compiled APK:" APK_COMPILED_PATH

    # Save the updated paths to the configuration file
    echo "$APK_DECOMPILED_PATH" >> "$CONFIG_FILE_PATH"
    echo "$APK_COMPILED_PATH" >> "$CONFIG_FILE_PATH"

    echo "Compilation paths updated successfully!"
    menu
}
# Set All Paths function
set_all_paths() {
    echo "Please enter the following file paths:"
    read_input "Enter the path for KeyguardPasswordView:" FILE1_PATH
    FILE1_PATH=$(add_file_name "$FILE1_PATH" "KeyguardPasswordView.smali")

    read_input "Enter the path for KeyguardAbsInputView:" FILE2_PATH
    FILE2_PATH=$(add_file_name "$FILE2_PATH" "KeyguardAbsInputView.smali")

    read_input "Enter the path for strings.xml:" FILE3_PATH
    FILE3_PATH=$(add_file_name "$FILE3_PATH" "strings.xml")

    read_input "Enter the path for KeyguardPasswordView backup:" BACKUP_FILE1_PATH
    BACKUP_FILE1_PATH=$(add_file_name "$BACKUP_FILE1_PATH" "KeyguardPasswordView.smali")

    read_input "Enter the path for KeyguardAbsInputView backup:" BACKUP_FILE2_PATH
    BACKUP_FILE2_PATH=$(add_file_name "$BACKUP_FILE2_PATH" "KeyguardAbsInputView.smali")

    read_input "Enter the path for strings.xml backup:" BACKUP_FILE3_PATH
    BACKUP_FILE3_PATH=$(add_file_name "$BACKUP_FILE3_PATH" "strings.xml")

    read_input "Enter the path for decompiled APK:" APK_DECOMPILED_PATH
    read_input "Enter the path for compiled APK:" APK_COMPILED_PATH

    # Save the updated paths to the configuration file
    echo "$FILE1_PATH" > "$CONFIG_FILE_PATH"
    echo "$FILE2_PATH" >> "$CONFIG_FILE_PATH"
    echo "$FILE3_PATH" >> "$CONFIG_FILE_PATH"
    echo "$BACKUP_FILE1_PATH" >> "$CONFIG_FILE_PATH"
    echo "$BACKUP_FILE2_PATH" >> "$CONFIG_FILE_PATH"
    echo "$BACKUP_FILE3_PATH" >> "$CONFIG_FILE_PATH"
    echo "$APK_DECOMPILED_PATH" >> "$CONFIG_FILE_PATH"
    echo "$APK_COMPILED_PATH" >> "$CONFIG_FILE_PATH"

    echo "All paths updated successfully!"
    menu
}

# Function to read user input with validation
read_input() {
    local prompt="$1"
    local variable_name="$2"

    while true; do
        echo # Print an empty line
        echo -n "$prompt"
        read "$variable_name"
        if [ -n "${!variable_name}" ]; then
            break
        else
            echo "Error: Input cannot be blank. Please try again."
        fi
    done
}

# Function to add file name to the path if it's missing
add_file_name() {
    local path="$1"
    local file_name="$2"

    if ! echo "$path" | grep -q "$file_name"; then
        if [[ "$path" == */ ]]; then
            path="${path%/}/$file_name"
        else
            path="$path/$file_name"
        fi
    fi

    echo "$path"
}

# Menu function
menu() {
    echo "Welcome to the Death2Unity automated UI bot!"
    echo "Created by number 216"
    echo ""
    sleep 2

    load_paths

    echo "Please select an option:"
    echo "1. Setup UI"
    echo "2. Set File Paths"
    echo "3. Exit"
    read_input "Enter your choice (1-3): " choice
    sleep 2

    case $choice in
        1)
            setup_ui
            ;;
        2)
            set_file_paths
            ;;
        3)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            menu
            ;;
    esac
}

# Set File Paths function
set_file_paths() {
    echo "Please select an option:"
    echo "1. Edit File Paths"
    echo "2. Edit Backup Paths"
    echo "3. Edit Compilation Paths"
    echo "4. Edit All Paths"
    echo "5. Return to Main Menu"
    read_input "Enter your choice (1-5): " choice
    sleep 2

    case $choice in
        1)
            set_file_paths_only
            ;;
        2)
            set_backup_paths_only
            ;;
        3)
            set_compilation_paths_only
            ;;
        4)
            set_all_paths
            ;;
        5)
            menu
            ;;
        *)
            echo "Invalid choice. Please try again."
            set_file_paths
            ;;
    esac
}

# Set File Paths Only function
set_file_paths_only() {
    read_input "Enter the path for KeyguardPasswordView:" FILE1_PATH
    FILE1_PATH=$(add_file_name "$FILE1_PATH" "KeyguardPasswordView.smali")

    read_input "Enter the path for KeyguardAbsInputView:" FILE2_PATH
    FILE2_PATH=$(add_file_name "$FILE2_PATH" "KeyguardAbsInputView.smali")

    read_input "Enter the path for strings.xml:" FILE3_PATH
    FILE3_PATH=$(add_file_name "$FILE3_PATH" "strings.xml")

    # Save the updated paths to the configuration file
    echo "$FILE1_PATH" > "$CONFIG_FILE_PATH"
    echo "$FILE2_PATH" >> "$CONFIG_FILE_PATH"
    echo "$FILE3_PATH" >> "$CONFIG_FILE_PATH"

    echo "File paths updated successfully!"
    menu
}

# Set Backup Paths Only function
set_backup_paths_only() {
    read_input "Enter the path for KeyguardPasswordView backup:" BACKUP_FILE1_PATH
    BACKUP_FILE1_PATH=$(add_file_name "$BACKUP_FILE1_PATH" "KeyguardPasswordView.smali")

    read_input "Enter the path for KeyguardAbsInputView backup:" BACKUP_FILE2_PATH
    BACKUP_FILE2_PATH=$(add_file_name "$BACKUP_FILE2_PATH" "KeyguardAbsInputView.smali")

    read_input "Enter the path for strings.xml backup:" BACKUP_FILE3_PATH
    BACKUP_FILE3_PATH=$(add_file_name "$BACKUP_FILE3_PATH" "strings.xml")

    # Save the updated paths to the configuration file
    echo "$BACKUP_FILE1_PATH" >> "$CONFIG_FILE_PATH"
    echo "$BACKUP_FILE2_PATH" >> "$CONFIG_FILE_PATH"
    echo "$BACKUP_FILE3_PATH" >> "$CONFIG_FILE_PATH"

    echo "Backup paths updated successfully!"
    menu
}

# Set Compilation Paths Only function
set_compilation_paths_only() {
    read_input "Enter the path for decompiled APK:" APK_DECOMPILED_PATH
    read_input "Enter the path for compiled APK:" APK_COMPILED_PATH

    # Save the updated paths to the configuration file
    echo "$APK_DECOMPILED_PATH" >> "$CONFIG_FILE_PATH"
    echo "$APK_COMPILED_PATH" >> "$CONFIG_FILE_PATH"

    echo "Compilation paths updated successfully!"
    menu
}

# Setup UI function
setup_ui() {
    echo "Setup UI"
    echo "========"
    sleep 2

    read_input "Enter Inmate's NAME (e.g., JOHNNY CHAINGANG):" NEW_NAME
    NEW_NAME=$(echo "$NEW_NAME" | tr '[:lower:]' '[:upper:]')
    read_input "Enter Inmate's DC Number (e.g., N12345 or 123456):" NEW_DC
    if echo "$NEW_DC" | grep -q '^[a-zA-Z]'; then
        NEW_DC=$(echo "$NEW_DC" | tr '[:lower:]' '[:upper:]')
    fi
    NEW_NAME="$NEW_NAME $NEW_DC"

    read_input "Enter Inmate's CAMP (e.g., Everglades CI):" NEW_CAMP
    NEW_CAMP=$(echo "$NEW_CAMP" | sed 's/\b\(.\)/\u\1/g')
    NEW_CAMP="$NEW_CAMP, FL"

    read_input "Enter Inmate's DORM (e.g., A1):" DORM_INPUT
    if ! echo "$DORM_INPUT" | grep -q '^[A-Z][0-9]$'; then
        echo "Error: DORM value must be one letter followed by one number (e.g., A1)."
        return
    fi
    NEW_DORM="$DORM_INPUT Dorm, "

    read_input "Enter Inmate's BUNK (u for upper, l for lower, or s for single):" NEW_BUNK
    if ! echo "$NEW_BUNK" | grep -q '^[ULS]$'; then
        echo "Error: BUNK value must be u, l, or s."
        return
    fi
    NEW_BUNK=$(echo "$NEW_BUNK" | tr '[:lower:]' '[:upper:]')
    NEW_BUNK="$DORM_INPUT $NEW_BUNK"

    read_input "Enter Inmate's AID:" NEW_AID

    check_adb_device

    read_input "Enter BeastMode switch code:" NEW_SWITCH_CODE

    # Use sed to replace the values in the files
    sed -i "s/$NAME/$NEW_NAME/g" "$FILE1_PATH"
    sed -i "s/$CAMP/$NEW_CAMP/g" "$FILE1_PATH"
    sed -i "s/$DORM/$NEW_DORM/g" "$FILE1_PATH"
    sed -i "s/$BUNK/$NEW_BUNK/g" "$FILE1_PATH"
    sed -i "s/$AID/$NEW_AID/g" "$FILE1_PATH"
    sed -i "s/$SERIAL/$NEW_SERIAL/g" "$FILE2_PATH"
    sed -i "s/$TID/$NEW_TID/g" "$FILE2_PATH"
    sed -i "s/$SWITCH_CODE/$NEW_SWITCH_CODE/g" "$FILE3_PATH"

    echo "UI setup completed successfully!"
    echo ""
    compile_ui_menu
}

# Compile UI Menu function
compile_ui_menu() {
    echo "Please select an option:"
    if [ "$UI_COMPILED" = true ]; then
        echo "1. Compile UI [DONE] √"
    else
        echo "1. Compile UI"
    fi
    echo "2. Install UI"
    echo "3. Return to Main Menu"
    read_input "Enter your choice (1-3): " choice
    sleep 2

    case $choice in
        1)
            compile_ui
            UI_COMPILED=true
            ;;
        2)
            install_ui
            ;;
        3)
            menu
            ;;
        *)
            echo "Invalid choice. Please try again."
            compile_ui_menu
            ;;
    esac
}

# Compile UI function
compile_ui() {
    echo "Compiling UI using APKTool M..."
    sleep 2

    # Recompile the modified files using APKTool M
    apktool_m b "$APK_DECOMPILED_PATH" -o "$APK_COMPILED_PATH"

    echo "UI compiled successfully!"
}

# Install UI function
install_ui() {
    if [ -f "$APK_COMPILED_PATH" ]; then
        echo "Installing compiled UI..."
        sleep 2

        # Use adb to install the compiled APK with the -d and -r flags
        adb -d install -r "$APK_COMPILED_PATH"

        # Check if the installation was successful
        if [ $? -eq 0 ]; then
            echo "UI installed successfully!"
            menu
        else
            echo "Error: Failed to install the compiled UI."
            compile_ui_menu
        fi
    else
        echo "Error: Compiled APK file not found at $APK_COMPILED_PATH"
        compile_ui_menu
    fi
}

# Load paths function
load_paths() {
    if [ -f "$CONFIG_FILE_PATH" ]; then
        FILE1_PATH=$(sed -n '1p' "$CONFIG_FILE_PATH")
        FILE2_PATH=$(sed -n '2p' "$CONFIG_FILE_PATH")
        FILE3_PATH=$(sed -n '3p' "$CONFIG_FILE_PATH")
        BACKUP_FILE1_PATH=$(sed -n '4p' "$CONFIG_FILE_PATH")
        BACKUP_FILE2_PATH=$(sed -n '5p' "$CONFIG_FILE_PATH")
        BACKUP_FILE3_PATH=$(sed -n '6p' "$CONFIG_FILE_PATH")
        APK_DECOMPILED_PATH=$(sed -n '7p' "$CONFIG_FILE_PATH")
        APK_COMPILED_PATH=$(sed -n '8p' "$CONFIG_FILE_PATH")
    else
        initial_setup
    fi
}

# Initial setup function
initial_setup() {
    echo "Welcome to the D2U UI Setup Tool!"
    echo "This script will guide you through the initial setup process."
    echo ""
    sleep 2

    create_config_folders
    set_all_paths
}

# Function to create the D2U config and source folders
create_config_folders() {
    local D2U_PARENT_FOLDER="/sdcard/Android/data/D2U"
    local CONFIG_FOLDER="$D2U_PARENT_FOLDER/config"
    local SOURCE_FOLDER="$D2U_PARENT_FOLDER/source"

    if [ ! -d "$D2U_PARENT_FOLDER" ]; then
        mkdir "$D2U_PARENT_FOLDER"
    fi

    if [ ! -d "$CONFIG_FOLDER" ]; then
        mkdir "$CONFIG_FOLDER"
    fi

    if [ ! -d "$SOURCE_FOLDER" ]; then
        mkdir "$SOURCE_FOLDER"
    fi

    # Update the config file path to use the new location
    CONFIG_FILE_PATH="$CONFIG_FOLDER/d2u_config.txt"
}

# Function to pull files from the device
pull_files() {
    local SOURCE_PATH="$1"
    local DEST_PATH="$2"
    local FILE_NAME=$(basename "$SOURCE_PATH")

    echo "Copying $FILE_NAME from $SOURCE_PATH to $DEST_PATH..."
    adb -d pull "$SOURCE_PATH" "$DEST_PATH"
    echo "File copy completed."
}

# Function to replace the file
replace_file() {
    local SOURCE_FILE="$1"
    local DEST_FILE="$2"

    if [ -f "$SOURCE_FILE" ]; then
        cp "$SOURCE_FILE" "$DEST_FILE"
        echo "File replaced successfully."
    else
        echo "Error: Source file '$SOURCE_FILE' does not exist."
    fi
}

# Main script entry point
menu  read "$variable_name"
        if [ -n "${!variable_name}" ]; then
            break
        else
            echo "Error: Input cannot be blank. Please try again."
        fi
    done
}

# Function to add file name to the path if it's missing
add_file_name() {
    local path="$1"
    local file_name="$2"

    if ! echo "$path" | grep -q "$file_name"; then
        if [[ "$path" == */ ]]; then
            path="${path%/}/$file_name"
        else
            path="$path/$file_name"
        fi
    fi

    echo "$path"
}

# Menu function
menu() {
    echo "Welcome to the Death2Unity automated UI bot!"
    echo "Created by number 216"
    echo ""
    sleep 2

    load_paths

    echo "Please select an option:"
    echo "1. Setup UI"
    echo "2. Set File Paths"
    echo "3. Exit"
    read_input "Enter your choice (1-3): " choice
    sleep 2

    case $choice in
        1)
            setup_ui
            ;;
        2)
            set_file_paths
            ;;
        3)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            menu
            ;;
    esac
}

# Set File Paths function
set_file_paths() {
    echo "Please select an option:"
    echo "1. Edit File Paths"
    echo "2. Edit Backup Paths"
    echo "3. Edit Compilation Paths"
    echo "4. Edit All Paths"
    echo "5. Return to Main Menu"
    read_input "Enter your choice (1-5): " choice
    sleep 2

    case $choice in
        1)
            set_file_paths_only
            ;;
        2)
            set_backup_paths_only
            ;;
        3)
            set_compilation_paths_only
            ;;
        4)
            set_all_paths
            ;;
        5)
            menu
            ;;
        *)
            echo "Invalid choice. Please try again."
            set_file_paths
            ;;
    esac
}

# Set File Paths Only function
set_file_paths_only() {
    read_input "Enter the path for KeyguardPasswordView:" FILE1_PATH
    FILE1_PATH=$(add_file_name "$FILE1_PATH" "KeyguardPasswordView.smali")

    read_input "Enter the path for KeyguardAbsInputView:" FILE2_PATH
    FILE2_PATH=$(add_file_name "$FILE2_PATH" "KeyguardAbsInputView.smali")

    read_input "Enter the path for strings.xml:" FILE3_PATH
    FILE3_PATH=$(add_file_name "$FILE3_PATH" "strings.xml")

    # Save the updated paths to the configuration file
    echo "$FILE1_PATH" > "$CONFIG_FILE_PATH"
    echo "$FILE2_PATH" >> "$CONFIG_FILE_PATH"
    echo "$FILE3_PATH" >> "$CONFIG_FILE_PATH"

    echo "File paths updated successfully!"
    menu
}

# Set Backup Paths Only function
set_backup_paths_only() {
    read_input "Enter the path for KeyguardPasswordView backup:" BACKUP_FILE1_PATH
    BACKUP_FILE1_PATH=$(add_file_name "$BACKUP_FILE1_PATH" "KeyguardPasswordView.smali")

    read_input "Enter the path for KeyguardAbsInputView backup:" BACKUP_FILE2_PATH
    BACKUP_FILE2_PATH=$(add_file_name "$BACKUP_FILE2_PATH" "KeyguardAbsInputView.smali")

    read_input "Enter the path for strings.xml backup:" BACKUP_FILE3_PATH
    BACKUP_FILE3_PATH=$(add_file_name "$BACKUP_FILE3_PATH" "strings.xml")

    # Save the updated paths to the configuration file
    echo "$BACKUP_FILE1_PATH" >> "$CONFIG_FILE_PATH"
    echo "$BACKUP_FILE2_PATH" >> "$CONFIG_FILE_PATH"
    echo "$BACKUP_FILE3_PATH" >> "$CONFIG_FILE_PATH"

    echo "Backup paths updated successfully!"
    menu
}

# Set Compilation Paths Only function
set_compilation_paths_only() {
    read_input "Enter the path for decompiled APK:" APK_DECOMPILED_PATH
    read_input "Enter the path for compiled APK:" APK_COMPILED_PATH

    # Save the updated paths to the configuration file
    echo "$APK_DECOMPILED_PATH" >> "$CONFIG_FILE_PATH"
    echo "$APK_COMPILED_PATH" >> "$CONFIG_FILE_PATH"

    echo "Compilation paths updated successfully!"
    menu
}

# Menu function
menu() {
    echo "Welcome to the Death2Unity automated UI bot!"
    echo "Created by number 216"
    echo ""
    sleep 2

    load_paths

    echo "Please select an option:"
    echo "1. Setup UI"
    echo "2. Set File Paths"
    echo "3. Exit"
    read_input "Enter your choice (1-3): " choice
    sleep 2

    case $choice in
        1)
            setup_ui
            ;;
        2)
            set_file_paths
            ;;
        3)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            menu
            ;;
    esac
}

# Setup UI function
setup_ui() {
    echo "Setup UI"
    echo "========"
    sleep 2

    read_input "Enter Inmate's NAME (e.g., JOHNNY CHAINGANG):" NEW_NAME
    NEW_NAME=$(echo "$NEW_NAME" | tr '[:lower:]' '[:upper:]')
    read_input "Enter Inmate's DC Number (e.g., N12345 or 123456):" NEW_DC
    if echo "$NEW_DC" | grep -q '^[a-zA-Z]'; then
        NEW_DC=$(echo "$NEW_DC" | tr '[:lower:]' '[:upper:]')
    fi
    NEW_NAME="$NEW_NAME $NEW_DC"

    read_input "Enter Inmate's CAMP (e.g., Everglades CI):" NEW_CAMP
    NEW_CAMP=$(echo "$NEW_CAMP" | sed 's/\b\(.\)/\u\1/g')
    NEW_CAMP="$NEW_CAMP, FL"

    read_input "Enter Inmate's DORM (e.g., A1):" DORM_INPUT
    if ! echo "$DORM_INPUT" | grep -q '^[A-Z][0-9]$'; then
        echo "Error: DORM value must be one letter followed by one number (e.g., A1)."
        return
    fi
    NEW_DORM="$DORM_INPUT Dorm, "

    read_input "Enter Inmate's BUNK (u for upper, l for lower, or s for single):" NEW_BUNK
    if ! echo "$NEW_BUNK" | grep -q '^[ULS]$'; then
        echo "Error: BUNK value must be u, l, or s."
        return
    fi
    NEW_BUNK=$(echo "$NEW_BUNK" | tr '[:lower:]' '[:upper:]')
    NEW_BUNK="$DORM_INPUT $NEW_BUNK"

    read_input "Enter Inmate's AID:" NEW_AID

    check_adb_device

    read_input "Enter BeastMode switch code:" NEW_SWITCH_CODE

    # Use sed to replace the values in the files
    sed -i "s/$NAME/$NEW_NAME/g" "$FILE1_PATH"
    sed -i "s/$CAMP/$NEW_CAMP/g" "$FILE1_PATH"
    sed -i "s/$DORM/$NEW_DORM/g" "$FILE1_PATH"
    sed -i "s/$BUNK/$NEW_BUNK/g" "$FILE1_PATH"
    sed -i "s/$AID/$NEW_AID/g" "$FILE1_PATH"
    sed -i "s/$SERIAL/$NEW_SERIAL/g" "$FILE2_PATH"
    sed -i "s/$TID/$NEW_TID/g" "$FILE2_PATH"
    sed -i "s/$SWITCH_CODE/$NEW_SWITCH_CODE/g" "$FILE3_PATH"

    echo "UI setup completed successfully!"
    echo ""
    compile_ui_menu
}

# Compile UI Menu function
compile_ui_menu() {
    echo "Please select an option:"
    if [ "$UI_COMPILED" = true ]; then
        echo "1. Compile UI [DONE] √"
    else
        echo "1. Compile UI"
    fi
    echo "2. Install UI"
    echo "3. Return to Main Menu"
    read_input "Enter your choice (1-3): " choice
    sleep 2

    case $choice in
        1)
            compile_ui
            UI_COMPILED=true
            ;;
        2)
            install_ui
            ;;
        3)
            menu
            ;;
        *)
            echo "Invalid choice. Please try again."
            compile_ui_menu
            ;;
    esac
}

# Compile UI function
compile_ui() {
    echo "Compiling UI using APKTool M..."
    sleep 2

    # Recompile the modified files using APKTool M
    apktool_m b "$APK_DECOMPILED_PATH" -o "$APK_COMPILED_PATH"

    echo "UI compiled successfully!"
}

# Install UI function
install_ui() {
    if [ -f "$APK_COMPILED_PATH" ]; then
        echo "Installing compiled UI..."
        sleep 2

        # Use adb to install the compiled APK with the -d and -r flags
        adb -d install -r "$APK_COMPILED_PATH"

        # Check if the installation was successful
        if [ $? -eq 0 ]; then
            echo "UI installed successfully!"
            menu
        else
            echo "Error: Failed to install the compiled UI."
            compile_ui_menu
        fi
    else
        echo "Error: Compiled APK file not found at $APK_COMPILED_PATH"
        compile_ui_menu
    fi
}

# Compile UI Menu function
compile_ui_menu() {
    echo "Please select an option:"
    if [ "$UI_COMPILED" = true ]; then
        echo "1. Compile UI [DONE] √"
    else
        echo "1. Compile UI"
    fi
    echo "2. Install UI"
    echo "3. Return to Main Menu"
    read_input "Enter your choice (1-3): " choice
    sleep 2

    case $choice in
        1)
            compile_ui
            UI_COMPILED=true
            ;;
        2)
            install_ui
            ;;
        3)
            menu
            ;;
        *)
            echo "Invalid choice. Please try again."
            compile_ui_menu
            ;;
    esac
}

# Compile UI function
compile_ui() {
    echo "Compiling UI using APKTool M..."
    sleep 2

    # Recompile the modified files using APKTool M
    apktool_m b "$APK_DECOMPILED_PATH" -o "$APK_COMPILED_PATH"

    echo "UI compiled successfully!"
}

# Function to check for ADB device
check_adb_device() {
    if adb devices | grep -q "device"; then
        echo "Device found. Pulling serial number and TID files..."
        # Create a temporary folder and pull the serial number and TID files
        TEMP_FOLDER="/sdcard/temp"
        mkdir "$TEMP_FOLDER"
        SERIAL_FILE_PATH="$TEMP_FOLDER/serialno"
        TID_FILE_PATH="$TEMP_FOLDER/tid"
        pull_files "/sys/kernel/jp6/serialno" "$SERIAL_FILE_PATH"
        pull_files "/sys/kernel/jp6/tid" "$TID_FILE_PATH"

        # Read the serial number and TID from the pulled files
        NEW_SERIAL=$(cat "$SERIAL_FILE_PATH")
        NEW_TID=$(cat "$TID_FILE_PATH")

        # Remove the temporary folder
        rm -rf "$TEMP_FOLDER"
        echo "File pull successful."
    else
        echo "No connected device found."
        echo "Please select an option:"
        echo "1. Enter values manually"
        echo "2. Check for device again"
        echo "3. Exit Setup UI"
        read_input "Enter your choice (1-3): " no_device_choice
        case $no_device_choice in
            1)
                read_input "Enter the serial number:" NEW_SERIAL
                read_input "Enter the TID:" NEW_TID
                ;;
            2)
                check_adb_device
                ;;
            3)
                echo "Exiting Setup UI..."
                return
                ;;
            *)
                echo "Invalid choice. Exiting Setup UI..."
                return
                ;;
        esac
    fi
}

# Setup UI function
setup_ui() {
    echo "Setup UI"
    echo "========"
    sleep 2

    # Hardcode the placeholder values
    NAME="USER NAME XX"
    CAMP="MY CAMP XX"
    DORM="MY DORM XX"
    BUNK="MY BUNK XX"
    AID="MY AID XX"
    SERIAL="MY SERIAL XX"
    TID="MY TID XX"
    SWITCH_CODE="MY SWITCH CODE XX"

    read_input "Enter Inmate's NAME (e.g., JOHNNY CHAINGANG):" NEW_NAME
    NEW_NAME=$(echo "$NEW_NAME" | tr '[:lower:]' '[:upper:]')

    read_input "Enter Inmate's DC Number (e.g., N12345 or 123456):" NEW_DC
    if echo "$NEW_DC" | grep -q '^[a-zA-Z]'; then
        NEW_DC=$(echo "$NEW_DC" | tr '[:lower:]' '[:upper:]')
    fi
    NAME="$NEW_NAME $NEW_DC"

    read_input "Enter Inmate's CAMP (e.g., Everglades CI):" NEW_CAMP
    NEW_CAMP=$(echo "$NEW_CAMP" | sed 's/\b\(.\)/\u\1/g')
    CAMP="$NEW_CAMP XX"

    read_input "Enter Inmate's DORM (e.g., A1):" DORM_INPUT
    if ! echo "$DORM_INPUT" | grep -q '^[A-Z][0-9]$'; then
        echo "Error: DORM value must be one letter followed by one number (e.g., A1)."
        return
    fi
    DORM="$DORM_INPUT Dorm XX"

    read_input "Enter Inmate's BUNK (u for upper, l for lower, or s for single):" NEW_BUNK
    if ! echo "$NEW_BUNK" | grep -q '^[ULS]$'; then
        echo "Error: BUNK value must be u, l, or s."
        return
    fi
    BUNK="$DORM_INPUT $NEW_BUNK XX"

    read_input "Enter Inmate's AID:" NEW_AID
    AID="MY AID XX"

    check_adb_device

    read_input "Enter BeastMode switch code:" NEW_SWITCH_CODE
    SWITCH_CODE="MY SWITCH CODE XX"

    # Use sed to replace the values in the files
    sed -i "s/$NAME/$NAME/g" "$FILE1_PATH"
    sed -i "s/$CAMP/$CAMP/g" "$FILE1_PATH"
    sed -i "s/$DORM/$DORM/g" "$FILE1_PATH"
    sed -i "s/$BUNK/$BUNK/g" "$FILE1_PATH"
    sed -i "s/$AID/$AID/g" "$FILE1_PATH"
    sed -i "s/$SERIAL/$SERIAL/g" "$FILE2_PATH"
    sed -i "s/$TID/$TID/g" "$FILE2_PATH"
    sed -i "s/$SWITCH_CODE/$SWITCH_CODE/g" "$FILE3_PATH"

    echo "UI setup completed successfully!"
    echo ""
    compile_ui_menu
}

# Menu function
menu() {
    echo "Welcome to the Death2Unity automated UI bot!"
    echo "Created by number 216"
    echo ""
    sleep 2

    load_paths

    echo "Please select an option:"
    echo "1. Setup UI"
    echo "2. Set File Paths"
    echo "3. Exit"
    read_input "Enter your choice (1-3): " choice
    sleep 2

    case $choice in
        1)
            setup_ui
            ;;
        2)
            set_file_paths
            ;;
        3)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            menu
            ;;
    esac
}

# Load paths function
load_paths() {
    if [ -f "$CONFIG_FILE_PATH" ]; then
        FILE1_PATH=$(sed -n '1p' "$CONFIG_FILE_PATH")
        FILE2_PATH=$(sed -n '2p' "$CONFIG_FILE_PATH")
        FILE3_PATH=$(sed -n '3p' "$CONFIG_FILE_PATH")
        BACKUP_FILE1_PATH=$(sed -n '4p' "$CONFIG_FILE_PATH")
        BACKUP_FILE2_PATH=$(sed -n '5p' "$CONFIG_FILE_PATH")
        BACKUP_FILE3_PATH=$(sed -n '6p' "$CONFIG_FILE_PATH")
        APK_DECOMPILED_PATH=$(sed -n '7p' "$CONFIG_FILE_PATH")
        APK_COMPILED_PATH=$(sed -n '8p' "$CONFIG_FILE_PATH")
    else
        initial_setup
    fi
}

# Initial setup function
initial_setup() {
    echo "Welcome to the D2U UI Setup Tool!"
    echo "This script will guide you through the initial setup process."
    echo ""
    sleep 2

    create_config_folders
    set_all_paths
}

# Function to create the D2U config and source folders
create_config_folders() {
    local D2U_PARENT_FOLDER="/sdcard/Android/data/D2U"
    local CONFIG_FOLDER="$D2U_PARENT_FOLDER/config"
    local SOURCE_FOLDER="$D2U_PARENT_FOLDER/source"

    if [ ! -d "$D2U_PARENT_FOLDER" ]; then
        mkdir "$D2U_PARENT_FOLDER"
    fi

    if [ ! -d "$CONFIG_FOLDER" ]; then
        mkdir "$CONFIG_FOLDER"
    fi

    if [ ! -d "$SOURCE_FOLDER" ]; then
        mkdir "$SOURCE_FOLDER"
    fi

    # Update the config file path to use the new location
    CONFIG_FILE_PATH="$CONFIG_FOLDER/d2u_config.txt"
}

# Function to pull files from the device
pull_files() {
    local SOURCE_PATH="$1"
    local DEST_PATH="$2"
    local FILE_NAME=$(basename "$SOURCE_PATH")

    echo "Copying $FILE_NAME from $SOURCE_PATH to $DEST_PATH..."
    adb -d pull "$SOURCE_PATH" "$DEST_PATH"
    echo "File copy completed."
}

# Function to replace the file
replace_file() {
    local SOURCE_FILE="$1"
    local DEST_FILE="$2"

    if [ -f "$SOURCE_FILE" ]; then
        cp "$SOURCE_FILE" "$DEST_FILE"
        echo "File replaced successfully."
    else
        echo "Error: Source file '$SOURCE_FILE' does not exist."
    fi
}

# Main script entry point
menu > "$CONFIG_FILE_PATH"
    echo "$FILE2_PATH" >> "$CONFIG_FILE_PATH"
    echo "$FILE3_PATH" >> "$CONFIG_FILE_PATH"

    echo "File paths updated successfully!"
    menu
}

# Set Backup Paths Only function
set_backup_paths_only() {
    read_input "Enter the path for KeyguardPasswordView backup:" BACKUP_FILE1_PATH
    BACKUP_FILE1_PATH=$(add_file_name "$BACKUP_FILE1_PATH" "KeyguardPasswordView.smali")

    read_input "Enter the path for KeyguardAbsInputView backup:" BACKUP_FILE2_PATH
    BACKUP_FILE2_PATH=$(add_file_name "$BACKUP_FILE2_PATH" "KeyguardAbsInputView.smali")

    read_input "Enter the path for strings.xml backup:" BACKUP_FILE3_PATH
    BACKUP_FILE3_PATH=$(add_file_name "$BACKUP_FILE3_PATH" "strings.xml")

    # Save the updated paths to the configuration file
    echo "$BACKUP_FILE1_PATH" >> "$CONFIG_FILE_PATH"
    echo "$BACKUP_FILE2_PATH" >> "$CONFIG_FILE_PATH"
    echo "$BACKUP_FILE3_PATH" >> "$CONFIG_FILE_PATH"

    echo "Backup paths updated successfully!"
    menu
}

# Set Compilation Paths Only function
set_compilation_paths_only() {
    read_input "Enter the path for decompiled APK:" APK_DECOMPILED_PATH
    read_input "Enter the path for compiled APK:" APK_COMPILED_PATH

    # Save the updated paths to the configuration file
    echo "$APK_DECOMPILED_PATH" >> "$CONFIG_FILE_PATH"
    echo "$APK_COMPILED_PATH" >> "$CONFIG_FILE_PATH"

    echo "Compilation paths updated successfully!"
    menu
}

# Set All Paths function
set_all_paths() {
    echo "Please enter the following file paths:"
    read_input "Enter the path for KeyguardPasswordView:" FILE1_PATH
    FILE1_PATH=$(add_file_name "$FILE1_PATH" "KeyguardPasswordView.smali")

    read_input "Enter the path for KeyguardAbsInputView:" FILE2_PATH
    FILE2_PATH=$(add_file_name "$FILE2_PATH" "KeyguardAbsInputView.smali")

    read_input "Enter the path for strings.xml:" FILE3_PATH
    FILE3_PATH=$(add_file_name "$FILE3_PATH" "strings.xml")

    read_input "Enter the path for KeyguardPasswordView backup:" BACKUP_FILE1_PATH
    BACKUP_FILE1_PATH=$(add_file_name "$BACKUP_FILE1_PATH" "KeyguardPasswordView.smali")

    read_input "Enter the path for KeyguardAbsInputView backup:" BACKUP_FILE2_PATH
    BACKUP_FILE2_PATH=$(add_file_name "$BACKUP_FILE2_PATH" "KeyguardAbsInputView.smali")

    read_input "Enter the path for strings.xml backup:" BACKUP_FILE3_PATH
    BACKUP_FILE3_PATH=$(add_file_name "$BACKUP_FILE3_PATH" "strings.xml")

    read_input "Enter the path for decompiled APK:" APK_DECOMPILED_PATH
    read_input "Enter the path for compiled APK:" APK_COMPILED_PATH

    # Save the updated paths to the configuration file
    echo "$FILE1_PATH" > "$CONFIG_FILE_PATH"
    echo "$FILE2_PATH" >> "$CONFIG_FILE_PATH"
    echo "$FILE3_PATH" >> "$CONFIG_FILE_PATH"
    echo "$BACKUP_FILE1_PATH" >> "$CONFIG_FILE_PATH"
    echo "$BACKUP_FILE2_PATH" >> "$CONFIG_FILE_PATH"
    echo "$BACKUP_FILE3_PATH" >> "$CONFIG_FILE_PATH"
    echo "$APK_DECOMPILED_PATH" >> "$CONFIG_FILE_PATH"
    echo "$APK_COMPILED_PATH" >> "$CONFIG_FILE_PATH"

    echo "All paths updated successfully!"
    menu
}

# Menu function
menu() {
    echo "Welcome to the Death2Unity automated UI bot!"
    echo "Created by number 216"
    echo ""
    sleep 2

    load_paths

    echo "Please select an option:"
    echo "1. Setup UI"
    echo "2. Set File Paths"
    echo "3. Exit"
    read_input "Enter your choice (1-3): " choice
    sleep 2

    case $choice in
        1)
            setup_ui
            ;;
        2)
            set_file_paths
            ;;
        3)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            menu
            ;;
    esac
}

# Start the script
menu
