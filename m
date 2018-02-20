Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbeBTX1d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:27:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751860AbeBTXZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:25:04 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/lkmm 02/12] MAINTAINERS: Add the Memory Consistency Model subsystem
Date: Tue, 20 Feb 2018 15:25:02 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180220232405.GA19274@linux.vnet.ibm.com>
References: <20180220232405.GA19274@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022023-0048-0000-0000-0000023C74F9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008566; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00992685; UDB=6.00504342; IPR=6.00772031;
 MB=3.00019661; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-20 23:25:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022023-0049-0000-0000-000044330359
Message-Id: <1519169112-20593-2-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802200276
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com>

Move the contents of tools/memory-model/MAINTAINERS into the main
MAINTAINERS file, removing tools/memory-model/MAINTAINERS. This
allows get_maintainer.pl to correctly identify the maintainers of
tools/memory-model/.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 MAINTAINERS                    | 16 ++++++++++++++++
 tools/memory-model/MAINTAINERS | 15 ---------------
 2 files changed, 16 insertions(+), 15 deletions(-)
 delete mode 100644 tools/memory-model/MAINTAINERS

diff --git a/MAINTAINERS b/MAINTAINERS
index e3581413420c..50bcedbdca86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8086,6 +8086,22 @@ M:	Kees Cook <keescook@chromium.org>
 S:	Maintained
 F:	drivers/misc/lkdtm*
 
+LINUX KERNEL MEMORY CONSISTENCY MODEL (LKMM)
+M:	Alan Stern <stern@rowland.harvard.edu>
+M:	Andrea Parri <parri.andrea@gmail.com>
+M:	Will Deacon <will.deacon@arm.com>
+M:	Peter Zijlstra <peterz@infradead.org>
+M:	Boqun Feng <boqun.feng@gmail.com>
+M:	Nicholas Piggin <npiggin@gmail.com>
+M:	David Howells <dhowells@redhat.com>
+M:	Jade Alglave <j.alglave@ucl.ac.uk>
+M:	Luc Maranget <luc.maranget@inria.fr>
+M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
+F:	tools/memory-model/
+
 LINUX SECURITY MODULE (LSM) FRAMEWORK
 M:	Chris Wright <chrisw@sous-sol.org>
 L:	linux-security-module@vger.kernel.org
diff --git a/tools/memory-model/MAINTAINERS b/tools/memory-model/MAINTAINERS
deleted file mode 100644
index db3bd3fc0435..000000000000
--- a/tools/memory-model/MAINTAINERS
+++ /dev/null
@@ -1,15 +0,0 @@
-LINUX KERNEL MEMORY CONSISTENCY MODEL
-M:	Alan Stern <stern@rowland.harvard.edu>
-M:	Andrea Parri <parri.andrea@gmail.com>
-M:	Will Deacon <will.deacon@arm.com>
-M:	Peter Zijlstra <peterz@infradead.org>
-M:	Boqun Feng <boqun.feng@gmail.com>
-M:	Nicholas Piggin <npiggin@gmail.com>
-M:	David Howells <dhowells@redhat.com>
-M:	Jade Alglave <j.alglave@ucl.ac.uk>
-M:	Luc Maranget <luc.maranget@inria.fr>
-M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
-L:	linux-kernel@vger.kernel.org
-S:	Supported
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
-F:	tools/memory-model/
-- 
2.5.2
