Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx489KOkFGVjtm4ijxqqixLmV0b6sv7C0KIaYuhiHBp7jj/OhW7+5frGNjKSfvzz1G3uTu/Px
ARC-Seal: i=1; a=rsa-sha256; t=1524414705; cv=none;
        d=google.com; s=arc-20160816;
        b=DKUBnemQi4ZlZtqndZ0D7LoSHBKnFDFBBq9QK94Q/Yvh4uaAEA0awQ8qyUEJ6JwvA3
         FzVu+JDfehBailQMenXlePRCT3+k7aEk5T1OI2p8hvR4IZsizYCTKKEBni1Rxm9h/vtj
         kE7bFMpGrlPvbWNiMLD4U1D8f69fa2iuMfiXfFwonfMH8VxaX2OwXwjFhZZ8GeNPqMNm
         +sP/PTixf1yUmKOkSjNOLX3b+OX+WtTxiea6klYPQKQQkMSdQkb+1LJoJLinmFJdhXW4
         tkqCjDjU5XJjRF+xW4k3/ySm0QFiU7CzVRJ0bfXm5BTlMvlC5QXLgfwZhaoj3RpqGjmf
         x2mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=B7uL6YMbG2W8BglyZc4KoCaLyYyz1MXXksP9MxRYVf4=;
        b=ovI+YDJJlQ43ZmW03nmVs0bF0dnGxCXxbjP7l81nVyQNAv4rNEycptWm41G1g89Dsp
         ua93sKWJ5Sk/rXcXaBgcrooB9Be+IO2Mx/ExqVdGxP+eJomz5HT5BYTIq2kEBpmjCzbj
         /U9+s+1ndpNBRjKbybmF/EBxzB49YYSU58ajfbruRbCCmyPJpDBKoQndx4+32fURCPfA
         FLTqXAH+csRuNVox52Jp8TEVlpgq6VRyKk/JW+IdJ0UlegLTEhyKOKcE5xrbBDhgvPrT
         9n1DwVVzYtBfdf5mdiRtLj7TUuFmBYeKjxcBsqAQZj55OzNf5pvZApV/1ADVI93Zsdzm
         J9+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180422162512.830901256@linutronix.de>
User-Agent: quilt/0.63-1
Date: Sun, 22 Apr 2018 18:23:51 +0200
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
Subject: [patch V3 06/10] rslib: Remove GPL boilerplate
References: <20180422162345.004292133@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=rslib--Remove_GPL_boilerplate.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598464674469569625?=
X-GMAIL-MSGID: =?utf-8?q?1598464674469569625?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

Now that SPDX identifiers are in place, remove the GPL boiler plate
text. Leave the notices which document that Phil Karn granted permission in
place (encode/decode source code). The modified files are code written for
the kernel by me.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kate Stewart <kstewart@linuxfoundation.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Anton Vorontsov <anton@enomsg.org>
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
