Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbeEDFRh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 01:17:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:30967 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751361AbeEDFRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 01:17:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,361,1520924400";
   d="scan'208";a="48196471"
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 4/4] iommu/vt-d: Remove unnecessary parentheses
Date: Fri,  4 May 2018 13:08:19 +0800
Message-Id: <1525410499-18632-5-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
References: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses to comply with preferred coding
style.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index e8cd984..45f6e58 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -319,7 +319,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 	} else
 		pasid_max = 1 << 20;
 
-	if ((flags & SVM_FLAG_SUPERVISOR_MODE)) {
+	if (flags & SVM_FLAG_SUPERVISOR_MODE) {
 		if (!ecap_srs(iommu->ecap))
 			return -EINVAL;
 	} else if (pasid) {
-- 
2.7.4
