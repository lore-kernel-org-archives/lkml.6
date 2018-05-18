Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752416AbeERHiO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:38:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35401 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbeERHiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:38:13 -0400
Date: Fri, 18 May 2018 00:37:54 -0700
From: tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-cd33d8803bfa3f5e6e5d7a4bb03fc8cc32c40fb6@git.kernel.org>
Cc: bigeasy@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, pjt@google.com
Reply-To: mingo@kernel.org, peterz@infradead.org, bigeasy@linutronix.de,
        torvalds@linux-foundation.org, pjt@google.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20180515165328.24899-1-bigeasy@linutronix.de>
References: <20180515165328.24899-1-bigeasy@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/fair: Fix documentation file path
Git-Commit-ID: cd33d8803bfa3f5e6e5d7a4bb03fc8cc32c40fb6
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

Commit-ID:  cd33d8803bfa3f5e6e5d7a4bb03fc8cc32c40fb6
Gitweb:     https://git.kernel.org/tip/cd33d8803bfa3f5e6e5d7a4bb03fc8cc32c40fb6
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Tue, 15 May 2018 18:53:28 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 18 May 2018 09:05:28 +0200

sched/fair: Fix documentation file path

The 'tip' prefix probably referred to the -tip tree and is not required,
remove it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180515165328.24899-1-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index f013afc74b11..18b151f0ddc1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -738,7 +738,7 @@ config CFS_BANDWIDTH
 	  tasks running within the fair group scheduler.  Groups with no limit
 	  set are considered to be unconstrained and will run with no
 	  restriction.
-	  See tip/Documentation/scheduler/sched-bwc.txt for more information.
+	  See Documentation/scheduler/sched-bwc.txt for more information.
 
 config RT_GROUP_SCHED
 	bool "Group scheduling for SCHED_RR/FIFO"
