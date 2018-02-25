Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbeBYTAC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 14:00:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751699AbeBYTAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 14:00:00 -0500
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, linux-doc <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 0/3] mm: docs: more trivial updates
Date: Sun, 25 Feb 2018 20:59:48 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18022518-0016-0000-0000-000005299CB6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022518-0017-0000-0000-00002865C0E9
Message-Id: <1519585191-10180-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802250253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's another set of (mostly) trivial updates for kernel-doc descriptions
in the mm code.

Mike Rapoport (3):
  mm/nommu: remove description of alloc_vm_area
  mm/swap: remove @cold parameter description for release_pages
  mm: kernel-doc: add missing parameter descriptions

 mm/cma.c            |  5 +++++
 mm/compaction.c     |  1 +
 mm/kmemleak.c       | 10 ++++++++++
 mm/memory_hotplug.c |  6 ++++++
 mm/nommu.c          | 12 ------------
 mm/oom_kill.c       |  2 ++
 mm/pagewalk.c       |  3 +++
 mm/rmap.c           |  1 +
 mm/swap.c           |  1 -
 mm/zsmalloc.c       |  2 ++
 10 files changed, 30 insertions(+), 13 deletions(-)

-- 
2.7.4
