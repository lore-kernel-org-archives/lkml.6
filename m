Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeDYFQY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 01:16:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:64024 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751302AbeDYFP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 01:15:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,325,1520924400";
   d="scan'208";a="223170593"
From: Tiwei Bie <tiwei.bie@intel.com>
To: mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com
Subject: [RFC v3 5/5] virtio_ring: enable packed ring
Date: Wed, 25 Apr 2018 13:15:50 +0800
Message-Id: <20180425051550.24342-6-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180425051550.24342-1-tiwei.bie@intel.com>
References: <20180425051550.24342-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b1039c2985b9..9a3d13e1e2ba 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1873,6 +1873,8 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		case VIRTIO_F_IOMMU_PLATFORM:
 			break;
+		case VIRTIO_F_RING_PACKED:
+			break;
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
-- 
2.11.0
