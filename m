Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27B1B605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752295AbeFFFKk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 01:10:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752234AbeFFFKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 01:10:38 -0400
From: Masatake YAMATO <yamato@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, yamato@redhat.com
Subject: [PATCH] x86/iommu: Fix a typo in a macro parameter
Date: Wed,  6 Jun 2018 14:10:26 +0900
Message-Id: <20180606051026.29535-1-yamato@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 arch/x86/include/asm/iommu_table.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/iommu_table.h b/arch/x86/include/asm/iommu_table.h
index 1fb3fd1a83c2..2a0d5f7d1ed1 100644
--- a/arch/x86/include/asm/iommu_table.h
+++ b/arch/x86/include/asm/iommu_table.h
@@ -66,7 +66,7 @@ struct iommu_table_entry {
 #define IOMMU_INIT_POST(_detect)					\
 	__IOMMU_INIT(_detect, pci_swiotlb_detect_4gb,  NULL, NULL, 0)
 
-#define IOMMU_INIT_POST_FINISH(detect)					\
+#define IOMMU_INIT_POST_FINISH(_detect)					\
 	__IOMMU_INIT(_detect, pci_swiotlb_detect_4gb,  NULL, NULL, 1)
 
 /*
-- 
2.17.0
