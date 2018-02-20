Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbeBTX0n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:26:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751930AbeBTXZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:25:04 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/lkmm 09/12] tools/memory-model: Add required herd7 version to README file
Date: Tue, 20 Feb 2018 15:25:09 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180220232405.GA19274@linux.vnet.ibm.com>
References: <20180220232405.GA19274@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022023-2213-0000-0000-000002730528
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008566; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00992685; UDB=6.00504342; IPR=6.00772031;
 MB=3.00019661; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-20 23:25:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022023-2214-0000-0000-0000592F0722
Message-Id: <1519169112-20593-9-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802200276
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LKMM and the herd7 tool are co-evolving, and out-of-date herd7 tools
produce inaccurate results, often with no obvious error messages.  This
commit therefore adds the required herd7 version to the LKMM README file.

Longer term, it would be good if .cat files could specify the required
version in a manner allowing herd7 to produce clear diagnostics.

Suggested-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/README | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index 91414a49fac5..ea950c566ffd 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -20,7 +20,8 @@ that litmus test to be exercised within the Linux kernel.
 REQUIREMENTS
 ============
 
-The "herd7" and "klitmus7" tools must be downloaded separately:
+Version 7.48 of the "herd7" and "klitmus7" tools must be downloaded
+separately:
 
   https://github.com/herd/herdtools7
 
-- 
2.5.2
