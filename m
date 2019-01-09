Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE70C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C205206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfAIVlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:41:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726090AbfAIVlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:41:51 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LelV6021292
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:41:49 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwnq7gxmu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:41:49 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:41:49 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:41:45 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LfiH922478926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:41:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65E5CB206C;
        Wed,  9 Jan 2019 21:41:44 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 479C1B206A;
        Wed,  9 Jan 2019 21:41:44 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:41:44 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1F6C616C63FE; Wed,  9 Jan 2019 13:41:44 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 5/8] rcu: Repair rcu_nmi_exit() docbook header
Date:   Wed,  9 Jan 2019 13:41:39 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109214115.GA2835@linux.ibm.com>
References: <20190109214115.GA2835@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-2213-0000-0000-00000339970D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144149; UDB=6.00595711; IPR=6.00924412;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:41:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-2214-0000-0000-00005CE7FD06
Message-Id: <20190109214142.4428-5-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes the "@irq" argument from the rcu_nmi_exit() docbook
header, given that this function now has no arguments.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 36b04b41f2c9..ede942c2b965 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -701,7 +701,6 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 
 /**
  * rcu_nmi_exit - inform RCU of exit from NMI context
- * @irq: Is this call from rcu_irq_exit?
  *
  * If you add or remove a call to rcu_nmi_exit(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
-- 
2.17.1

