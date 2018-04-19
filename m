Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx4/0U1liI0hq9P200F/p9UoPY4mlWdVfRVJ7bZbO9ICWsaFX+qDZCyPchIs9VA0qf+aKSMml
ARC-Seal: i=1; a=rsa-sha256; t=1524132622; cv=none;
        d=google.com; s=arc-20160816;
        b=RIw9tErHd1+ZFkjGJ/NUUW2M1AjJDm/kpkREo6JSHgCioVkwlmRQS5GzGXnU3oKOsL
         dFGZZvnm+WkyHVHA2/W0iHpvmfHzqPouQg358qAmN4DMwpXwfo3tXOax82bBMLMXwxuD
         mttyn3M+JuKF2gFZE/uP9JjAWwU8inkEPnwNhbeWTe4NpgriCQTb2SMmFhLCNRHML95m
         5y89z0EHkQ23tXSSu3RyDtbIeHzz7dOfQ86vFOSKdm6WcfR0If1/GPzvLh579Lpn99NJ
         DfQw55YOwZfNi//Pd0mUNH4oz1tv5IeNPBTeMA8EbhZvZAfZp7YmokNM6HFtGkcjuVKk
         tNxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=VTRZzytIj432yOE/RP5QF9D/8Gnzhqrkwt8I4a5E5nA=;
        b=s3Ajh+dHpxUQ2QT+hbLXlkUEPY/7W7yiKmxaRwvgNw+1DJhVOcoZBdlRrTdXyyP+Jm
         eWW0FdqigtUmXivz9AJeFTWaMw6P5RgT30gJHFZUseOUItt9BMLwYZvGPIy7zkTw3ODG
         Po3zpzU89q4S8wi7h0SWpytyszqA1FdqCBthUtqeciTH/GYexhXtFiytCpmlaZWRFyPR
         4tg3qFvM+ZL6AZZ1cJwULxgCVHoD8MtWxbKgxLKu40K1QGF4o5BV2mya/eSjtVmU6ecg
         6LQF/ksgvVP84NRAI4b1xgx8/Qi6kJz3YBjP8rxZZz5mWqtym90DziYNupHa1Noz9AX7
         86OA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180419100935.093663398@linutronix.de>
User-Agent: quilt/0.63-1
Date: Thu, 19 Apr 2018 12:04:45 +0200
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
Subject: [patch V2 4/8] rslib: Remove GPL boilerplate
References: <20180419100441.548834519@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=rslib--Remove_GPL_boilerplate.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598168888356942839?=
X-GMAIL-MSGID: =?utf-8?q?1598168888356942839?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

Now that SPDX identifiers are in place, remove the GPL boiler plate
text. Leave the notices which document that Phil Karn granted permission in
place (encode/decode source code). The modified files are code written for
the kernel by me.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Colin Cross <ccross@android.com>
Cc: Andrew Morton <akpm@linuxfoundation.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Alasdair Kergon <agk@redhat.com>

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
