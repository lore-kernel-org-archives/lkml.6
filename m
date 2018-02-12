Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932500AbeBLVbl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 16:31:41 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41204 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932104AbeBLVbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 16:31:38 -0500
X-Google-Smtp-Source: AH8x224XbguciQ64I9Lk5CctDQgpd7AdIxlWNbMmSzicJ+AvgRTMoiu2fwtQ4n5yk0xqF6w9Kgd27A==
From: Kangmin Park <l4stpr0gr4m@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org,
        Kangmin Park <l4stpr0gr4m@gmail.com>
Subject: [PATCH] Fix a misspelling in kernel/cpu.c
Date: Tue, 13 Feb 2018 06:29:15 +0900
Message-Id: <1518470955-4646-1-git-send-email-l4stpr0gr4m@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial patch to fix a misspelling in kernel/cpu.c
Fix 'synchronsization' to 'synchronization' in comment

Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
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
