Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AG47ELu9bxHXG8lOsR+rcTGQGXThB4cnWw/v5u3KJ8y6TRvQ5nEZ11V2o9BPdumI2elYuju91sd1
ARC-Seal: i=1; a=rsa-sha256; t=1521552492; cv=none;
        d=google.com; s=arc-20160816;
        b=Uep3iR3fTP4m7yr4tT2W27v4n9t27BcVkmXBZo5GbGKvFUPiCSkhY8abGZ7vtX7URO
         gPjHsZvGa6nyst2dsbUkwJp72Xoc1GCj3TKnUd+HxMwPA0MNpudoyWRa2C3vDaTbXU/c
         GtZirXvhV2bGiESbXBOYzde+5zhtv6k7axuRlHcVBKcVsTj8IR/gqGAR6kuyvTVBoBmn
         l6x2ns+C2C5jGALCmfuUbjTQVckFyUtVIFbKExtqGiTq8XazQV9Gin0OL61H8nI9CZfJ
         sAt0uUb95pi0ZSy81p2/VWo4hA1uYs3+50PiYx2JLl5L/nbI2KpOthrkhXj9LTjvZXPa
         BrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=6eUnfVzzImLnocK113b2i1QhcQCozKgUQ5Mh3vRzZEU=;
        b=gjatbxKE5QrQYIwFjSY/qDhfdV44Wfj7S28dKvV5KDK39d3Y1CWEn0nD0ohKGeiSY2
         r7E/JxKOB7hijuMcVLtpekb4XZogDBC2tZ9MGFLUQgmgwwmkSWw+wMqZipdZb/qnFv+w
         0dJiA86G+zW0XWxJXn7/x+5YQFNidlW+qSrn7Cr1kafsNO6gSGoSFF7YKm71d+T8+R0A
         G4kWWjkpsPy4BdV5bJZ3rKX5wzwcpbkoPRy7eWrDeZfZ9tYkEklpwjiCubn35wVYu8/H
         92riJCDqgn0ybn7GaAQhJLb3aPddlGGmAAmVpTXxmRj4j8OdQwon1o0mYA93YAd8B7Xp
         cKkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Tue, 20 Mar 2018 06:27:58 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-99bfce5db9c071800bdc7e9658a68e6d11aeecf6@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, pombredanne@nexb.com,
        mingo@kernel.org, gregkh@linuxfoundation.org, marc.zyngier@arm.com,
        kstewart@linuxfoundation.org, hpa@zytor.com
Reply-To: hpa@zytor.com, kstewart@linuxfoundation.org, marc.zyngier@arm.com,
        gregkh@linuxfoundation.org, mingo@kernel.org, pombredanne@nexb.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20180314212030.412095827@linutronix.de>
References: <20180314212030.412095827@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Cleanup top of file comments
Git-Commit-ID: 99bfce5db9c071800bdc7e9658a68e6d11aeecf6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594949825828386943?=
X-GMAIL-MSGID: =?utf-8?q?1595463426037733855?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  99bfce5db9c071800bdc7e9658a68e6d11aeecf6
Gitweb:     https://git.kernel.org/tip/99bfce5db9c071800bdc7e9658a68e6d11aeecf6
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 14 Mar 2018 22:15:16 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 20 Mar 2018 14:23:27 +0100

genirq: Cleanup top of file comments

Remove pointless references to the file name itself and condense the
information so it wastes less space.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Link: https://lkml.kernel.org/r/20180314212030.412095827@linutronix.de

---
 kernel/irq/autoprobe.c | 2 --
 kernel/irq/chip.c      | 9 +++------
 kernel/irq/handle.c    | 7 ++-----
 kernel/irq/ipi.c       | 2 --
 kernel/irq/irqdesc.c   | 5 ++---
 kernel/irq/manage.c    | 2 --
 kernel/irq/msi.c       | 2 --
 kernel/irq/pm.c        | 2 --
 kernel/irq/proc.c      | 2 --
 kernel/irq/resend.c    | 2 --
 kernel/irq/spurious.c  | 2 --
 kernel/irq/timings.c   | 2 --
 12 files changed, 7 insertions(+), 32 deletions(-)

diff --git a/kernel/irq/autoprobe.c b/kernel/irq/autoprobe.c
index 8c82ea26e837..16cbf6beb276 100644
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
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index c69357a43849..b575c7a93b76 100644
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
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 3570c715c3e7..1bf69b6571a3 100644
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
 
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index 259a22aa9934..4da9cf0a935c 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/irq/ipi.c
- *
  * Copyright (C) 2015 Imagination Technologies Ltd
  * Author: Qais Yousef <qais.yousef@imgtec.com>
  *
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index d9ded088d336..55515cce1cc2 100644
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
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index b0aa23b2398e..99eb1977e784 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/irq/manage.c
- *
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006 Thomas Gleixner
  *
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 2f3c4f5382cc..8429c88427ff 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/irq/msi.c
- *
  * Copyright (C) 2014 Intel Corp.
  * Author: Jiang Liu <jiang.liu@linux.intel.com>
  *
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index 6bd9b58429cc..474d3fa32a28 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/irq/pm.c
- *
  * Copyright (C) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
  *
  * This file contains power management functions related to interrupts.
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index e8f374971e37..7cb091d81d91 100644
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
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 1d08f45135c2..95414ad3506a 100644
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
diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index 6cdecc6f4c53..d867d6ddafdd 100644
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
diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index e0923fa4927a..c87099b2ea50 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/irq/timings.c
- *
  * Copyright (C) 2016, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
  *
  * This program is free software; you can redistribute it and/or modify
