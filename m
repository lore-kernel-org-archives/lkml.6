Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeEPIjV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:39:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:30628 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752490AbeEPIhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:37:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="41347788"
From: Tiwei Bie <tiwei.bie@intel.com>
To: mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com
Subject: [RFC v4 5/5] virtio_ring: enable packed ring
Date: Wed, 16 May 2018 16:37:37 +0800
Message-Id: <20180516083737.26504-6-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516083737.26504-1-tiwei.bie@intel.com>
References: <20180516083737.26504-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index de3839f3621a..b158692263b0 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1940,6 +1940,8 @@ void vring_transport_features(struct virtio_device *vdev)
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
