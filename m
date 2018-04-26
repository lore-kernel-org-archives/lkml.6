Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755680AbeDZUd7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:33:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42569 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753665AbeDZUd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:33:58 -0400
Date: Thu, 26 Apr 2018 13:33:52 -0700
From: tip-bot for Bartosz Golaszewski <tipbot@zytor.com>
Message-ID: <tip-275220ca6e694c3fc1702487a14432dc414df58f@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        brgl@bgdev.pl, hpa@zytor.com
Reply-To: hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, brgl@bgdev.pl
In-Reply-To: <20180426200747.8344-1-brgl@bgdev.pl>
References: <20180426200747.8344-1-brgl@bgdev.pl>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/irq_sim: Remove the license boilerplate
Git-Commit-ID: 275220ca6e694c3fc1702487a14432dc414df58f
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

Commit-ID:  275220ca6e694c3fc1702487a14432dc414df58f
Gitweb:     https://git.kernel.org/tip/275220ca6e694c3fc1702487a14432dc414df58f
Author:     Bartosz Golaszewski <brgl@bgdev.pl>
AuthorDate: Thu, 26 Apr 2018 22:07:46 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 26 Apr 2018 22:26:39 +0200

genirq/irq_sim: Remove the license boilerplate

There is the SPDX license identifier now in the irq simulator. Remove the
license boilerplate.

While at it: update the copyright notice, since I did some changes in 2018.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20180426200747.8344-1-brgl@bgdev.pl

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
