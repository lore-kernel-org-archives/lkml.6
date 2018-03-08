Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934819AbeCHCDR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:03:17 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:33734 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934698AbeCHCDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:03:15 -0500
X-Google-Smtp-Source: AG47ELvhN/yr0fFryjr9RSgdeUirSxGetqbs0koCvzoV/HavZ4XGcl2q25tsj/01tUD6iw1BFXYsxw==
Date: Wed, 7 Mar 2018 23:03:12 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] drm/vgem: Replace uint32_t for u32
Message-ID: <386320c12f1414cdf13bdadabed0f4f3287a7538.1520474055.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520474055.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520474055.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl check:

vgem_drv.c:229: CHECK: Prefer kernel type 'u32' over 'uint32_t'

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vgem/vgem_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index 5767030d04a8..bf704ed51da4 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -226,7 +226,7 @@ static int vgem_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 }
 
 static int vgem_gem_dumb_map(struct drm_file *file, struct drm_device *dev,
-			     uint32_t handle, uint64_t *offset)
+			     u32 handle, uint64_t *offset)
 {
 	struct drm_gem_object *obj;
 	int ret;
-- 
2.16.2
