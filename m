Return-Path: <kernel-hardening-return-13082-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+xpfgCqHQpOg3kr2tY/cWj9tU1RmqmbUlIyjVZ58pyZg2okngToxnt2dKqNbeQ1Ccaa5ZJ
ARC-Seal: i=1; a=rsa-sha256; t=1524414772; cv=none;
        d=google.com; s=arc-20160816;
        b=R3CfahCk6R8A2SfnIYSwYZ5vefxf/sso6EndgUMC5oK/bmINnQN3/urp+GZcD3X9uq
         XDWC07teSOZBwhO/DLfr4V7sXD/fHtQXlDkfNsjFujHxRroFIlHeSQu7YTHm9r9lIP3H
         Y/pnIglCLGMD10ZEMC9j6BpS4bfV0EO14auAIHoJwCx33SlG+moLJnOXlGx+FjfIeImj
         QWIGmZQhVsxo9QYWv++3DqPzXMnAaEximBwUgE/U+4pTaMlJqQ6hFoQBGGdfGCP1sFaI
         YF44FLrGqGq+oXOjbFhW2tagtdK/Dxnx3gTjNjxjzUTTsGw8Tc9ajRUfRyXctP8l2w6y
         7aeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=rIazkyw1OLNVn3cxZrm+LtmaEODbKKHXqrEo4HvDrcU=;
        b=PKOkycO6ylSN7NcBxGDKtcJscksvDAH8zzpNnvh/YADD5rO8rARPVa+TCFIxSUTkZc
         v28tA+jnMdCIxoVUruig+uJMBlRg5AIeKOYCRubhY9dLDTyKC1CCMgW619R43FztzTD/
         dHI8byrwXTsHcHPo6GZb9ymV3koxsbzys131JzC6fxcK/gcA8VaX1i1a9mRTkRDNWQo5
         OdvajGpMvQMclN8RNecBJDnzEGZKoshMr149YyFj4ruTuBWWtboyJEoi48IgfMaLnAuu
         BCXiwPZrzlHNmG1uTRveG1X74to5q57OwXNqgFkl+Vb5IjRuZGLcX9S3+OObtKop3aKI
         BU+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13082-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13082-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13082-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13082-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Message-Id: <20180422162512.650512856@linutronix.de>
User-Agent: quilt/0.63-1
Date: Sun, 22 Apr 2018 18:23:49 +0200
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
Subject: [patch V3 04/10] rslib: Cleanup top level comments
References: <20180422162345.004292133@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=rslib--Cleanup_top_level_comments.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598464744584430739?=
X-GMAIL-MSGID: =?utf-8?q?1598464744584430739?=
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
