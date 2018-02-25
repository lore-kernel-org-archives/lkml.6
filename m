Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeBYTAN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 14:00:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751699AbeBYTAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 14:00:08 -0500
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, linux-doc <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 2/3] mm/swap: remove @cold parameter description for release_pages
Date: Sun, 25 Feb 2018 20:59:50 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519585191-10180-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1519585191-10180-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022519-0008-0000-0000-000004D44A14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022519-0009-0000-0000-00001E676153
Message-Id: <1519585191-10180-3-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802250253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'cold' parameter was removed from release_pages function by the commit
c6f92f9fbe7db ("mm: remove cold parameter for release_pages").
Update the description to match the code.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 mm/swap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index 0f17330dd0e5..3dd518832096 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -707,7 +707,6 @@ void lru_add_drain_all(void)
  * release_pages - batched put_page()
  * @pages: array of pages to release
  * @nr: number of pages
- * @cold: whether the pages are cache cold
  *
  * Decrement the reference count on all the pages in @pages.  If it
  * fell to zero, remove the page from the LRU and free it.
-- 
2.7.4
