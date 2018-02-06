Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbeBFRHn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:07:43 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46383 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbeBFQul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:50:41 -0500
X-Google-Smtp-Source: AH8x225lfWfoY6WNmGrKtSSV/A6QJkhFtWdbrUpq4iRkOt7Nf3HxmPQB0rI06gPt3hNNOWlQo6vMOw==
From: l4stpr0gr4m@gmail.com
To: tglx@linutronix.de
Cc: mingo@kernel.org, peterz@infradead.org, bigeasy@linutronix.de,
        paulmck@linux.vnet.ibm.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Kangmin Park <l4stpr0gr4m@gmail.com>
Subject: [PATCH] Fix a misspelling in kernel/cpu.c
Date: Wed,  7 Feb 2018 01:50:26 +0900
Message-Id: <1517935826-11867-1-git-send-email-l4stpr0gr4m@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangmin Park <l4stpr0gr4m@gmail.com>

Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>

Sorry for sending duplicate.

A trivial path to fix a typo in kernel/cpu.c
Fix 'synchronsization' to 'synchronization'

---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 53f7dc6..9a1ee53 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1336,7 +1336,7 @@ static struct cpuhp_step cpuhp_ap_states[] = {
 		.teardown.single	= smpcfd_dying_cpu,
 	},
 	/* Entry state on starting. Interrupts enabled from here on. Transient
-	 * state for synchronsization */
+	 * state for synchronization */
 	[CPUHP_AP_ONLINE] = {
 		.name			= "ap:online",
 	},
-- 
2.7.4
