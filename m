Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4726C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07332186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbfBFNVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:21:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730205AbfBFNRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:17:48 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x16DE3lt005104
        for <linux-kernel@vger.kernel.org>; Wed, 6 Feb 2019 08:17:45 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qfy84ccqq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 08:17:45 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 6 Feb 2019 13:17:45 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Feb 2019 13:17:38 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x16DHbX619726402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 13:17:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1D2EB2076;
        Wed,  6 Feb 2019 13:17:37 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 875FBB205F;
        Wed,  6 Feb 2019 13:17:37 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.158.219])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  6 Feb 2019 13:17:37 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CBBF916C6B3C; Wed,  6 Feb 2019 05:16:14 -0800 (PST)
Date:   Wed, 6 Feb 2019 05:16:14 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/19] SPDX changes for v5.1
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19020613-0060-0000-0000-000003067597
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010547; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01157129; UDB=6.00603658; IPR=6.00937658;
 MB=3.00025463; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-06 13:17:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020613-0061-0000-0000-00004832B793
Message-Id: <20190206131614.GA17320@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=588 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series makes SPDX and email-address changes to RCU source files.

							Thanx, Paul

------------------------------------------------------------------------

 include/linux/rcu_node_tree.h |   17 ++---------------
 include/linux/rcu_segcblist.h |   17 ++---------------
 include/linux/rcu_sync.h      |   15 +--------------
 include/linux/rcupdate.h      |   17 ++---------------
 include/linux/rcutiny.h       |   17 ++---------------
 include/linux/rcutree.h       |   19 +++----------------
 include/linux/srcu.h          |   17 ++---------------
 include/linux/srcutiny.h      |   17 ++---------------
 include/linux/srcutree.h      |   17 ++---------------
 include/linux/torture.h       |   17 ++---------------
 kernel/locking/locktorture.c  |   19 +++----------------
 kernel/rcu/rcu.h              |   17 ++---------------
 kernel/rcu/rcu_segcblist.c    |   17 ++---------------
 kernel/rcu/rcu_segcblist.h    |   17 ++---------------
 kernel/rcu/rcuperf.c          |   19 +++----------------
 kernel/rcu/rcutorture.c       |   19 +++----------------
 kernel/rcu/srcutiny.c         |   17 ++---------------
 kernel/rcu/srcutree.c         |   17 ++---------------
 kernel/rcu/sync.c             |   15 +--------------
 kernel/rcu/tiny.c             |   17 ++---------------
 kernel/rcu/tree.c             |   19 +++----------------
 kernel/rcu/tree.h             |   17 ++---------------
 kernel/rcu/tree_exp.h         |   17 ++---------------
 kernel/rcu/tree_plugin.h      |   17 ++---------------
 kernel/rcu/update.c           |   17 ++---------------
 kernel/torture.c              |   19 +++----------------
 26 files changed, 56 insertions(+), 394 deletions(-)

