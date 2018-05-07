Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeEGDC2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 23:02:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751852AbeEGDCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 23:02:25 -0400
To: <alex.williamson@redhat.com>, <corbet@lwn.net>
CC: <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: "dongbo (E)" <dongbo4@huawei.com>
Subject: [PATCH] vfio: fix documentation
Message-ID: <eacddc78-279c-abe8-e663-9849973dd6a3@huawei.com>
Date: Mon, 7 May 2018 11:02:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.195.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Bo <dongbo4@huawei.com>

Update vfio_add_group_dev description to match the current API.

Signed-off-by: Dong Bo <dongbo4@huawei.com>
---
 Documentation/vfio.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
index ef6a511..f1a4d3c 100644
--- a/Documentation/vfio.txt
+++ b/Documentation/vfio.txt
@@ -252,15 +252,14 @@ into VFIO core.  When devices are bound and unbound to the driver,
 the driver should call vfio_add_group_dev() and vfio_del_group_dev()
 respectively::

-	extern int vfio_add_group_dev(struct iommu_group *iommu_group,
-	                              struct device *dev,
+	extern int vfio_add_group_dev(struct device *dev,
 				      const struct vfio_device_ops *ops,
 				      void *device_data);

 	extern void *vfio_del_group_dev(struct device *dev);

 vfio_add_group_dev() indicates to the core to begin tracking the
-specified iommu_group and register the specified dev as owned by
+iommu_group of the specified dev and register the dev as owned by
 a VFIO bus driver.  The driver provides an ops structure for callbacks
 similar to a file operations structure::

-- 
1.9.1


.
