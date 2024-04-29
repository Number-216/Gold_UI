.class public Lcom/android/keyguard/KeyguardPasswordView;
.super Lcom/android/keyguard/KeyguardAbsKeyInputView;
.source "KeyguardPasswordView.java"

# interfaces
.implements Lcom/android/keyguard/KeyguardSecurityView;
.implements Landroid/widget/TextView$OnEditorActionListener;
.implements Landroid/text/TextWatcher;


# instance fields
.field private final mDisappearYTranslation:I

.field private mFastOutLinearInInterpolator:Landroid/view/animation/Interpolator;

.field mImm:Landroid/view/inputmethod/InputMethodManager;

.field private mLinearOutSlowInInterpolator:Landroid/view/animation/Interpolator;

.field private mPasswordEntry:Landroid/widget/EditText;

.field private mPasswordEntryDisabler:Lcom/android/internal/widget/TextViewInputDisabler;

.field private final mShowImeAtScreenOn:Z

.field private mSwitchImeButton:Landroid/view/View;

.field private mHandler:Landroid/os/Handler;

.field private mWaitRunnable:Ljava/lang/Runnable;

.field private mWrongPass:Z

.field private mProgressBar:Landroid/widget/ProgressBar;

.field private mPassHidden:Z

.field private mContent1:Landroid/view/View;

.field private mContent2:Landroid/view/View;

.field private mContent3:Landroid/view/View;

.field private mContent4:Landroid/view/View;

.field private mEyeButton:Landroid/view/View;

.field private mEyeButtonOff:Landroid/view/View;

.field private mInmateName:Landroid/widget/TextView;

.field private mInmateCamp:Landroid/widget/TextView;

.field private mInmateDorm:Landroid/widget/TextView;

.field private mInmateBunk:Landroid/widget/TextView;

.field private mInmateAid:Landroid/widget/TextView;

# direct methods
.method static synthetic -get0(Lcom/android/keyguard/KeyguardPasswordView;)Landroid/widget/TextView;
    .locals 1

    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic -get1(Lcom/android/keyguard/KeyguardPasswordView;)Z
    .locals 1

    iget-boolean v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mShowImeAtScreenOn:Z

    return v0
.end method

.method static synthetic -get2(Lcom/android/keyguard/KeyguardPasswordView;)Landroid/os/Handler;
    .locals 1

    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mHandler:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic -get3(Lcom/android/keyguard/KeyguardPasswordView;)Ljava/lang/Runnable;
    .locals 1

    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mWaitRunnable:Ljava/lang/Runnable;

    return-object v0
.end method

.method static synthetic -get4(Lcom/android/keyguard/KeyguardPasswordView;)Z
    .locals 1

    iget-boolean v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mWrongPass:Z

    return v0
.end method

.method static synthetic -wrap0(Lcom/android/keyguard/KeyguardPasswordView;)V
    .locals 0

    invoke-direct {p0}, Lcom/android/keyguard/KeyguardPasswordView;->updateSwitchImeButton()V

    return-void
.end method

.method static synthetic -wrap1(Lcom/android/keyguard/KeyguardPasswordView;)V
    .locals 0

    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->verifyPasswordAndUnlock()V

    return-void
.end method

.method static synthetic -wrap2(Lcom/android/keyguard/KeyguardPasswordView;)V
    .locals 0

    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->stopdelay()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 65
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/android/keyguard/KeyguardPasswordView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 66
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 2

    .prologue
    .line 69
    invoke-direct {p0, p1, p2}, Lcom/android/keyguard/KeyguardAbsKeyInputView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    new-instance v0, Lcom/android/keyguard/KeyguardPasswordView$6;

    invoke-direct {v0, p0}, Lcom/android/keyguard/KeyguardPasswordView$6;-><init>(Lcom/android/keyguard/KeyguardPasswordView;)V

    iput-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mWaitRunnable:Ljava/lang/Runnable;

    .line 70
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 71
    const v1, 0x7f050037

    .line 70
    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v0

    iput-boolean v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mShowImeAtScreenOn:Z

    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f05003e

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v0

    iput-boolean v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPassHidden:Z

    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f05003f

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v0

    iput-boolean v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mWrongPass:Z

    .line 72
    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 73
    const v1, 0x7f0700a9

    .line 72
    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    iput v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mDisappearYTranslation:I

    .line 75
    const v0, 0x10c000e

    .line 74
    invoke-static {p1, v0}, Landroid/view/animation/AnimationUtils;->loadInterpolator(Landroid/content/Context;I)Landroid/view/animation/Interpolator;

    move-result-object v0

    iput-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mLinearOutSlowInInterpolator:Landroid/view/animation/Interpolator;

    .line 77
    const v0, 0x10c000f

    .line 76
    invoke-static {p1, v0}, Landroid/view/animation/AnimationUtils;->loadInterpolator(Landroid/content/Context;I)Landroid/view/animation/Interpolator;

    move-result-object v0

    iput-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mFastOutLinearInInterpolator:Landroid/view/animation/Interpolator;

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mHandler:Landroid/os/Handler;

    .line 78
    return-void
.end method

.method private hasMultipleEnabledIMEsOrSubtypes(Landroid/view/inputmethod/InputMethodManager;Z)Z
    .locals 8

    .prologue
    const/4 v2, 0x0

    const/4 v4, 0x1

    .line 258
    invoke-virtual {p1}, Landroid/view/inputmethod/InputMethodManager;->getEnabledInputMethodList()Ljava/util/List;

    move-result-object v0

    .line 263
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v5

    move v1, v2

    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/inputmethod/InputMethodInfo;

    .line 265
    if-le v1, v4, :cond_0

    return v4

    .line 267
    :cond_0
    invoke-virtual {p1, v0, v4}, Landroid/view/inputmethod/InputMethodManager;->getEnabledInputMethodSubtypeList(Landroid/view/inputmethod/InputMethodInfo;Z)Ljava/util/List;

    move-result-object v6

    .line 269
    invoke-interface {v6}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 270
    add-int/lit8 v1, v1, 0x1

    move v0, v1

    :goto_1
    move v1, v0

    goto :goto_0

    .line 275
    :cond_1
    invoke-interface {v6}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v7

    move v3, v2

    :goto_2
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/inputmethod/InputMethodSubtype;

    .line 276
    invoke-virtual {v0}, Landroid/view/inputmethod/InputMethodSubtype;->isAuxiliary()Z

    move-result v0

    if-eqz v0, :cond_8

    .line 277
    add-int/lit8 v0, v3, 0x1

    :goto_3
    move v3, v0

    goto :goto_2

    .line 280
    :cond_2
    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v0

    sub-int/2addr v0, v3

    .line 285
    if-gtz v0, :cond_3

    if-eqz p2, :cond_4

    if-le v3, v4, :cond_4

    .line 286
    :cond_3
    add-int/lit8 v1, v1, 0x1

    move v0, v1

    .line 287
    goto :goto_1

    :cond_4
    move v0, v1

    .line 285
    goto :goto_1

    .line 291
    :cond_5
    if-gt v1, v4, :cond_7

    .line 294
    const/4 v0, 0x0

    invoke-virtual {p1, v0, v2}, Landroid/view/inputmethod/InputMethodManager;->getEnabledInputMethodSubtypeList(Landroid/view/inputmethod/InputMethodInfo;Z)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-le v0, v4, :cond_6

    move v2, v4

    .line 291
    :cond_6
    :goto_4
    return v2

    :cond_7
    move v2, v4

    goto :goto_4

    :cond_8
    move v0, v3

    goto :goto_3
.end method

.method private updateSwitchImeButton()V
    .locals 4

    .prologue
    const/4 v2, 0x0

    .line 151
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mSwitchImeButton:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x1

    .line 152
    :goto_0
    iget-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mImm:Landroid/view/inputmethod/InputMethodManager;

    invoke-direct {p0, v1, v2}, Lcom/android/keyguard/KeyguardPasswordView;->hasMultipleEnabledIMEsOrSubtypes(Landroid/view/inputmethod/InputMethodManager;Z)Z

    move-result v1

    .line 153
    if-eq v0, v1, :cond_0

    .line 154
    iget-object v3, p0, Lcom/android/keyguard/KeyguardPasswordView;->mSwitchImeButton:Landroid/view/View;

    if-eqz v1, :cond_3

    move v0, v2

    :goto_1
    invoke-virtual {v3, v0}, Landroid/view/View;->setVisibility(I)V

    .line 160
    :cond_0
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mSwitchImeButton:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_1

    .line 161
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/TextView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    .line 162
    instance-of v0, v1, Landroid/view/ViewGroup$MarginLayoutParams;

    if-eqz v0, :cond_1

    move-object v0, v1

    .line 163
    check-cast v0, Landroid/view/ViewGroup$MarginLayoutParams;

    .line 164
    invoke-virtual {v0, v2}, Landroid/view/ViewGroup$MarginLayoutParams;->setMarginStart(I)V

    .line 165
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 168
    :cond_1
    return-void

    :cond_2
    move v0, v2

    .line 151
    goto :goto_0

    .line 154
    :cond_3
    const/16 v0, 0x0

    goto :goto_1
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 1

    .prologue
    .line 343
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 344
    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->onUserInput()V

    .line 346
    :cond_0
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 1

    .prologue
    .line 330
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mCallback:Lcom/android/keyguard/KeyguardSecurityCallback;

    if-eqz v0, :cond_0

    .line 331
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mCallback:Lcom/android/keyguard/KeyguardSecurityCallback;

    invoke-interface {v0}, Lcom/android/keyguard/KeyguardSecurityCallback;->userActivity()V

    .line 333
    :cond_0
    return-void
.end method

.method protected getPasswordText()Ljava/lang/String;
    .locals 1

    .prologue
    .line 236
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected getPasswordTextViewId()I
    .locals 1

    .prologue
    .line 93
    const v0, 0x7f0a01e1

    return v0
.end method

.method protected getPromtReasonStringRes(I)I
    .locals 1

    .prologue
    const v0, 0x7f1102c5

    .line 121
    packed-switch p1, :pswitch_data_0

    .line 133
    return v0

    .line 123
    :pswitch_0
    const v0, 0x7f1102bf

    return v0

    .line 125
    :pswitch_1
    return v0

    .line 127
    :pswitch_2
    const v0, 0x7f1102be

    return v0

    .line 129
    :pswitch_3
    const v0, 0x7f1102c8

    return v0

    .line 131
    :pswitch_4
    const/4 v0, 0x0

    return v0

    .line 121
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method public getWrongPasswordStringId()I
    .locals 1

    .prologue
    .line 303
    const v0, 0x7f1102d5

    return v0
.end method

.method public needsInput()Z
    .locals 1

    .prologue
    .line 98
    const/4 v0, 0x1

    return v0
.end method

.method public onEditorAction(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 6

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 351
    if-nez p3, :cond_5

    .line 352
    if-eqz p2, :cond_0

    .line 353
    const/4 v0, 0x6

    if-ne p2, v0, :cond_3

    :cond_0
    move v3, v1

    .line 355
    :goto_0
    if-eqz p3, :cond_7

    .line 356
    invoke-virtual {p3}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result v0

    invoke-static {v0}, Landroid/view/KeyEvent;->isConfirmKey(I)Z

    move-result v0

    .line 355
    if-eqz v0, :cond_7

    .line 357
    invoke-virtual {p3}, Landroid/view/KeyEvent;->getAction()I

    move-result v0

    if-nez v0, :cond_6

    move v0, v1

    .line 358
    :goto_1
    if-nez v3, :cond_1

    if-eqz v0, :cond_8

    .line 359
    :cond_1
    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->checkBlank()I

    move-result v4

    if-eqz v4, :cond_2

    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->showSpinner()V

    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->delay()V

    .line 360
    return v1

    :cond_2
    return v2

    .line 354
    :cond_3
    const/4 v0, 0x5

    if-ne p2, v0, :cond_4

    move v3, v1

    goto :goto_0

    :cond_4
    move v3, v2

    goto :goto_0

    :cond_5
    move v3, v2

    .line 351
    goto :goto_0

    :cond_6
    move v0, v2

    .line 357
    goto :goto_1

    :cond_7
    move v0, v2

    .line 355
    goto :goto_1

    .line 362
    :cond_8
    return v2
.end method

.method protected onFinishInflate()V
    .locals 4

    .prologue
    .line 172
    invoke-super {p0}, Lcom/android/keyguard/KeyguardAbsKeyInputView;->onFinishInflate()V

    .line 174


    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 175
    const-string/jumbo v1, "input_method"

    .line 174
    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/inputmethod/InputMethodManager;

    iput-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mImm:Landroid/view/inputmethod/InputMethodManager;

    .line 177
    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->getPasswordTextViewId()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/android/keyguard/KeyguardPasswordView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    .line 178
    new-instance v0, Lcom/android/internal/widget/TextViewInputDisabler;

    iget-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    invoke-direct {v0, v1}, Lcom/android/internal/widget/TextViewInputDisabler;-><init>(Landroid/widget/TextView;)V

    iput-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntryDisabler:Lcom/android/internal/widget/TextViewInputDisabler;

    .line 179
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    invoke-static {}, Landroid/text/method/TextKeyListener;->getInstance()Landroid/text/method/TextKeyListener;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setKeyListener(Landroid/text/method/KeyListener;)V

    .line 180
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    const/16 v1, 0x12

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setInputType(I)V

    const v0, 0x7f0a030c

    invoke-virtual {p0, v0}, Lcom/android/keyguard/KeyguardPasswordView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ProgressBar;

    iput-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mProgressBar:Landroid/widget/ProgressBar;

    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->setupInmateFields()V

    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->setInmateInfo()V

    .line 12345
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    const-string/jumbo v1, "Login"

    const/16 v2, 0x42

    invoke-virtual {v0, v1, v2}, Landroid/widget/TextView;->setImeActionLabel(Ljava/lang/CharSequence;I)V

    .line 182
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    .line 183
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 186
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    new-instance v1, Lcom/android/keyguard/KeyguardPasswordView$2;

    invoke-direct {v1, p0}, Lcom/android/keyguard/KeyguardPasswordView$2;-><init>(Lcom/android/keyguard/KeyguardPasswordView;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 194
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    const/4 v1, 0x1

    .line 196
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    .line 198
    const v0, 0x7f0a027a

    invoke-virtual {p0, v0}, Lcom/android/keyguard/KeyguardPasswordView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mSwitchImeButton:Landroid/view/View;

    .line 199
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mSwitchImeButton:Landroid/view/View;

    new-instance v1, Lcom/android/keyguard/KeyguardPasswordView$3;

    invoke-direct {v1, p0}, Lcom/android/keyguard/KeyguardPasswordView$3;-><init>(Lcom/android/keyguard/KeyguardPasswordView;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 200
    const v0, 0x7f0a030a

    invoke-virtual {p0, v0}, Lcom/android/keyguard/KeyguardPasswordView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mEyeButton:Landroid/view/View;

    .line 201
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mEyeButton:Landroid/view/View;

    new-instance v1, Lcom/android/keyguard/KeyguardPasswordView$5;

    invoke-direct {v1, p0}, Lcom/android/keyguard/KeyguardPasswordView$5;-><init>(Lcom/android/keyguard/KeyguardPasswordView;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0a030b

    invoke-virtual {p0, v0}, Lcom/android/keyguard/KeyguardPasswordView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mEyeButtonOff:Landroid/view/View;

    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mEyeButtonOff:Landroid/view/View;

    new-instance v1, Lcom/android/keyguard/KeyguardPasswordView$5;

    invoke-direct {v1, p0}, Lcom/android/keyguard/KeyguardPasswordView$5;-><init>(Lcom/android/keyguard/KeyguardPasswordView;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 209
    invoke-direct {p0}, Lcom/android/keyguard/KeyguardPasswordView;->updateSwitchImeButton()V

    .line 215
    new-instance v0, Lcom/android/keyguard/KeyguardPasswordView$4;

    invoke-direct {v0, p0}, Lcom/android/keyguard/KeyguardPasswordView$4;-><init>(Lcom/android/keyguard/KeyguardPasswordView;)V

    .line 220
    const-wide/16 v2, 0x1f4

    .line 215
    invoke-virtual {p0, v0, v2, v3}, Lcom/android/keyguard/KeyguardPasswordView;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 221
    return-void
.end method

.method public onPause()V
    .locals 3

    .prologue
    .line 139
    invoke-super {p0}, Lcom/android/keyguard/KeyguardAbsKeyInputView;->onPause()V

    .line 140
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mImm:Landroid/view/inputmethod/InputMethodManager;

    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->getWindowToken()Landroid/os/IBinder;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/inputmethod/InputMethodManager;->hideSoftInputFromWindow(Landroid/os/IBinder;I)Z

    .line 141
    return-void
.end method

.method protected onRequestFocusInDescendants(ILandroid/graphics/Rect;)Z
    .locals 1

    .prologue
    .line 226
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    invoke-virtual {v0, p1, p2}, Landroid/widget/TextView;->requestFocus(ILandroid/graphics/Rect;)Z

    move-result v0

    return v0
.end method

.method public onResume(I)V
    .locals 1

    .prologue
    .line 103
    invoke-super {p0, p1}, Lcom/android/keyguard/KeyguardAbsKeyInputView;->onResume(I)V

    .line 106
    new-instance v0, Lcom/android/keyguard/KeyguardPasswordView$1;

    invoke-direct {v0, p0, p1}, Lcom/android/keyguard/KeyguardPasswordView$1;-><init>(Lcom/android/keyguard/KeyguardPasswordView;I)V

    invoke-virtual {p0, v0}, Lcom/android/keyguard/KeyguardPasswordView;->post(Ljava/lang/Runnable;)Z

    .line 117
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .prologue
    .line 337
    return-void
.end method

.method public reset()V
    .locals 1

    .prologue
    .line 145
    invoke-super {p0}, Lcom/android/keyguard/KeyguardAbsKeyInputView;->reset()V

    .line 146
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    .line 147
    return-void
.end method

.method protected resetPasswordText(ZZ)V
    .locals 2

    .prologue
    .line 231
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    const-string/jumbo v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->hideSpinner()V

    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->resetdelay()V
    .line 232
    return-void
.end method

.method protected resetState()V
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 82
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mSecurityMessageDisplay:Lcom/android/keyguard/SecurityMessageDisplay;

    const-string/jumbo v1, "Enter Password"

    invoke-interface {v0, v1}, Lcom/android/keyguard/SecurityMessageDisplay;->setMessage(Ljava/lang/CharSequence;)V

    .line 83
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/TextView;->isEnabled()Z

    move-result v0

    .line 84
    invoke-virtual {p0, v2}, Lcom/android/keyguard/KeyguardPasswordView;->setPasswordEntryEnabled(Z)V

    .line 85
    invoke-virtual {p0, v2}, Lcom/android/keyguard/KeyguardPasswordView;->setPasswordEntryInputEnabled(Z)V

    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->hide_pass()V

    .line 86
    if-eqz v0, :cond_0

    .line 87
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mImm:Landroid/view/inputmethod/InputMethodManager;

    iget-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    .line 12345
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    const-string/jumbo v1, "Login"

    const/16 v2, 0x42

    invoke-virtual {v0, v1, v2}, Landroid/widget/TextView;->setImeActionLabel(Ljava/lang/CharSequence;I)V

    .line 89
    :cond_0
    return-void
.end method

.method protected setPasswordEntryEnabled(Z)V
    .locals 1

    .prologue
    .line 241
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setEnabled(Z)V

    .line 242
    return-void
.end method

.method protected setPasswordEntryInputEnabled(Z)V
    .locals 1

    .prologue
    .line 246
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntryDisabler:Lcom/android/internal/widget/TextViewInputDisabler;

    invoke-virtual {v0, p1}, Lcom/android/internal/widget/TextViewInputDisabler;->setInputEnabled(Z)V

    .line 247
    return-void
.end method

.method public startAppearAnimation()V
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 308
    invoke-virtual {p0, v0}, Lcom/android/keyguard/KeyguardPasswordView;->setAlpha(F)V

    .line 309
    invoke-virtual {p0, v0}, Lcom/android/keyguard/KeyguardPasswordView;->setTranslationY(F)V

    .line 310
    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    .line 311
    const/high16 v1, 0x3f800000    # 1.0f

    .line 310
    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewPropertyAnimator;->withLayer()Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    .line 313
    const-wide/16 v2, 0x12c

    .line 310
    invoke-virtual {v0, v2, v3}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    .line 314
    iget-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mLinearOutSlowInInterpolator:Landroid/view/animation/Interpolator;

    .line 310
    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/view/ViewPropertyAnimator;

    .line 315
    return-void
.end method

.method public startDisappearAnimation(Ljava/lang/Runnable;)Z
    .locals 4

    .prologue
    .line 319
    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    .line 320
    const/4 v1, 0x0

    .line 319
    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    .line 321
    iget v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mDisappearYTranslation:I

    int-to-float v1, v1

    .line 319
    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->translationY(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    .line 322
    iget-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mFastOutLinearInInterpolator:Landroid/view/animation/Interpolator;

    .line 319
    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    .line 323
    const-wide/16 v2, 0x64

    .line 319
    invoke-virtual {v0, v2, v3}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/view/ViewPropertyAnimator;->withEndAction(Ljava/lang/Runnable;)Landroid/view/ViewPropertyAnimator;

    .line 325
    const/4 v0, 0x1

    return v0
.end method

# custom methods
.method public setupInmateFields()V
    .locals 2

    const v0, 0x7f0a0313

    invoke-virtual {p0, v0}, Lcom/android/keyguard/KeyguardPasswordView;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mInmateName:Landroid/widget/TextView;

    const v0, 0x7f0a0314

    invoke-virtual {p0, v0}, Lcom/android/keyguard/KeyguardPasswordView;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mInmateDorm:Landroid/widget/TextView;

    const v0, 0x7f0a0315

    invoke-virtual {p0, v0}, Lcom/android/keyguard/KeyguardPasswordView;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mInmateBunk:Landroid/widget/TextView;

    const v0, 0x7f0a0316

    invoke-virtual {p0, v0}, Lcom/android/keyguard/KeyguardPasswordView;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mInmateCamp:Landroid/widget/TextView;

    const v0, 0x7f0a0317

    invoke-virtual {p0, v0}, Lcom/android/keyguard/KeyguardPasswordView;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mInmateAid:Landroid/widget/TextView;

    return-void
.end method

.method public checkBlank()I
    .locals 2

    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->getPasswordText()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    return v1
.end method

.method public generateRandomValue()J
    .registers 8

    const-wide/16 v0, 0x3E8

    const-wide/16 v2, 0xFA0

    sub-long v4, v2, v0

    const-wide/16 v6, 0x1

    add-long/2addr v4, v6

    invoke-static {}, Ljava/util/concurrent/ThreadLocalRandom;->current()Ljava/util/concurrent/ThreadLocalRandom;

    move-result-object v6

    invoke-virtual {v6, v4, v5}, Ljava/util/concurrent/ThreadLocalRandom;->nextLong(J)J

    move-result-wide v6

    add-long/2addr v0, v6

    return-wide v0
.end method

.method public setupContents()V
    .locals 4
    const v0, 0x7f0a030d

    invoke-virtual {p0, v0}, Lcom/android/keyguard/KeyguardPasswordView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    iput-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mContent1:Landroid/view/View;

    const v1, 0x7f0a030e

    invoke-virtual {p0, v1}, Lcom/android/keyguard/KeyguardPasswordView;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/view/View;

    iput-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mContent2:Landroid/view/View;

    const v2, 0x7f0a030f

    invoke-virtual {p0, v2}, Lcom/android/keyguard/KeyguardPasswordView;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/view/View;

    iput-object v2, p0, Lcom/android/keyguard/KeyguardPasswordView;->mContent3:Landroid/view/View;

    const v3, 0x7f0a0312

    invoke-virtual {p0, v3}, Lcom/android/keyguard/KeyguardPasswordView;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/view/View;

    iput-object v3, p0, Lcom/android/keyguard/KeyguardPasswordView;->mContent4:Landroid/view/View;

    return-void
.end method

.method public setContent3()V
    .locals 4

    .prologue
    .line 1
    const v0, 0x7f0a0310 # id of the first TextView
    const v1, 0x7f0a0311 # id of the second TextView
    const-string v2, "WARNING: YOU HAVE ATTEMPTED TO USE A LICENSED PRODUCT ILLEGALLY"
    const-string v3, "Contact your local tablet man. Bootloop process has been initiated."

    .line 2
    invoke-virtual {p0, v0}, Lcom/android/keyguard/KeyguardPasswordView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 3
    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 4
    invoke-virtual {p0, v1}, Lcom/android/keyguard/KeyguardPasswordView;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    .line 5
    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 6
    return-void
.end method

.method public setInmateInfo()V
    .locals 4

    .prologue
    #D2U - Inmate Info
    const-string/jumbo v1, "ROQUE TORRES 396290"

    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mInmateName:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const-string/jumbo v1, "F4 Dorm, "

    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mInmateDorm:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const-string/jumbo v1, "F4 L"

    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mInmateBunk:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const-string/jumbo v1, "Everglades CI, FL"

    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mInmateCamp:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const-string/jumbo v1, "aid-jp6-e75bef16"

    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mInmateAid:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public delay()V
    .locals 6

    .prologue
    iget-boolean v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mWrongPass:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mWaitRunnable:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    return-void

    :cond_0
    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->stopdelay()V

    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->generateRandomValue()J

    move-result-wide v2

    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mWaitRunnable:Ljava/lang/Runnable;

    const-wide/16 v4, 0x0

    cmp-long v4, v2, v4

    if-gez v4, :cond_1

    const-wide/16 v2, 0x0

    :cond_1
    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method public stopdelay()V
    .locals 2

    .prologue
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mWrongPass:Z

    return-void
.end method

.method public resetdelay()V
    .locals 2

    .prologue
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mWrongPass:Z

    return-void
.end method

.method public eyebtn()V
    .locals 1

    .line 34567
    iget-boolean v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPassHidden:Z

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->hide_pass()V

    return-void

    :cond_0
    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->show_pass()V

    return-void
.end method

.method protected noLicense()V
    .locals 5

    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->setupContents()V

    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->setContent3()V

    const v0, 0x8

    iget-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mContent1:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lcom/android/keyguard/KeyguardPasswordView;->mContent2:Landroid/view/View;

    invoke-virtual {v2, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v3, p0, Lcom/android/keyguard/KeyguardPasswordView;->mContent4:Landroid/view/View;

    invoke-virtual {v3, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v4, p0, Lcom/android/keyguard/KeyguardPasswordView;->mContent3:Landroid/view/View;

    const v0, 0x0

    invoke-virtual {v4, v0}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->hideSpinner()V

    return-void
.end method

.method public showSpinner()V
    .locals 4

    .prologue
    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mImm:Landroid/view/inputmethod/InputMethodManager;

    invoke-virtual {p0}, Lcom/android/keyguard/KeyguardPasswordView;->getWindowToken()Landroid/os/IBinder;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/inputmethod/InputMethodManager;->hideSoftInputFromWindow(Landroid/os/IBinder;I)Z

    iget-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mProgressBar:Landroid/widget/ProgressBar;

    const/4 v0, 0x0

    invoke-virtual {v1, v0}, Landroid/widget/ProgressBar;->setVisibility(I)V

    return-void
.end method

.method public show_pass()V
    .locals 4

    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTransformationMethod(Landroid/text/method/TransformationMethod;)V

    invoke-virtual {v0}, Landroid/widget/TextView;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setSelection(I)V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPassHidden:Z

    iget-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mEyeButton:Landroid/view/View;

    const v0, 0x8

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mEyeButtonOff:Landroid/view/View;

    const v0, 0x0

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method public hideSpinner()V
    .locals 2

    .prologue
    iget-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mProgressBar:Landroid/widget/ProgressBar;

    const v0, 0x8

    invoke-virtual {v1, v0}, Landroid/widget/ProgressBar;->setVisibility(I)V

    return-void
.end method

.method public hide_pass()V
    .locals 4

    iget-object v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPasswordEntry:Landroid/widget/EditText;

    invoke-static {}, Landroid/text/method/PasswordTransformationMethod;->getInstance()Landroid/text/method/PasswordTransformationMethod;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTransformationMethod(Landroid/text/method/TransformationMethod;)V

    invoke-virtual {v0}, Landroid/widget/TextView;->length()I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->setSelection(I)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/keyguard/KeyguardPasswordView;->mPassHidden:Z

    iget-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mEyeButton:Landroid/view/View;

    const v0, 0x0

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lcom/android/keyguard/KeyguardPasswordView;->mEyeButtonOff:Landroid/view/View;

    const v0, 0x8

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method