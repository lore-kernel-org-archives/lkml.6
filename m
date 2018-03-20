Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AG47ELvwfoH7z1X9ktDWbLGB3DoSpDjqZETHSyNKaWATn44SqigwxLbgUecPC2zllZBxxIXHMI9l
ARC-Seal: i=1; a=rsa-sha256; t=1521552545; cv=none;
        d=google.com; s=arc-20160816;
        b=Va/dhopw3N89OahQLYGcvW7REkn2QFdneSI8WLwWH5Epnu7UwBkU7IspGVPwbriZ1v
         JIpA6HPkAqypH8PKBY3okVHCpBEknrQumIM0IwH7Sxwg5xIF2GnYNtxJaZmikKTZrnrO
         speTkUYNKiaqNwIyvt9Z+a7FbtlKZ+9mD6FGvQtxFnWO56A1SbEHxm7vFe0y19iBbaHa
         lPcC7LrPaamETz+KHYwp+9N8OH/EZEDw+GpOhj5Gbm+Brfidi/eIy2D/0RJxZK5xCfuN
         Ps/CXM5fAEwDR1Z+8OHCIrujbUSJboBH3RkqwjUgPMffAyGjQmKNE2mmY9UXy4Vtjr/a
         zbqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=kskoZpC030uWmSqvVIzj2VBvZXf6kXz/9DaMjVxIgWs=;
        b=rUEhsUUe7WJSBiTwY1PuFtZjTZkDyS752CheQaN/97ZEfwA0Dp8vM2UXRHuNsNaAr3
         YkEVfhT2tnNvSMKcOj4C/0gLjZz498nqH6nKC0RyVt5EAM0EBi7Iar2s9QJr1kB7EDWz
         4pauu1xyolzoDhgcRuD0l4ZBZVJNqls1/YbCcRvegX4XqYXLGz08R/e73Gq8lwIcJZ9i
         axLMso6EKjxwA1rrhQZr8dbMV1qRExUGpzMVRWFLK+nbU8TAJBxGtwIzYNMuNAK90yYm
         bRPsP1bkAU+XytCzD/HTZwh94tVXl2P6cLkyu7e75ZOhSGA6CD5ODK7ppkFaQn7o7rNU
         ToFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Tue, 20 Mar 2018 06:28:57 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-52a65ff5603e685e9b19c2e108b3f0826dc7a86b@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, gregkh@linuxfoundation.org
Reply-To: linux-kernel@vger.kernel.org, pombredanne@nexb.com, mingo@kernel.org,
        hpa@zytor.com, tglx@linutronix.de, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org
In-Reply-To: <20180314212030.668321222@linutronix.de>
References: <20180314212030.668321222@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Add missing SPDX identifiers
Git-Commit-ID: 52a65ff5603e685e9b19c2e108b3f0826dc7a86b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594949826755527282?=
X-GMAIL-MSGID: =?utf-8?q?1595463481765628229?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  52a65ff5603e685e9b19c2e108b3f0826dc7a86b
Gitweb:     https://git.kernel.org/tip/52a65ff5603e685e9b19c2e108b3f0826dc7a86b
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 14 Mar 2018 22:15:19 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 20 Mar 2018 14:23:28 +0100

genirq: Add missing SPDX identifiers

Add SPDX identifiers to files

 - which contain an explicit license boiler plate or reference

 - which do not contain a license reference and were not updated in the
   initial SPDX conversion because the license was deduced by the scanners
   via EXPORT_SYMBOL_GPL as GPL2.0 only.

[ tglx: Moved adding identifiers from the patch which removes the
  	references/boilerplate ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Link: https://lkml.kernel.org/r/20180314212030.668321222@linutronix.de

---
 kernel/irq/chip.c         | 1 +
 kernel/irq/cpuhotplug.c   | 1 +
 kernel/irq/debugfs.c      | 1 +
 kernel/irq/devres.c       | 1 +
 kernel/irq/dummychip.c    | 1 +
 kernel/irq/generic-chip.c | 1 +
 kernel/irq/handle.c       | 1 +
 kernel/irq/ipi.c          | 1 +
 kernel/irq/irq_sim.c      | 1 +
 kernel/irq/irqdesc.c      | 1 +
 kernel/irq/irqdomain.c    | 2 ++
 kernel/irq/manage.c       | 1 +
 kernel/irq/msi.c          | 1 +
 kernel/irq/pm.c           | 1 +
 kernel/irq/timings.c      | 1 +
 15 files changed, 16 insertions(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index b575c7a93b76..a2b3d9de999c 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006, Thomas Gleixner, Russell King
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 9eb09aef0313..5b1072e394b2 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic cpu hotunplug interrupt migration code copied from the
  * arch/arm implementation
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index acfaaef8672a..c8cc6ce9c1c3 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright 2017 Thomas Gleixner <tglx@linutronix.de>
  *
diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index 194c506d9d20..6a682c229e10 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
diff --git a/kernel/irq/dummychip.c b/kernel/irq/dummychip.c
index 326a67f2410b..0b0cdf206dc4 100644
--- a/kernel/irq/dummychip.c
+++ b/kernel/irq/dummychip.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006, Thomas Gleixner, Russell King
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 508c03dfef25..e2999a070a99 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Library implementing the most common irq chip callback functions
  *
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 1bf69b6571a3..38554bc35375 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006, Thomas Gleixner, Russell King
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index 4da9cf0a935c..8b778e37dc6d 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015 Imagination Technologies Ltd
  * Author: Qais Yousef <qais.yousef@imgtec.com>
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 85690859a2a8..fc4f361a86bb 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2017 Bartosz Golaszewski <brgl@bgdev.pl>
  *
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 55515cce1cc2..afc7f902d74a 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006, Thomas Gleixner, Russell King
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 82b8b18ee1eb..5d9fc01b60a6 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 #define pr_fmt(fmt)  "irq: " fmt
 
 #include <linux/acpi.h>
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 99eb1977e784..e3336d904f64 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006 Thomas Gleixner
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 8429c88427ff..2a8571f72b17 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2014 Intel Corp.
  * Author: Jiang Liu <jiang.liu@linux.intel.com>
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index 474d3fa32a28..d6961d3c6f9e 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
  *
diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index c87099b2ea50..223d47937c48 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
  *
