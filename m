Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx4+ELt30oUT3J7FaczcM6cFEhuBeniA08nCDo7yGJ0+7ppx19oYiFu/Ur07mLxvXR5xs+Mtf
ARC-Seal: i=1; a=rsa-sha256; t=1522270630; cv=none;
        d=google.com; s=arc-20160816;
        b=PFkEKe6gmMTMk0u73CibYWUWRmMfwJtnH5s6x3AFL6ZJ4sOoNNHRiNBdQ2hQnou8pS
         tSifDCE8Wjnaj5qVcdO33pXUkZ7vO3DxxW1d0uFJO2/556/kE+PV34O09GYsDIXSsQMf
         RXjBfnBNYqCRg8yO3iAWvxog9dxJqZfrn9cccuNCencmfGpxaj/bcj4mf2XLJqZqHVet
         lYJNWnVLkRdCa8bFMFxBPaM9+RSXhYpZGJos8pAK0YTHOAfQYhQnw14NJNRnQJBXXkoV
         fx0NnFjl8QVauXBkcy2cynUY8r2oLasyHo1U4T7oNWCw5Zqr5ta8mxO7+hQ+YzZMA7j0
         9TYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=dJr0o4pw8/sRG8Z2WAalWngNM45ey5fcIXn6nuxqU14=;
        b=ynjlr2HzWnGmZwrD7zBeWDXtYwWRYL0R/7h6tT5nsEY53i3sG+DWrX2F5/teZvTwVn
         sxLN89B09mJUIqpWWotgf/EzUMCjY76VS7xKlq3hf3AY100g8M/a6W/I5+mLSgsAoRLs
         378JIzsCmBlQTXYbJ/rYqE73h0Sf1YkRNDz/DCHH+gCw/AE9+FtLzrWZtOd/PMsxSx8m
         c29bQVIikAEt22ls7d5l4jR2VjLyIUWhyqccRr1OkUR+4mHU/oYhWfjyC64QKxgRaKFM
         aRpQJJlS3FbkVf51MQ7wm/ctVQS6CWOtNBDEfYsdfKm9IkhEP0xGMylLL/GF6zPiXmsg
         FjdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180328205554.579463196@linutronix.de>
User-Agent: quilt/0.63-1
Date: Wed, 28 Mar 2018 22:51:42 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Andrew Morton <akpm@linuxfoundation.org>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
 Tony Luck <tony.luck@intel.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [patch 4/8] rslib: Remove GPL boilerplate
References: <20180328205138.301218351@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=rslib--Remove-GPL-boilerplate.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596216448740269065?=
X-GMAIL-MSGID: =?utf-8?q?1596216448740269065?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that SPDX identifiers are in place, remove the GPL boiler plate
text. Leave the notices which document that Phil Karn granted permission in
place (encode/decode source code). The modified files are code written for
the kernel by me.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/rslib.h           |    5 -----
 lib/reed_solomon/reed_solomon.c |    4 ----
 2 files changed, 9 deletions(-)

--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -6,12 +6,7 @@
  *
  * RS code lifted from reed solomon library written by Phil Karn
  * Copyright 2002 Phil Karn, KA9Q
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
-
 #ifndef _RSLIB_H_
 #define _RSLIB_H_
 
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -7,10 +7,6 @@
  * Reed Solomon code lifted from reed solomon library written by Phil Karn
  * Copyright 2002 Phil Karn, KA9Q
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Description:
  *
  * The generic Reed Solomon library provides runtime configurable
