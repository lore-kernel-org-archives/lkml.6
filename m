Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932184AbeDCMct (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:32:49 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33616 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932080AbeDCMcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:32:47 -0400
X-Google-Smtp-Source: AIpwx49rFHgt4MJd8dg0yP37DGHfWQeMJNgSy1ldAPpwyO5+z3rDGalpKQjKVKDiOVASp279NrjeDQ==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc: andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH] MAINTAINERS: Add drm/xen-front maintainer entry
Date: Tue,  3 Apr 2018 15:32:38 +0300
Message-Id: <20180403123238.19294-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Add myself as drivers/gpu/drm/xen maintainer.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 622f3e4c5efa..6cf1bd5593b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4834,6 +4834,15 @@ S:	Maintained
 F:	drivers/gpu/drm/tinydrm/
 F:	include/drm/tinydrm/
 
+DRM DRIVERS FOR XEN
+M:	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+L:	dri-devel@lists.freedesktop.org
+L:	xen-devel@lists.xen.org
+S:	Supported
+F:	drivers/gpu/drm/xen/
+F:	Documentation/gpu/xen-front.rst
+
 DRM TTM SUBSYSTEM
 M:	Christian Koenig <christian.koenig@amd.com>
 M:	Roger He <Hongbo.He@amd.com>
-- 
2.16.2
