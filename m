Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4E9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E695121736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500989;
	bh=IzT99dF4Xdu11I+Q+B3iBBsl+0BVBcuB90YJgOYqZSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cq1rl5EdZGfIHCfiespZ8nIik0faqE1xuT9wWxBbAh5+Cgfpam8tMcS6/+N8O3Qu5
	 cpd9DeCMr+y4fvdD1oLXflGegg9GKvA4iYAtsaUbqImJDPV3DkQ2TKM+siUNWttEzl
	 2dVwRw5bu/N3ad1xyI86OeUdpBeyAqyxIDub0rwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbfBROnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:43:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:57102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732071AbfBRNtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:49:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18E8321901;
        Mon, 18 Feb 2019 13:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497782;
        bh=IzT99dF4Xdu11I+Q+B3iBBsl+0BVBcuB90YJgOYqZSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v+6UMx63SPTyRlZ9qxGyNv80EDIjTfXb18NFD0X2Pl2XtLa9uXJYQzL/VgPudQOPI
         bLCGLjtTdIwi/1pQiOpLytmSTvuQJXHHOBBSLzkFX7GjsjVEW04H1CqyulvW2gpVN9
         dhvomWZeJyQV3LdSWVAtmAP26SP9FJ92Fk8BPH/M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.20 89/92] drm/vkms: Fix license inconsistent
Date:   Mon, 18 Feb 2019 14:43:32 +0100
Message-Id: <20190218133503.652568884@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/gpu/drm/vkms/vkms_crc.c    |    3 ++-
 drivers/gpu/drm/vkms/vkms_crtc.c   |    8 +-------
 drivers/gpu/drm/vkms/vkms_drv.c    |    7 +------
 drivers/gpu/drm/vkms/vkms_drv.h    |    2 ++
 drivers/gpu/drm/vkms/vkms_gem.c    |    8 +-------
 drivers/gpu/drm/vkms/vkms_output.c |    8 +-------
 drivers/gpu/drm/vkms/vkms_plane.c  |    8 +-------
 7 files changed, 9 insertions(+), 35 deletions(-)

--- a/drivers/gpu/drm/vkms/vkms_crc.c
+++ b/drivers/gpu/drm/vkms/vkms_crc.c
@@ -1,4 +1,5 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
+
 #include "vkms_drv.h"
 #include <linux/crc32.h>
 #include <drm/drm_atomic.h>
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
 
 /**
  * DOC: vkms (Virtual Kernel Modesetting)
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


