Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752390AbeEOBoa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 21:44:30 -0400
Received: from vern.gendns.com ([206.190.152.46]:58172 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752162AbeEOBoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 21:44:24 -0400
From: David Lechner <david@lechnology.com>
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        limor@ladyada.net, Nitin Patil <nitin@mindsensors.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] MAINTAINERS: fix path to ilitek,ili9225 device tree bindings
Date: Mon, 14 May 2018 20:43:47 -0500
Message-Id: <20180515014349.26226-2-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515014349.26226-1-david@lechnology.com>
References: <20180515014349.26226-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the path to the ilitek,ili9225 device tree binding file.

Signed-off-by: David Lechner <david@lechnology.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 334a00350922..bc219de9cbee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4478,7 +4478,7 @@ DRM DRIVER FOR ILITEK ILI9225 PANELS
 M:	David Lechner <david@lechnology.com>
 S:	Maintained
 F:	drivers/gpu/drm/tinydrm/ili9225.c
-F:	Documentation/devicetree/bindings/display/ili9225.txt
+F:	Documentation/devicetree/bindings/display/ilitek,ili9225.txt
 
 DRM DRIVER FOR INTEL I810 VIDEO CARDS
 S:	Orphan / Obsolete
-- 
2.17.0
