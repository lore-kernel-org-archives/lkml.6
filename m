Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbeBWABR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 19:01:17 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36517 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752223AbeBWABO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 19:01:14 -0500
X-Google-Smtp-Source: AH8x225PZ73lcMLX5kS9Sg/BDqgXDynSeCtu0mVp5XdD7ky2cL2v7GzedbEsKZziwqUl9jGVZheExg==
Date: Thu, 22 Feb 2018 21:01:10 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 7/7] drm/virtio: Add spaces around operators
Message-ID: <8402b55696b44483ba2e1f6aaeb53bf709ffbfe7.1519343668.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1519343668.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1519343668.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl check:

virtgpu_ioctl.c:535: CHECK: spaces preferred around that '|' (ctx:VxV)
virtgpu_vq.c:277: CHECK: spaces preferred around that '+' (ctx:VxV)
...

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 18 +++++++++---------
 drivers/gpu/drm/virtio/virtgpu_vq.c    |  6 +++---
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index d52a86eaa884..04e09fc56f66 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -532,34 +532,34 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
 
 struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS] = {
 	DRM_IOCTL_DEF_DRV(VIRTGPU_MAP, virtio_gpu_map_ioctl,
-			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+			  DRM_AUTH | DRM_UNLOCKED | DRM_RENDER_ALLOW),
 
 	DRM_IOCTL_DEF_DRV(VIRTGPU_EXECBUFFER, virtio_gpu_execbuffer_ioctl,
-			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+			  DRM_AUTH | DRM_UNLOCKED | DRM_RENDER_ALLOW),
 
 	DRM_IOCTL_DEF_DRV(VIRTGPU_GETPARAM, virtio_gpu_getparam_ioctl,
-			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+			  DRM_AUTH | DRM_UNLOCKED | DRM_RENDER_ALLOW),
 
 	DRM_IOCTL_DEF_DRV(VIRTGPU_RESOURCE_CREATE,
 			  virtio_gpu_resource_create_ioctl,
-			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+			  DRM_AUTH | DRM_UNLOCKED | DRM_RENDER_ALLOW),
 
 	DRM_IOCTL_DEF_DRV(VIRTGPU_RESOURCE_INFO, virtio_gpu_resource_info_ioctl,
-			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+			  DRM_AUTH | DRM_UNLOCKED | DRM_RENDER_ALLOW),
 
 	/* make transfer async to the main ring? - no sure, can we
 	 * thread these in the underlying GL
 	 */
 	DRM_IOCTL_DEF_DRV(VIRTGPU_TRANSFER_FROM_HOST,
 			  virtio_gpu_transfer_from_host_ioctl,
-			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+			  DRM_AUTH | DRM_UNLOCKED | DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(VIRTGPU_TRANSFER_TO_HOST,
 			  virtio_gpu_transfer_to_host_ioctl,
-			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+			  DRM_AUTH | DRM_UNLOCKED | DRM_RENDER_ALLOW),
 
 	DRM_IOCTL_DEF_DRV(VIRTGPU_WAIT, virtio_gpu_wait_ioctl,
-			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+			  DRM_AUTH | DRM_UNLOCKED | DRM_RENDER_ALLOW),
 
 	DRM_IOCTL_DEF_DRV(VIRTGPU_GET_CAPS, virtio_gpu_get_caps_ioctl,
-			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+			  DRM_AUTH | DRM_UNLOCKED | DRM_RENDER_ALLOW),
 };
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 18c78a7fa044..48e4f1df6e5d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -274,7 +274,7 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 		return -ENODEV;
 
 	sg_init_one(&vcmd, vbuf->buf, vbuf->size);
-	sgs[outcnt+incnt] = &vcmd;
+	sgs[outcnt + incnt] = &vcmd;
 	outcnt++;
 
 	if (vbuf->data_size) {
@@ -709,8 +709,8 @@ void virtio_gpu_cmd_context_create(struct virtio_gpu_device *vgdev, uint32_t id,
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_CTX_CREATE);
 	cmd_p->hdr.ctx_id = cpu_to_le32(id);
 	cmd_p->nlen = cpu_to_le32(nlen);
-	strncpy(cmd_p->debug_name, name, sizeof(cmd_p->debug_name)-1);
-	cmd_p->debug_name[sizeof(cmd_p->debug_name)-1] = 0;
+	strncpy(cmd_p->debug_name, name, sizeof(cmd_p->debug_name) - 1);
+	cmd_p->debug_name[sizeof(cmd_p->debug_name) - 1] = 0;
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 }
 
-- 
2.16.2
