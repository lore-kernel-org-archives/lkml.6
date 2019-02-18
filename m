Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE38C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D21621901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498048;
	bh=KjkbFpmmkAvwPvGMvfbw+MdWRMKccZwO7UQFYJwP/lM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w11V/bT9OrfQ5AvOOBIKHB8Tt5qxqPpX4u5yMVpdi4c1QChNQETbe3IgQmVdpsUnd
	 O1ISP1szDbVwPVl/NhbY1iKcH7kcvK0mnjvMag1h+l3dFDc/ASL425U4916GYt4oz2
	 Oq/7XOWm+PTLUgCdUgLcHOeQKJbXSWGg3YNmDzgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbfBRNyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:54:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733093AbfBRNyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:54:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34920208E4;
        Mon, 18 Feb 2019 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498041;
        bh=KjkbFpmmkAvwPvGMvfbw+MdWRMKccZwO7UQFYJwP/lM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SeC6lWfSIg1x6dLh8mrBiuqkpV0XFIETJp8ivLKIrVR5TfjSoj1kI/AtQ/2sZMpWC
         Y47HIUwpjAf+uxL7e2ya3ioscHz1BxKcsLobyGltvcfmjWS6IVvKVpVaRrze5/GqHO
         DfBmyI0EC6i0BmTmwJ2mmekTkX0laETWVCa9vllc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.19 82/85] drm/vkms: Fix license inconsistent
Date:   Mon, 18 Feb 2019 14:43:48 +0100
Message-Id: <20190218133507.882959527@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

commit 7fd56e0260a22c0cfaf9adb94a2427b76e239dd0 upstream.

Fixes license inconsistent related to the VKMS driver and remove the
redundant boilerplate comment.

Fixes: 854502fa0a38 ("drm/vkms: Add basic CRTC initialization")

Cc: stable@vger.kernel.org
Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20190206140116.7qvy2lpwbcd7wds6@smtp.gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vkms/vkms_crtc.c   |    8 +-------
 drivers/gpu/drm/vkms/vkms_drv.c    |    7 +------
 drivers/gpu/drm/vkms/vkms_drv.h    |    2 ++
 drivers/gpu/drm/vkms/vkms_gem.c    |    8 +-------
 drivers/gpu/drm/vkms/vkms_output.c |    8 +-------
 drivers/gpu/drm/vkms/vkms_plane.c  |    8 +-------
 6 files changed, 7 insertions(+), 34 deletions(-)

--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -1,10 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
 
 #include "vkms_drv.h"
 #include <drm/drm_atomic_helper.h>
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -1,9 +1,4 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/module.h>
 #include <drm/drm_gem.h>
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
 #ifndef _VKMS_DRV_H_
 #define _VKMS_DRV_H_
 
--- a/drivers/gpu/drm/vkms/vkms_gem.c
+++ b/drivers/gpu/drm/vkms/vkms_gem.c
@@ -1,10 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/shmem_fs.h>
 
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -1,10 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
 
 #include "vkms_drv.h"
 #include <drm/drm_crtc_helper.h>
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -1,10 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
 
 #include "vkms_drv.h"
 #include <drm/drm_plane_helper.h>


