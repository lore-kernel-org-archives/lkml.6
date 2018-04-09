Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754697AbeDIUHj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 16:07:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35339 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754676AbeDIUHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 16:07:36 -0400
X-Google-Smtp-Source: AIpwx48+jQOmmvhPTgbNsBm1Vlf3SLeibLQkBRtQ8MBn39pzzouu6TVk1EsgsTjZFHzTgczj6M2qRA==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] Tegra GART fixes and improvements
Date: Mon,  9 Apr 2018 23:07:18 +0300
Message-Id: <cover.1523304324.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART driver wasn't ever been utilized in upstream, but finally this should
change sometime soon with Tegra's DRM driver rework. In general GART driver
works fine, though there are couple things that could be improved.

Dmitry Osipenko (4):
  iommu/tegra: gart: Add debugging facility
  iommu/tegra: gart: Fix gart_iommu_unmap()
  iommu/tegra: gart: Constify number of GART pages
  iommu/tegra: gart: Optimize map/unmap

 drivers/iommu/tegra-gart.c | 90 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 69 insertions(+), 21 deletions(-)

-- 
2.16.3
