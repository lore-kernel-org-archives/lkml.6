Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeBHTJU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 14:09:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752089AbeBHTJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 14:09:19 -0500
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH] mm/swap.c: make functions and their kernel-doc agree (again)
Date: Thu,  8 Feb 2018 21:09:06 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18020819-0016-0000-0000-00000520E06B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020819-0017-0000-0000-0000285D9B06
Message-Id: <1518116946-20947-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802080219
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a conflict between the commit e02a9f048ef7 ("mm/swap.c: make
functions and their kernel-doc agree") and the commit f144c390f905 ("mm:
docs: fix parameter names mismatch") that both tried to fix mismatch
betweeen pagevec_lookup_entries() parameter names and their description.

Since nr_entries is a better name for the parameter, fix the description
again.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 mm/swap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index 567a7b96e41d..6d7b8bc58003 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -913,7 +913,7 @@ EXPORT_SYMBOL(__pagevec_lru_add);
  * @pvec:	Where the resulting entries are placed
  * @mapping:	The address_space to search
  * @start:	The starting entry index
- * @nr_pages:	The maximum number of pages
+ * @nr_entries:	The maximum number of pages
  * @indices:	The cache indices corresponding to the entries in @pvec
  *
  * pagevec_lookup_entries() will search for and return a group of up
-- 
2.7.4
