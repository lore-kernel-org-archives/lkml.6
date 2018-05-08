Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754534AbeEHHCb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:02:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754154AbeEHHC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:02:29 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-doc <linux-doc@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 2/3] docs/vm: numa_memory_policy: s/Linux memory policy/NUMA memory policy/
Date: Tue,  8 May 2018 10:02:09 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525762930-28163-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1525762930-28163-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050807-0020-0000-0000-0000041A3C7D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050807-0021-0000-0000-000042AF741E
Message-Id: <1525762930-28163-3-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-08_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805080069
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The document describes NUMA memory policy and as it is a part of the Linux
documentation it's obvious that this is Linux memory policy. Besides,
"Linux memory policy" may refer to other policies, e.g. memory hotplug
policy, and using term NUMA makes the documentation less ambiguous.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/vm/numa_memory_policy.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/vm/numa_memory_policy.rst b/Documentation/vm/numa_memory_policy.rst
index ac0b396..d78c5b3 100644
--- a/Documentation/vm/numa_memory_policy.rst
+++ b/Documentation/vm/numa_memory_policy.rst
@@ -1,10 +1,10 @@
 .. _numa_memory_policy:
 
-===================
-Linux Memory Policy
-===================
+==================
+NUMA Memory Policy
+==================
 
-What is Linux Memory Policy?
+What is NUMA Memory Policy?
 ============================
 
 In the Linux kernel, "memory policy" determines from which node the kernel will
@@ -162,7 +162,7 @@ Shared Policy
 Components of Memory Policies
 -----------------------------
 
-A Linux memory policy consists of a "mode", optional mode flags, and
+A NUMA memory policy consists of a "mode", optional mode flags, and
 an optional set of nodes.  The mode determines the behavior of the
 policy, the optional mode flags determine the behavior of the mode,
 and the optional set of nodes can be viewed as the arguments to the
@@ -172,7 +172,7 @@ Internally, memory policies are implemented by a reference counted
 structure, struct mempolicy.  Details of this structure will be
 discussed in context, below, as required to explain the behavior.
 
-Linux memory policy supports the following 4 behavioral modes:
+NUMA memory policy supports the following 4 behavioral modes:
 
 Default Mode--MPOL_DEFAULT
 	This mode is only used in the memory policy APIs.  Internally,
@@ -245,7 +245,7 @@ MPOL_INTERLEAVED
 	address range or file.  During system boot up, the temporary
 	interleaved system default policy works in this mode.
 
-Linux memory policy supports the following optional mode flags:
+NUMA memory policy supports the following optional mode flags:
 
 MPOL_F_STATIC_NODES
 	This flag specifies that the nodemask passed by
-- 
2.7.4
