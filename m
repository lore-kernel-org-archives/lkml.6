Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeFAKW2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 06:22:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:34496 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750871AbeFAKW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:22:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,465,1520924400";
   d="scan'208";a="60926958"
From: Tiwei Bie <tiwei.bie@intel.com>
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org
Subject: [PATCH] virtio: update the comments for transport features
Date: Fri,  1 Jun 2018 18:22:17 +0800
Message-Id: <20180601102217.21628-1-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
This patch is generated on top of below patch:
https://lists.oasis-open.org/archives/virtio-dev/201805/msg00212.html

 include/uapi/linux/virtio_config.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index b7c1f4e7d59e..479affd903e9 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -45,9 +45,12 @@
 /* We've given up on this device. */
 #define VIRTIO_CONFIG_S_FAILED		0x80
 
-/* Some virtio feature bits (currently bits 28 through 32) are reserved for the
- * transport being used (eg. virtio_ring), the rest are per-device feature
- * bits. */
+/*
+ * Some virtio feature bits (currently bits VIRTIO_TRANSPORT_F_START
+ * through VIRTIO_TRANSPORT_F_END) are reserved for the transport being
+ * used (e.g. virtio_ring, virtio_pci etc.), the rest are per-device
+ * feature bits.
+ */
 #define VIRTIO_TRANSPORT_F_START	28
 #define VIRTIO_TRANSPORT_F_END		38
 
-- 
2.17.0
