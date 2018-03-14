Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AG47ELs0vQEGIzd7+euo+89lgiv59nowO5L8H7HwHyJp3sveC9sDeV1WwaYHzWYba3K6Y27yc/qy
ARC-Seal: i=1; a=rsa-sha256; t=1521062685; cv=none;
        d=google.com; s=arc-20160816;
        b=ClkLiaFRaC2QIMNiTVrJ4Go2/2tpXBg0HM5JbSqlzxDiyF+7eyleQ9EmcFUF4tx72H
         QpqCBy+XJhwONZZ0A8I6XeUm3AkKWOdul9COG+ME3tYuUWFBNNqCny30GJb4C1Krdo76
         muElbsaerEsRK5eaWmKczyWxcaEAWIIdMJ4wll5xPluTwtqBW/dMUn2nnLmGgeEvlAtG
         iJuiQcIoToFcyCgb8v6j/8lh01AuM8CwB6DUBOBsuxHeRGvsS/kT4rFOgNtBE9jUb+Ol
         FNpfdRM1C2qWml9QdxJppYEsBTeIdD1X+50bddhD2g4sVkc23cIdlV4EJYD+Bu54d9uk
         biwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=B5qzjWN9UQ2C7V+XsVBkf6bIVSb2DgjD0/HgBQHoIHY=;
        b=NrvmQCqL5RLI/w00eyo6NugyFkdY8EdNMSnnIJmCHHBoAw2nCR5Q0kx2oAGWc9NjO7
         9JfMjky1CY+4o7aauloDDX5VYJv6rVlnc51NpDCeE1DGWFLcZmHaTqTcNGR79O+llnWF
         eQGJ4YgfCMY9C+zfFD7Wjg47hECJ7buYgx2UN4D2MlLJZu9cbBf+slRl3E8tGC7btDI0
         AeJ9SFa2qcUJuAhksNWhcJa43QMd6sCmOz/qYn/LU6wTrk/vtpHj4NlLYoLJcJgUtj34
         nWxHm0wid649eQ0IGnpiMYBBr01HthJczjRDX85UD/segzDVtrdGHU/9X020g1we4dAe
         sbyw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180314212030.668321222@linutronix.de>
User-Agent: quilt/0.63-1
Date: Wed, 14 Mar 2018 22:15:19 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [patch 4/4] genirq: Add missing SPDX identifiers
References: <20180314211515.429128440@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=genirq--Add-missing-SPDX-identifiers.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594949826755527282?=
X-GMAIL-MSGID: =?utf-8?q?1594949826755527282?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These files do not contain a license reference and were not updated in the
initial SPDX conversion because the license was deduced by the scanners via
EXPORT_SYMBOL_GPL as GPL2.0 only.

Add the missing GPL-2.0 identifiers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c         |    1 +
 kernel/irq/devres.c       |    1 +
 kernel/irq/dummychip.c    |    1 +
 kernel/irq/generic-chip.c |    1 +
 kernel/irq/handle.c       |    1 +
 kernel/irq/ipi.c          |    1 +
 kernel/irq/irqdesc.c      |    1 +
 kernel/irq/irqdomain.c    |    2 ++
 kernel/irq/manage.c       |    1 +
 kernel/irq/pm.c           |    1 +
 10 files changed, 11 insertions(+)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006, Thomas Gleixner, Russell King
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
--- a/kernel/irq/dummychip.c
+++ b/kernel/irq/dummychip.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006, Thomas Gleixner, Russell King
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Library implementing the most common irq chip callback functions
  *
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006, Thomas Gleixner, Russell King
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015 Imagination Technologies Ltd
  * Author: Qais Yousef <qais.yousef@imgtec.com>
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006, Thomas Gleixner, Russell King
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 #define pr_fmt(fmt)  "irq: " fmt
 
 #include <linux/acpi.h>
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006 Thomas Gleixner
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
  *
