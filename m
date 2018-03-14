Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AG47ELsdVioY9SckRXwYmuE0meu4WoeWscQZd8V0HPgZleD7m0mBg2OgkszYlExrnS0vEiWg69hw
ARC-Seal: i=1; a=rsa-sha256; t=1521062684; cv=none;
        d=google.com; s=arc-20160816;
        b=l7rurqbrssp3TfFn0qUKoBpbIIEKCO7X2ozpncBARyjCthobix3UqugNy73GsRbUGO
         yiSd+bxOL6wKTJXWNxUynHAjMPOSrYUAoCKzI9bouhJ4Un0kJukhn2w7A04vZfZdlVi4
         foFWXZ57QwQxisqv9mskrWv2jRjSaT70IRBlTbRtdXSzx47Sc6qIypCPDvM4CiU/MdFS
         SqQ0orxODBidAps42oeULbK7PO3DcE/QMKO9GsEklDeWgqbb6z2Y8FqB6Ud3hCSMH2TY
         QSQzMs7iDqMaGGGTxIOafUI2OBYMp1bd5zPoCTD/nlP1dcB6D8de3uUPtc09cnJ1WU9g
         hUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=ouGCsM37RM2y1SxNV5GeUTVwTwKgXBtBPSErvqM9N2s=;
        b=fmc7Km3Lxxui2h9QN7x4NcTzrI1dy2dqt2H4r8//TJIJd4yEzPu/R3qFwW3rc8MyXO
         hHWHGVg6XBJ+mc9X3oCOGoWh5KjPjeEdMTRdWPQGebMfgdqh+Lc1d8oZdErscSkLTLOg
         4jaSPikd7UEK4DQGUlALMdWP3EiuqLDlspOj2IgD6VYBIlFNfAvzJ6ElFcruY1V8/pVq
         Vg4gB/WWi6gRs4W9seC/yWKQj5MUB4w8velqRlmcn4aeVo0DdrPGDSouiV6PKWp60L6j
         DXhRJEYOvEnuy+cjiRizNJOo60y4glbBOWizuStECdPgAnUm16SMW+8fPDxvDQhLm+qe
         vKzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180314212030.412095827@linutronix.de>
User-Agent: quilt/0.63-1
Date: Wed, 14 Mar 2018 22:15:16 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [patch 1/4] genirq: Cleanup top of file comments
References: <20180314211515.429128440@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=genirq--Remove-pointless-file-references-in-top-comments.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594949825828386943?=
X-GMAIL-MSGID: =?utf-8?q?1594949825828386943?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove pointless references to the file name itself and condense the
information so it wastes less space.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/autoprobe.c |    2 --
 kernel/irq/chip.c      |    9 +++------
 kernel/irq/handle.c    |    7 ++-----
 kernel/irq/ipi.c       |    2 --
 kernel/irq/irqdesc.c   |    5 ++---
 kernel/irq/manage.c    |    2 --
 kernel/irq/msi.c       |    2 --
 kernel/irq/pm.c        |    2 --
 kernel/irq/proc.c      |    2 --
 kernel/irq/resend.c    |    2 --
 kernel/irq/spurious.c  |    2 --
 kernel/irq/timings.c   |    2 --
 12 files changed, 7 insertions(+), 32 deletions(-)

--- a/kernel/irq/autoprobe.c
+++ b/kernel/irq/autoprobe.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/kernel/irq/autoprobe.c
- *
  * Copyright (C) 1992, 1998-2004 Linus Torvalds, Ingo Molnar
  *
  * This file contains the interrupt probing code and driver APIs.
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1,13 +1,10 @@
 /*
- * linux/kernel/irq/chip.c
- *
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006, Thomas Gleixner, Russell King
  *
- * This file contains the core interrupt handling code, for irq-chip
- * based architectures.
- *
- * Detailed information is available in Documentation/core-api/genericirq.rst
+ * This file contains the core interrupt handling code, for irq-chip based
+ * architectures. Detailed information is available in
+ * Documentation/core-api/genericirq.rst
  */
 
 #include <linux/irq.h>
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -1,12 +1,9 @@
 /*
- * linux/kernel/irq/handle.c
- *
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006, Thomas Gleixner, Russell King
  *
- * This file contains the core interrupt handling code.
- *
- * Detailed information is available in Documentation/core-api/genericirq.rst
+ * This file contains the core interrupt handling code. Detailed
+ * information is available in Documentation/core-api/genericirq.rst
  *
  */
 
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/irq/ipi.c
- *
  * Copyright (C) 2015 Imagination Technologies Ltd
  * Author: Qais Yousef <qais.yousef@imgtec.com>
  *
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -2,9 +2,8 @@
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006, Thomas Gleixner, Russell King
  *
- * This file contains the interrupt descriptor management code
- *
- * Detailed information is available in Documentation/core-api/genericirq.rst
+ * This file contains the interrupt descriptor management code. Detailed
+ * information is available in Documentation/core-api/genericirq.rst
  *
  */
 #include <linux/irq.h>
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/irq/manage.c
- *
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006 Thomas Gleixner
  *
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/irq/msi.c
- *
  * Copyright (C) 2014 Intel Corp.
  * Author: Jiang Liu <jiang.liu@linux.intel.com>
  *
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/irq/pm.c
- *
  * Copyright (C) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
  *
  * This file contains power management functions related to interrupts.
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/kernel/irq/proc.c
- *
  * Copyright (C) 1992, 1998-2004 Linus Torvalds, Ingo Molnar
  *
  * This file contains the /proc/irq/ handling code.
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/kernel/irq/resend.c
- *
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006, Thomas Gleixner
  *
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/kernel/irq/spurious.c
- *
  * Copyright (C) 1992, 1998-2004 Linus Torvalds, Ingo Molnar
  *
  * This file contains spurious interrupt handling.
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/irq/timings.c
- *
  * Copyright (C) 2016, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
  *
  * This program is free software; you can redistribute it and/or modify
