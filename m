Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753265AbeFAS3e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:29:34 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:36805 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752268AbeFAS3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:29:32 -0400
IronPort-PHdr: =?us-ascii?q?9a23=3ApNxBVhGqhmlaEpiqirdRc51GYnF86YWxBRYc798d?=
 =?us-ascii?q?s5kLTJ7zoM+wAkXT6L1XgUPTWs2DsrQY07eQ6/iocFdDyK7JiGoFfp1IWk1Nou?=
 =?us-ascii?q?QttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZr?=
 =?us-ascii?q?KeTpAI7SiNm82/yv95HJbAhEmDqwbaluIBmqsA7cqtQYjYx+J6gr1xDHuGFIe+?=
 =?us-ascii?q?NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PGAu+MLrrxjD?=
 =?us-ascii?q?QhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VC+85Kl3VhDnlC?=
 =?us-ascii?q?YHNyY48G7JjMxwkLlbqw+lqxBm3oLYfJ2ZOP94c6jAf90VWHBBU95RWSJfH42y?=
 =?us-ascii?q?YYgBAe0aMOpEs4XwvUcCoAGiCQWwAu7k1z9GhmXx3a0/y+ktHwHH3Q0gH90UsX?=
 =?us-ascii?q?TYsMn5OakJXOCo0KbI1y/PYO1L1jfg5oTDbxcsoPGNXLJwa8XRyFUjGx/Lg1iL?=
 =?us-ascii?q?tIzqIymV2v4TvGeG8uptTOSigHMkpQFpujWj2Nsgh43Tio8Wyl3I7zh1zYIrKd?=
 =?us-ascii?q?GiVkJ3fcKoHINNuyybM4Z6WN0uTm9otSog1LELuIS3cSoFxZkh2hXRceaIc5KS?=
 =?us-ascii?q?7RLmTOuRJDB4i297d7+nnBay9FSgyvX7VsmpzFZGtipFncfItnAKzxHT79KISv?=
 =?us-ascii?q?p5/ku4wTaP2Rzf5vhKIUwqiabXN4QtwrE3lpoUvkTDGjH5lF/qg6+Rc0Uo4umo?=
 =?us-ascii?q?6+L5bbX6vpKQKZN4hwXkPqktmsGzG/k0PwwQU2SB5+iwyKHv8VX8QLpQj/02lq?=
 =?us-ascii?q?fZsIrdJcQevqO4Aw5U0oY55Ba+EzuqzNoVkGIaLF1ZYhKLlZbmNEzTIPzgF/ew?=
 =?us-ascii?q?n0yskCt3x/DBJrDhBpTNLn7ekLbuZLp96FBTyBA1zd9B45JZEa8BIP3tVU/rrt?=
 =?us-ascii?q?DYDQE2Mxayw+n5DNVxzIQeWXiAAvzRDKSHk1iF/O1nGe6BaIIR8GL/LOIiz67k?=
 =?us-ascii?q?nGM0ghkaZ6b/mdMWb3W9A9xiIl6Fejzog9EcASIEuRc4QOX2iVqEFzlJaDL6W6?=
 =?us-ascii?q?M6+yF+C4+8C4rHbp6ijabH3yqhGJBSIGdcBQOiC3DtIs+VSfcFaXrKeed8mSZC?=
 =?us-ascii?q?WLS8Acd1xAOuvQ6ik+FPM+HOvCAUqMSwh5BO++TPmERqpnRPBMOH3jTIFjkskw?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2C1AADUjxFbhsjAVdFcGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYVMjFqMCIJuk1eBeAEKLIRAggchNRcBAgEBAQEBAQIBEwEBAQgLCwg?=
 =?us-ascii?q?oL4I1JAGCfFIpbAEFASIBEoMiggGbODyMcTOHVwEHHkSBaAkBCIYBgixUgT+BD?=
 =?us-ascii?q?4JYinwCgSMBAQGLbItZAQYBAQECgS2NNIdihTABK5BHAgQCCQIFDyGBIQGCCHK?=
 =?us-ascii?q?Ba4Emgi6OQE98jm4BAQ?=
X-IPAS-Result: =?us-ascii?q?A2C1AADUjxFbhsjAVdFcGgEBAQEBAgEBAQEIAQEBAYVMjFq?=
 =?us-ascii?q?MCIJuk1eBeAEKLIRAggchNRcBAgEBAQEBAQIBEwEBAQgLCwgoL4I1JAGCfFIpb?=
 =?us-ascii?q?AEFASIBEoMiggGbODyMcTOHVwEHHkSBaAkBCIYBgixUgT+BD4JYinwCgSMBAQG?=
 =?us-ascii?q?LbItZAQYBAQECgS2NNIdihTABK5BHAgQCCQIFDyGBIQGCCHKBa4Emgi6OQE98j?=
 =?us-ascii?q?m4BAQ?=
X-IronPort-AV: E=Sophos;i="5.49,467,1520924400";
   d="scan'208";a="959951326"
X-Google-Smtp-Source: ADUXVKJeCxjQM3YIMf6VCA4SycWNUwhl263aWYLzUXa8I2fx6MgpIq9jHnmNvbVl9Chl5IQX84lNTg==
From: "yzhai003@ucr.edu" <yzhai003@ucr.edu>
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc: yzhai003@ucr.edu, csong@cs.ucr.edu, zhiyunq@cs.ucr.edu
Subject: [PATCH] iommu/amd: Argument page_size could be uninitialized
Date: Fri,  1 Jun 2018 11:30:14 -0700
Message-Id: <1527877815-11132-1-git-send-email-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Argument "page_size" passing to function "fetch_pte" could be
uninitialized if the function returns NULL

The caller "iommu_unmap_page" checks the return value but the page_size is
used outside the if block.

Signed-off-by: yzhai003@ucr.edu <yzhai003@ucr.edu>
---
 drivers/iommu/amd_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8fb8c73..7c15eaf 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1398,6 +1398,8 @@ static u64 *fetch_pte(struct protection_domain *domain,
 	int level;
 	u64 *pte;
 
+	*page_size = 0;
+
 	if (address > PM_LEVEL_SIZE(domain->mode))
 		return NULL;
 
-- 
2.7.4
