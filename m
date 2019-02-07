Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8F3C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5952721927
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfBGOWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:22:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50660 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727118AbfBGOWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:22:21 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x17EHJhM018808
        for <linux-kernel@vger.kernel.org>; Thu, 7 Feb 2019 09:22:20 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qgmp4w9td-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 09:22:20 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 7 Feb 2019 14:22:19 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Feb 2019 14:22:13 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x17EMCKD16580672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Feb 2019 14:22:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A541B206B;
        Thu,  7 Feb 2019 14:22:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30048B205F;
        Thu,  7 Feb 2019 14:22:12 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.235.4])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Feb 2019 14:22:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1FCEB16C6B81; Thu,  7 Feb 2019 06:18:25 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH v2 tip/core/rcu 16/19] linux/srcu: Convert to SPDX license identifier
Date:   Thu,  7 Feb 2019 06:18:20 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207141700.GA11106@linux.ibm.com>
References: <20190207141700.GA11106@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19020714-0072-0000-0000-000003F6567A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010554; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01157626; UDB=6.00603959; IPR=6.00938157;
 MB=3.00025480; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-07 14:22:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020714-0073-0000-0000-00004B180129
Message-Id: <20190207141823.12311-16-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-07_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902070111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the license boiler plate with a SPDX license identifier.
While in the area, update an email address.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
[ paulmck: Update ,h SPDX format per Joe Perches. ]
---
 include/linux/srcu.h     | 17 ++---------------
 include/linux/srcutiny.h | 17 ++---------------
 include/linux/srcutree.h | 17 ++---------------
 3 files changed, 6 insertions(+), 45 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index c614375cd264..0d5fed02df16 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -1,24 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Sleepable Read-Copy Update mechanism for mutual exclusion
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
  * Copyright (C) IBM Corporation, 2006
  * Copyright (C) Fujitsu, 2012
  *
- * Author: Paul McKenney <paulmck@us.ibm.com>
+ * Author: Paul McKenney <paulmck@linux.ibm.com>
  *	   Lai Jiangshan <laijs@cn.fujitsu.com>
  *
  * For detailed explanation of Read-Copy Update mechanism see -
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index b19216aaaef2..5a5a1941ca15 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -1,24 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Sleepable Read-Copy Update mechanism for mutual exclusion,
  *	tiny variant.
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
  * Copyright (C) IBM Corporation, 2017
  *
- * Author: Paul McKenney <paulmck@us.ibm.com>
+ * Author: Paul McKenney <paulmck@linux.ibm.com>
  */
 
 #ifndef _LINUX_SRCU_TINY_H
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 6f292bd3e7db..de7a42116b2e 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -1,24 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Sleepable Read-Copy Update mechanism for mutual exclusion,
  *	tree variant.
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
  * Copyright (C) IBM Corporation, 2017
  *
- * Author: Paul McKenney <paulmck@us.ibm.com>
+ * Author: Paul McKenney <paulmck@linux.ibm.com>
  */
 
 #ifndef _LINUX_SRCU_TREE_H
-- 
2.17.1

