Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbeBIOYS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:24:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752306AbeBIOWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:22:04 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/lkmm 05/10] README: Fix a couple of punctuation errors
Date: Fri,  9 Feb 2018 06:20:26 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180209141832.GA17505@linux.vnet.ibm.com>
References: <20180209141832.GA17505@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18020914-2213-0000-0000-0000026A442B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008504; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000250; SDB=6.00987227; UDB=6.00501083; IPR=6.00766586;
 BA=6.00005821; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019457; XFM=3.00000015;
 UTC=2018-02-09 14:21:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020914-2214-0000-0000-0000590E295F
Message-Id: <1518186031-17997-5-git-send-email-paulmck@linux.vnet.ibm.com>
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

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/litmus-tests/README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 9a3bb5949191..dca7d823ad57 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -23,14 +23,14 @@ IRIW+mbonceonces+OnceOnce.litmus
 	between each pairs of reads.  In other words, is smp_mb()
 	sufficient to cause two different reading processes to agree on
 	the order of a pair of writes, where each write is to a different
-	variable by a different process.
+	variable by a different process?
 
 IRIW+poonceonces+OnceOnce.litmus
 	Test of independent reads from independent writes with nothing
 	between each pairs of reads.  In other words, is anything at all
 	needed to cause two different reading processes to agree on the
 	order of a pair of writes, where each write is to a different
-	variable by a different process.
+	variable by a different process?
 
 ISA2+poonceonces.litmus
 	As below, but with store-release replaced with WRITE_ONCE()
-- 
2.5.2
