Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeBHTJ6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 14:09:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752154AbeBHTJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 14:09:57 -0500
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH] mm/zpool: zpool_evictable: fix mismatch in parameter name and kernel-doc
Date: Thu,  8 Feb 2018 21:09:44 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18020819-0008-0000-0000-000004CAE139
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020819-0009-0000-0000-00001E5E9633
Message-Id: <1518116984-21141-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802080219
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 mm/zpool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zpool.c b/mm/zpool.c
index f8cb83e7699b..9d53a1ef8f1e 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -360,7 +360,7 @@ u64 zpool_get_total_size(struct zpool *zpool)
 
 /**
  * zpool_evictable() - Test if zpool is potentially evictable
- * @pool	The zpool to test
+ * @zpool	The zpool to test
  *
  * Zpool is only potentially evictable when it's created with struct
  * zpool_ops.evict and its driver implements struct zpool_driver.shrink.
-- 
2.7.4
