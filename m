Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753552AbeCUTZY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:25:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753141AbeCUTZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:25:10 -0400
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
Subject: [PATCH 28/32] docs/vm: z3fold.txt: convert to ReST format
Date: Wed, 21 Mar 2018 21:22:44 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0020-0000-0000-00000407E61D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0021-0000-0000-0000429C06CD
Message-Id: <1521660168-14372-29-git-send-email-rppt@linux.vnet.ibm.com>
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
 Documentation/vm/z3fold.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/vm/z3fold.txt b/Documentation/vm/z3fold.txt
index 38e4dac..224e3c6 100644
--- a/Documentation/vm/z3fold.txt
+++ b/Documentation/vm/z3fold.txt
@@ -1,5 +1,8 @@
+.. _z3fold:
+
+======
 z3fold
-------
+======
 
 z3fold is a special purpose allocator for storing compressed pages.
 It is designed to store up to three compressed pages per physical page.
@@ -7,6 +10,7 @@ It is a zbud derivative which allows for higher compression
 ratio keeping the simplicity and determinism of its predecessor.
 
 The main differences between z3fold and zbud are:
+
 * unlike zbud, z3fold allows for up to PAGE_SIZE allocations
 * z3fold can hold up to 3 compressed pages in its page
 * z3fold doesn't export any API itself and is thus intended to be used
-- 
2.7.4
