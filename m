Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755900AbeDZUec (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:34:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37457 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753975AbeDZUea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:34:30 -0400
Date: Thu, 26 Apr 2018 13:34:25 -0700
From: tip-bot for Bartosz Golaszewski <tipbot@zytor.com>
Message-ID: <tip-b5c5f3959bb3c018a68f5659bcd6adf05e141a03@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, brgl@bgdev.pl
Reply-To: brgl@bgdev.pl, linux-kernel@vger.kernel.org, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20180426200747.8344-2-brgl@bgdev.pl>
References: <20180426200747.8344-2-brgl@bgdev.pl>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/irq_sim: Use the SPDX license identifier in
 the header
Git-Commit-ID: b5c5f3959bb3c018a68f5659bcd6adf05e141a03
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b5c5f3959bb3c018a68f5659bcd6adf05e141a03
Gitweb:     https://git.kernel.org/tip/b5c5f3959bb3c018a68f5659bcd6adf05e141a03
Author:     Bartosz Golaszewski <brgl@bgdev.pl>
AuthorDate: Thu, 26 Apr 2018 22:07:47 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 26 Apr 2018 22:26:39 +0200

genirq/irq_sim: Use the SPDX license identifier in the header

Use C-style comment for the identifier as per
Documentation/process/license-rules.rst and remove the license boilerplate.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20180426200747.8344-2-brgl@bgdev.pl

---
 include/linux/irq_sim.h | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
index 0380d899b955..630a57e55db6 100644
--- a/include/linux/irq_sim.h
+++ b/include/linux/irq_sim.h
@@ -1,14 +1,11 @@
-#ifndef _LINUX_IRQ_SIM_H
-#define _LINUX_IRQ_SIM_H
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2017 Bartosz Golaszewski <brgl@bgdev.pl>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
+ * Copyright (C) 2017-2018 Bartosz Golaszewski <brgl@bgdev.pl>
  */
 
+#ifndef _LINUX_IRQ_SIM_H
+#define _LINUX_IRQ_SIM_H
+
 #include <linux/irq_work.h>
 #include <linux/device.h>
 
