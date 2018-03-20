Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AG47ELv+fsJTjPZgm1mr90oAdUPo/q1GuX30czg6J3hkmgpJVrnGX2aO73mg1iPDu0xIQXBH5El2
ARC-Seal: i=1; a=rsa-sha256; t=1521552572; cv=none;
        d=google.com; s=arc-20160816;
        b=VOxS4ZT2ch+wgE8ANjXoV6vSInIqaeYgj9hc81JWguU3OPIPqDIpdcEFzngvvhHBeZ
         xDGyzdkJ4DJyWFtz6xPfeBSThB0d4acdFIOoG1sDfzdORfJgppjf8SYR8e8OR0RQSH/u
         x4DkUoWQJliOUF9U2CyFvfcDrcx6bEW+RH6xJw2ePKYgVRNw7d9OKna3PCXoEDdFjV05
         E/dnTsbZi0eEIxZAbEx/sDALoor/Fu05iyfqrxT4zTosEVahw2deqw9JE831dK/8EwO5
         8tsdCvmU5RnzwdvVwhSeUudfvp5sNyavLJx2R7wtWcm4pwjkOV7bQt/6lAqMC+8Dp8VN
         wJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=odj4bzSzVlx/H+ZH0a19J37EKF5K4OVpicr4r4Us18s=;
        b=o7bVuIqemSxRwmdLf8NxejMPDjlQbsORH3n43RvRi6KFTpi3ocIy+lsn5LgFRXZPUi
         LQnzlClShQm6JsYXsm3LOUN3eCF/iJbZB0DM9Yf7GQy3BmXhFafcESi4/L1ko6kPS8sT
         qC2WbOSl6cMo0Rc63zKLoTnkCi33dNmkXJt33unlm/Ft8/P2LvsmlZzywMiMb8ZeihiM
         x0ATeeOnjc+2mraW/kbnEarYGg8uTq6TzxclYbluPmr9fNdop0GAddgzIWEjh4MhIqEU
         NnUY6aIfKmv9Kdvv4+VQmV60O5hMMpfgO7IrPgCIJEAChSY9+UZHB1Tt0UVz5Oau0kII
         l+8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Tue, 20 Mar 2018 06:29:24 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-f3f59fbc54b76945ebc92772bd86f60728205da3@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, mingo@kernel.org, pombredanne@nexb.com,
        hpa@zytor.com
Reply-To: pombredanne@nexb.com, hpa@zytor.com, mingo@kernel.org,
        gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de
In-Reply-To: <20180314212030.668321222@linutronix.de>
References: <20180314212030.668321222@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Remove license boilerplate/references
Git-Commit-ID: f3f59fbc54b76945ebc92772bd86f60728205da3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595463510277302739?=
X-GMAIL-MSGID: =?utf-8?q?1595463510277302739?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  f3f59fbc54b76945ebc92772bd86f60728205da3
Gitweb:     https://git.kernel.org/tip/f3f59fbc54b76945ebc92772bd86f60728205da3
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Tue, 20 Mar 2018 14:17:04 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 20 Mar 2018 14:23:28 +0100

genirq: Remove license boilerplate/references

Now that SPDX identifiers are in place, remove the boilerplate or
references.

The change in timings.c has been acked by the author.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Link: https://lkml.kernel.org/r/20180314212030.668321222@linutronix.de
---
 kernel/irq/debugfs.c |  7 ++-----
 kernel/irq/timings.c | 10 ++--------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index c8cc6ce9c1c3..4dadeb3d6666 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright 2017 Thomas Gleixner <tglx@linutronix.de>
- *
- * This file is licensed under the GPL V2.
- */
+// Copyright 2017 Thomas Gleixner <tglx@linutronix.de>
+
 #include <linux/irqdomain.h>
 #include <linux/irq.h>
 #include <linux/uaccess.h>
diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 223d47937c48..1e4cb63a5c82 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -1,12 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2016, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
+// Copyright (C) 2016, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
+
 #include <linux/kernel.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
