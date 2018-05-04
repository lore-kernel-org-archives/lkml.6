Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbeEDFRR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 01:17:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:30967 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEDFRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 01:17:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,361,1520924400";
   d="scan'208";a="48196447"
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/4] iommu/vt-d: Several cleanup patches
Date: Fri,  4 May 2018 13:08:15 +0800
Message-Id: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This includes several cleanup patches which aim to make the
code more concise and easier for reading. There aren't any
functionality changes.

Best regards,
Lu Baolu

Lu Baolu (4):
  iommu: Clean up the comments for iommu_group_alloc
  iommu/vt-d: Clean up unused variable in find_or_alloc_domain
  iommu/vt-d: Clean up pasid quirk for pre-production devices
  iommu/vt-d: Remove unnecessary parentheses

 drivers/iommu/intel-iommu.c | 36 +++---------------------------------
 drivers/iommu/intel-svm.c   |  2 +-
 drivers/iommu/iommu.c       |  1 -
 include/linux/intel-iommu.h |  1 -
 4 files changed, 4 insertions(+), 36 deletions(-)

-- 
2.7.4
