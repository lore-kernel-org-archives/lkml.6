Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753543AbeCUTbD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:31:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753338AbeCUTYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:24:18 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 16/32] docs/vm: numa: convert to ReST format
Date: Wed, 21 Mar 2018 21:22:32 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0012-0000-0000-000005C1DEB8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0013-0000-0000-0000193E03DF
Message-Id: <1521660168-14372-17-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210221
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/vm/numa | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/vm/numa b/Documentation/vm/numa
index a31b85b..c81e7c5 100644
--- a/Documentation/vm/numa
+++ b/Documentation/vm/numa
@@ -1,6 +1,10 @@
+.. _numa:
+
 Started Nov 1999 by Kanoj Sarcar <kanoj@sgi.com>
 
+=============
 What is NUMA?
+=============
 
 This question can be answered from a couple of perspectives:  the
 hardware view and the Linux software view.
-- 
2.7.4
