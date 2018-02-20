Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeBTXZ6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:25:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751978AbeBTXZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:25:05 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/lkmm 07/12] Documentation/memory-barriers.txt: Cross-reference "tools/memory-model/"
Date: Tue, 20 Feb 2018 15:25:07 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180220232405.GA19274@linux.vnet.ibm.com>
References: <20180220232405.GA19274@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022023-2213-0000-0000-000002730527
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008566; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00992685; UDB=6.00504342; IPR=6.00772031;
 MB=3.00019661; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-20 23:25:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022023-2214-0000-0000-0000592F0721
Message-Id: <1519169112-20593-7-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=3
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802200276
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com>

A memory consistency model is now available for the Linux kernel [1],
which "can (roughly speaking) be thought of as an automated version of
memory-barriers.txt" and which is (in turn) "accompanied by extensive
documentation on its use and its design".

Inform the (occasional) reader of memory-barriers.txt of these
developments.

[1] https://marc.info/?l=linux-kernel&m=151687290114799&w=2

Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/memory-barriers.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 479ecec80593..74ad222d11ed 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -14,7 +14,11 @@ DISCLAIMER
 This document is not a specification; it is intentionally (for the sake of
 brevity) and unintentionally (due to being human) incomplete. This document is
 meant as a guide to using the various memory barriers provided by Linux, but
-in case of any doubt (and there are many) please ask.
+in case of any doubt (and there are many) please ask.  Some doubts may be
+resolved by referring to the formal memory consistency model and related
+documentation at tools/memory-model/.  Nevertheless, even this memory
+model should be viewed as the collective opinion of its maintainers rather
+than as an infallible oracle.
 
 To repeat, this document is not a specification of what Linux expects from
 hardware.
-- 
2.5.2
