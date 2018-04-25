Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932150AbeDYRnS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:43:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39908 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756094AbeDYRnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:43:11 -0400
X-Google-Smtp-Source: AB8JxZo9PLmeYjYiMUxUab6fdg9AuPXDTBcZQN8oxJbQIynCZzclGlZkEpFVJwohy+Wo298mBrR8NQ==
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 6/6] MAINTAINERS: add dri-devel for backlight subsystem patches
Date: Wed, 25 Apr 2018 19:42:53 +0200
Message-Id: <20180425174253.4616-6-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425174253.4616-1-daniel.vetter@ffwll.ch>
References: <20180425174253.4616-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the same reasons we've added dri-devel for all fbdev patches: Most
of the actively developed drivers using this infrastructure are in
drivers/gpu/. It just makes sense to cross-post patches and keep
aligned. And total activity in the backlight subsystem is miniscule
compared to drm overall.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa72c117bcd5..0f902399a348 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2589,6 +2589,7 @@ BACKLIGHT CLASS/SUBSYSTEM
 M:	Lee Jones <lee.jones@linaro.org>
 M:	Daniel Thompson <daniel.thompson@linaro.org>
 M:	Jingoo Han <jingoohan1@gmail.com>
+L:	dri-devel@lists.freedesktop.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git
 S:	Maintained
 F:	drivers/video/backlight/
-- 
2.17.0
