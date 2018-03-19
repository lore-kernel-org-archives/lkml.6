Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754913AbeCSAw4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 20:52:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56307 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754867AbeCSAwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 20:52:47 -0400
X-Google-Smtp-Source: AG47ELtylZiC/oAQd3gbAozkL4wj1BLWyuGWJut6C8uwi2Hh8TAZ8qZGL5vuaEa2CzrXyUy40q4yAA==
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Cc: daniel.vetter@intel.com, gustavo@padovan.org, seanpaul@chromium.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] GPU: drm: Fixed Coding issue
Date: Mon, 19 Mar 2018 00:52:25 +0000
Message-Id: <20180319005225.1545-4-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319005225.1545-1-paulmcquad@gmail.com>
References: <20180319005225.1545-1-paulmcquad@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

code indent should use tabs where possible

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 drivers/gpu/drm/drm_bufs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
index 8e345ba16858..ba8cfe65c65b 100644
--- a/drivers/gpu/drm/drm_bufs.c
+++ b/drivers/gpu/drm/drm_bufs.c
@@ -1446,8 +1446,8 @@ int drm_legacy_freebufs(struct drm_device *dev, void *data,
 int __drm_legacy_mapbufs(struct drm_device *dev, void *data, int *p,
 			 void __user **v,
 			 int (*f)(void *, int, unsigned long,
-				  struct drm_buf *),
-		         struct drm_file *file_priv)
+				 struct drm_buf *),
+				 struct drm_file *file_priv)
 {
 	struct drm_device_dma *dma = dev->dma;
 	int retcode = 0;
-- 
2.16.2
