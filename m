Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932137AbeEOQxh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:53:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60841 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbeEOQxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:53:35 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] sched/cfs: correct path to documentation
Date: Tue, 15 May 2018 18:53:28 +0200
Message-Id: <20180515165328.24899-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `tip' prefix probably referred to the tip tree and is not required.
Remove it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
=20
 config RT_GROUP_SCHED
 	bool "Group scheduling for SCHED_RR/FIFO"
--=20
2.17.0
