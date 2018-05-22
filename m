Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbeEVIRd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:17:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:23530 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751512AbeEVIR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:17:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,429,1520924400";
   d="scan'208";a="51200185"
From: Tiwei Bie <tiwei.bie@intel.com>
To: mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com
Subject: [RFC v5 5/5] virtio_ring: enable packed ring
Date: Tue, 22 May 2018 16:16:48 +0800
Message-Id: <20180522081648.14768-6-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522081648.14768-1-tiwei.bie@intel.com>
References: <20180522081648.14768-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1ee52a89cb04..355dfef4f1eb 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1956,6 +1956,8 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		case VIRTIO_F_IOMMU_PLATFORM:
 			break;
+		case VIRTIO_F_RING_PACKED:
+			break;
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
-- 
2.17.0
