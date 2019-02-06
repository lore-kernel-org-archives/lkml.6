Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A0AC4151A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429E62186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbfBFNSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:18:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730702AbfBFNR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:17:58 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x16DDvFU120812
        for <linux-kernel@vger.kernel.org>; Wed, 6 Feb 2019 08:17:57 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qfxarfx9v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 08:17:54 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 6 Feb 2019 13:17:43 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Feb 2019 13:17:38 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x16DHbqb21299406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 13:17:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99CB5B2066;
        Wed,  6 Feb 2019 13:17:37 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71690B206E;
        Wed,  6 Feb 2019 13:17:37 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.158.219])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  6 Feb 2019 13:17:37 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3C44316C6B46; Wed,  6 Feb 2019 05:16:47 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 06/19] rcu/sync: Convert to SPDX license identifier
Date:   Wed,  6 Feb 2019 05:16:31 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206131614.GA17320@linux.ibm.com>
References: <20190206131614.GA17320@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19020613-2213-0000-0000-0000034B291A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010547; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01157129; UDB=6.00603658; IPR=6.00937658;
 MB=3.00025463; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-06 13:17:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020613-2214-0000-0000-00005D40D5ED
Message-Id: <20190206131644.23281-6-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the license boiler plate with a SPDX license identifier.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/sync.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index be10036fa621..a8304d90573f 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * RCU-based infrastructure for lightweight reader-writer locking
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, you can access it online at
- * http://www.gnu.org/licenses/gpl-2.0.html.
- *
  * Copyright (c) 2015, Red Hat, Inc.
  *
  * Author: Oleg Nesterov <oleg@redhat.com>
-- 
2.17.1

