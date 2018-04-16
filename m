Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753176AbeDPQL4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:11:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752497AbeDPQLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:11:46 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 13/17] memory-model: Fix cheat sheet typo
Date: Mon, 16 Apr 2018 09:12:41 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180416161209.GA6895@linux.vnet.ibm.com>
References: <20180416161209.GA6895@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041616-0008-0000-0000-000002F7CC5D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008863; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01018801; UDB=6.00519703; IPR=6.00798042;
 MB=3.00020599; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-16 16:11:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041616-0009-0000-0000-000038EBC85E
Message-Id: <1523895165-17576-13-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160146
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

"RWM" should be "RMW".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/Documentation/cheatsheet.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index 956b1ae4aafb..c0eafdaddfa4 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -1,6 +1,6 @@
                                   Prior Operation     Subsequent Operation
                                   ---------------  ---------------------------
-                               C  Self  R  W  RWM  Self  R  W  DR  DW  RMW  SV
+                               C  Self  R  W  RMW  Self  R  W  DR  DW  RMW  SV
                               --  ----  -  -  ---  ----  -  -  --  --  ---  --
 
 Store, e.g., WRITE_ONCE()            Y                                       Y
-- 
2.5.2
