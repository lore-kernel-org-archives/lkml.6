Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbeBIOWU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:22:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752305AbeBIOWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:22:05 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/lkmm 06/10] EXP MAINTAINERS: Add the "LKMM" acronym
Date: Fri,  9 Feb 2018 06:20:27 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180209141832.GA17505@linux.vnet.ibm.com>
References: <20180209141832.GA17505@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18020914-2213-0000-0000-0000026A442C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008504; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000250; SDB=6.00987227; UDB=6.00501083; IPR=6.00766586;
 BA=6.00005821; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019457; XFM=3.00000015;
 UTC=2018-02-09 14:21:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020914-2214-0000-0000-0000590E295C
Message-Id: <1518186031-17997-6-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802090184
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds "(LKMM)" to the end of the MAINTAINERS file's entry
for the Linux-kernel memory-consistency model.

If people are OK with this, it should be squashed into 12a62a1d0703
("MAINTAINERS: Add the Memory Consistency Model subsystem").

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e6ad9b44e8fb..674b35c3f28e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8086,7 +8086,7 @@ M:	Kees Cook <keescook@chromium.org>
 S:	Maintained
 F:	drivers/misc/lkdtm*
 
-LINUX KERNEL MEMORY CONSISTENCY MODEL
+LINUX KERNEL MEMORY CONSISTENCY MODEL (LKMM)
 M:	Alan Stern <stern@rowland.harvard.edu>
 M:	Andrea Parri <parri.andrea@gmail.com>
 M:	Will Deacon <will.deacon@arm.com>
-- 
2.5.2
