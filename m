Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756708AbeDZUIY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:08:24 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42506 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbeDZUH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:07:58 -0400
X-Google-Smtp-Source: AIpwx4/uVpJ4Qxlv7Wevp/oXb58FuYm68YeznhqFHlYT7Awchf55usmaMd9z6lH4Z5mX+MwMoWojnQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 1/2] genirq/irq_sim: remove the license boilerplate
Date: Thu, 26 Apr 2018 22:07:46 +0200
Message-Id: <20180426200747.8344-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have the SPDX license identifier in the irq simulator. Remove
the license boilerplate.

While we're at it: update the copyright notice, since I did some
changes in 2018.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 kernel/irq/irq_sim.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index fc4f361a86bb..dd20d0d528d4 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -1,11 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Bartosz Golaszewski <brgl@bgdev.pl>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
+ * Copyright (C) 2017-2018 Bartosz Golaszewski <brgl@bgdev.pl>
  */
 
 #include <linux/slab.h>
-- 
2.17.0
