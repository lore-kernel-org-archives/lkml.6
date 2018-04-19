Return-Path: <kernel-hardening-return-13053-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/vt+6xauKCJ9qkzdzZiq5k4/QsKDanB+u42UwZWK+Y1qTcDKUKDnl8y+RUthG8+aAyumgT
ARC-Seal: i=1; a=rsa-sha256; t=1524132663; cv=none;
        d=google.com; s=arc-20160816;
        b=rgohVZ1qB1dOMlIJEXa7lkBuZ8ajadYPzR2lVVgprS8uM+5Ae8kD0wwtqUxoJqkcDE
         rT7V3OeT/VI0F0szljZjMJYmNP2qPb5+3w5m9XqzvIAOd8DK/kuTRFTN7//GnmRhmWJs
         BUPwqkdPJk6xU/RPjRNs4vVpN04/QFn4lsER/hDdPuFiPS/ibUONtSldTl/MdD0TRNTO
         zwpfvN2jmHFlS3F/jhY4IbA9xoAM694/M8Ubhe2Pgh6WIJmMABz1j4FwJnh8fW/Ooh1z
         IAdz4XTDOom4ct2qCJowKehd7mdOKHi62zi3oiQLndDAN61zKae3K6PEWYjJtycitdu5
         ZuVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=rIazkyw1OLNVn3cxZrm+LtmaEODbKKHXqrEo4HvDrcU=;
        b=wZX2c9KPPY5UetShxssamB9F01meVVnFSank4LyGde8Gk4MCHk++ACdoQREmlJv3QZ
         PSLMCVOgsvEs6WfpQ8NLeZBBKY8aOIBhCjJU+01uxJ/hsh2BKiXp8WSltQBthod9Ld8v
         qGZ83lctDScjyAYwus3M31LDf61qkSi9hcyzLn3LXtx0YuNVzhfENpf/LNJXzdGdHsx0
         yTkDmp3eY7yFCOYH4sxGmFPpGV7msdL3WH2HDO7a72LU33VD60VduKDW7eNjVNQfn+Xs
         cb8uMKENZLiOL1KcQmFk5uMOAfzG1iInmrkkkdpH+puYMJbWEyzNjfpt8awKHgiud5iI
         g2XA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13053-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13053-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13053-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13053-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Message-Id: <20180419100934.914488121@linutronix.de>
User-Agent: quilt/0.63-1
Date: Thu, 19 Apr 2018 12:04:43 +0200
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
 Tony Luck <tony.luck@intel.com>
Subject: [patch V2 2/8] rslib: Cleanup top level comments
References: <20180419100441.548834519@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=rslib--Cleanup_top_level_comments.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598168931797461284?=
X-GMAIL-MSGID: =?utf-8?q?1598168931797461284?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

File references and stale CVS ids are really not useful.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
 include/linux/rslib.h           |    7 +------
 lib/reed_solomon/decode_rs.c    |   12 ++----------
 lib/reed_solomon/encode_rs.c    |   13 ++-----------
 lib/reed_solomon/reed_solomon.c |    9 +--------
 4 files changed, 6 insertions(+), 35 deletions(-)

--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -1,16 +1,11 @@
 /*
- * include/linux/rslib.h
- *
- * Overview:
- *   Generic Reed Solomon encoder / decoder library
+ * Generic Reed Solomon encoder / decoder library
  *
  * Copyright (C) 2004 Thomas Gleixner (tglx@linutronix.de)
  *
  * RS code lifted from reed solomon library written by Phil Karn
  * Copyright 2002 Phil Karn, KA9Q
  *
- * $Id: rslib.h,v 1.4 2005/11/07 11:14:52 gleixner Exp $
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -1,20 +1,12 @@
 /*
- * lib/reed_solomon/decode_rs.c
- *
- * Overview:
- *   Generic Reed Solomon encoder / decoder library
+ * Generic Reed Solomon encoder / decoder library
  *
  * Copyright 2002, Phil Karn, KA9Q
  * May be used under the terms of the GNU General Public License (GPL)
  *
  * Adaption to the kernel by Thomas Gleixner (tglx@linutronix.de)
  *
- * $Id: decode_rs.c,v 1.7 2005/11/07 11:14:59 gleixner Exp $
- *
- */
-
-/* Generic data width independent code which is included by the
- * wrappers.
+ * Generic data width independent code which is included by the wrappers.
  */
 {
 	int deg_lambda, el, deg_omega;
--- a/lib/reed_solomon/encode_rs.c
+++ b/lib/reed_solomon/encode_rs.c
@@ -1,21 +1,12 @@
 /*
- * lib/reed_solomon/encode_rs.c
- *
- * Overview:
- *   Generic Reed Solomon encoder / decoder library
+ * Generic Reed Solomon encoder / decoder library
  *
  * Copyright 2002, Phil Karn, KA9Q
  * May be used under the terms of the GNU General Public License (GPL)
  *
  * Adaption to the kernel by Thomas Gleixner (tglx@linutronix.de)
  *
- * $Id: encode_rs.c,v 1.5 2005/11/07 11:14:59 gleixner Exp $
- *
- */
-
-/* Generic data width independent code which is included by the
- * wrappers.
- * int encode_rsX (struct rs_control *rs, uintX_t *data, int len, uintY_t *par)
+ * Generic data width independent code which is included by the wrappers.
  */
 {
 	int i, j, pad;
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -1,16 +1,11 @@
 /*
- * lib/reed_solomon/reed_solomon.c
- *
- * Overview:
- *   Generic Reed Solomon encoder / decoder library
+ * Generic Reed Solomon encoder / decoder library
  *
  * Copyright (C) 2004 Thomas Gleixner (tglx@linutronix.de)
  *
  * Reed Solomon code lifted from reed solomon library written by Phil Karn
  * Copyright 2002 Phil Karn, KA9Q
  *
- * $Id: rslib.c,v 1.7 2005/11/07 11:14:59 gleixner Exp $
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -35,9 +30,7 @@
  * second stage, which does the decoding / error correction itself.
  * Many hw encoders provide a syndrome calculation over the received
  * data + syndrome and can call the second stage directly.
- *
  */
-
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
