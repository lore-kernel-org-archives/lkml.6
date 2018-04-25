Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeDYFwP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 01:52:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7628 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750882AbeDYFwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 01:52:12 -0400
From: Li Bin <huawei.libin@huawei.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        <huawei.libin@huawei.com>
Subject: [PATCH] sched: fix typo in error message
Date: Wed, 25 Apr 2018 13:41:40 +0800
Message-ID: <1524634900-1861-1-git-send-email-huawei.libin@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 64cc564..cf15c1c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1618,7 +1618,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 
 		if (!cpumask_subset(sched_domain_span(child),
 				    sched_domain_span(sd))) {
-			pr_err("BUG: arch topology borken\n");
+			pr_err("BUG: arch topology broken\n");
 #ifdef CONFIG_SCHED_DEBUG
 			pr_err("     the %s domain not a subset of the %s domain\n",
 					child->name, sd->name);
-- 
1.7.12.4
