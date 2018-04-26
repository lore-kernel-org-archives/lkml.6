Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756083AbeDZUIC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:08:02 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36766 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755737AbeDZUIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:08:00 -0400
X-Google-Smtp-Source: AB8JxZr8LwAdQfr66fubz5WcC91e+MJlc44KCTL49PWPJBUbUYPSy0dCfyMrbIngx6ijXe7PuY11lw==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 2/2] genirq/irq_sim: use the SPDX license identifier in the header
Date: Thu, 26 Apr 2018 22:07:47 +0200
Message-Id: <20180426200747.8344-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426200747.8344-1-brgl@bgdev.pl>
References: <20180426200747.8344-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use C-style comment for the identifier as per
Documentation/process/license-rules.rst and remove the license
boilerplate.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
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
 
-- 
2.17.0
