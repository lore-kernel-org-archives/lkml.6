Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeDRINS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:13:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753149AbeDRIIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:08:10 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 3/7] docs/vm: pagemap: formatting and spelling updates
Date: Wed, 18 Apr 2018 11:07:46 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524038870-413-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1524038870-413-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041808-0008-0000-0000-000004EC91C4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041808-0009-0000-0000-00001E809A7C
Message-Id: <1524038870-413-4-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180076
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/vm/pagemap.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/vm/pagemap.rst b/Documentation/vm/pagemap.rst
index d54b4bf..9644bc0 100644
--- a/Documentation/vm/pagemap.rst
+++ b/Documentation/vm/pagemap.rst
@@ -13,7 +13,7 @@ There are four components to pagemap:
  * ``/proc/pid/pagemap``.  This file lets a userspace process find out which
    physical frame each virtual page is mapped to.  It contains one 64-bit
    value for each virtual page, containing the following data (from
-   fs/proc/task_mmu.c, above pagemap_read):
+   ``fs/proc/task_mmu.c``, above pagemap_read):
 
     * Bits 0-54  page frame number (PFN) if present
     * Bits 0-4   swap type if swapped
@@ -36,7 +36,7 @@ There are four components to pagemap:
    precisely which pages are mapped (or in swap) and comparing mapped
    pages between processes.
 
-   Efficient users of this interface will use /proc/pid/maps to
+   Efficient users of this interface will use ``/proc/pid/maps`` to
    determine which areas of memory are actually mapped and llseek to
    skip over unmapped regions.
 
@@ -79,11 +79,11 @@ There are four components to pagemap:
    memory cgroup each page is charged to, indexed by PFN. Only available when
    CONFIG_MEMCG is set.
 
-Short descriptions to the page flags:
-=====================================
+Short descriptions to the page flags
+====================================
 
 0 - LOCKED
-   page is being locked for exclusive access, eg. by undergoing read/write IO
+   page is being locked for exclusive access, e.g. by undergoing read/write IO
 7 - SLAB
    page is managed by the SLAB/SLOB/SLUB/SLQB kernel memory allocator
    When compound page is used, SLUB/SLQB will only set this flag on the head
@@ -132,7 +132,7 @@ IO related page flags
    ie. for file backed page: (in-memory data revision >= on-disk one)
 4 - DIRTY
    page has been written to, hence contains new data
-   ie. for file backed page: (in-memory data revision >  on-disk one)
+   i.e. for file backed page: (in-memory data revision >  on-disk one)
 8 - WRITEBACK
    page is being synced to disk
 
@@ -145,7 +145,7 @@ LRU related page flags
    page is in the active LRU list
 18 - UNEVICTABLE
    page is in the unevictable (non-)LRU list It is somehow pinned and
-   not a candidate for LRU page reclaims, eg. ramfs pages,
+   not a candidate for LRU page reclaims, e.g. ramfs pages,
    shmctl(SHM_LOCK) and mlock() memory segments
 2 - REFERENCED
    page has been referenced since last LRU list enqueue/requeue
@@ -156,7 +156,7 @@ LRU related page flags
 12 - ANON
    a memory mapped page that is not part of a file
 13 - SWAPCACHE
-   page is mapped to swap space, ie. has an associated swap entry
+   page is mapped to swap space, i.e. has an associated swap entry
 14 - SWAPBACKED
    page is backed by swap/RAM
 
-- 
2.7.4
