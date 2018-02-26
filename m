Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeBZVww (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:52:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751505AbeBZVwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:52:50 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        Lihao Liang <lianglihao@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 04/20] doc: Fix typo in rcutorture documentation
Date: Mon, 26 Feb 2018 13:52:54 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226215219.GA27379@linux.vnet.ibm.com>
References: <20180226215219.GA27379@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022621-0040-0000-0000-000003FD5BD8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995530; UDB=6.00506033; IPR=6.00774858;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:52:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-0041-0000-0000-000007FE65E7
Message-Id: <1519681990-31349-4-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260274
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lihao Liang <lianglihao@huawei.com>

Signed-off-by: Lihao Liang <lianglihao@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/testing/selftests/rcutorture/doc/rcu-test-image.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt b/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt
index 66efb59a1bd1..449cf579d6f9 100644
--- a/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt
+++ b/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt
@@ -1,4 +1,4 @@
-This document describes one way to created the rcu-test-image file
+This document describes one way to create the rcu-test-image file
 that contains the filesystem used by the guest-OS kernel.  There are
 probably much better ways of doing this, and this filesystem could no
 doubt be smaller.  It is probably also possible to simply download
-- 
2.5.2
