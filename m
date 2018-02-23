Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeBWABE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 19:01:04 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:44152 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeBWABB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 19:01:01 -0500
X-Google-Smtp-Source: AH8x227y+NMCvKVF/S1PMrITnI7E+PV9r9XirnxoB0x0iaiQ4AW56uLTsWT4+zMeNGOw/E6yUVQ0Cw==
Date: Thu, 22 Feb 2018 21:00:57 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 6/7] drm/virtio: Remove multiple blank lines
Message-ID: <c43a006f2ed93a16fe824b4a2686a2d5e2ef56f5.1519343668.git.rodrigosiqueiramelo@gmail.com>
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

virtgpu_drv.c:116: CHECK: Please don't use multiple blank lines
virtgpu_vq.c:599: CHECK: Please don't use multiple blank lines
virtgpu_prime.c:42: CHECK: Please don't use multiple blank lines

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c   | 1 -
 drivers/gpu/drm/virtio/virtgpu_prime.c | 1 -
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 5d21433b1cdf..d9287c144fe5 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -113,7 +113,6 @@ static const struct file_operations virtio_gpu_driver_fops = {
 	.llseek = noop_llseek,
 };
 
-
 static struct drm_driver driver = {
 	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME | DRIVER_RENDER | DRIVER_ATOMIC,
 	.load = virtio_gpu_driver_load,
diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index 6c6e9dbab096..d27a1688714f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -39,7 +39,6 @@ void virtgpu_gem_prime_unpin(struct drm_gem_object *obj)
 	WARN_ONCE(1, "not implemented");
 }
 
-
 struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj)
 {
 	WARN_ONCE(1, "not implemented");
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 809d20eb6571..18c78a7fa044 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -596,7 +596,6 @@ static void virtio_gpu_cmd_capset_cb(struct virtio_gpu_device *vgdev,
 	wake_up(&vgdev->resp_wq);
 }
 
-
 int virtio_gpu_cmd_get_display_info(struct virtio_gpu_device *vgdev)
 {
 	struct virtio_gpu_ctrl_hdr *cmd_p;
-- 
2.16.2
