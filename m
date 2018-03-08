Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966205AbeCHJuD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:50:03 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44758 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966137AbeCHJt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:49:59 -0500
X-Google-Smtp-Source: AG47ELsutozNleUH/phiwLznr6/peSqi0umXzdCdwUJIkRYPKME2xPU928Gn3ts17pVoD62WJ9m2iQ==
From: Jacob Chen <jacob-chen@iotwrt.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        sakari.ailus@linux.intel.com, hans.verkuil@cisco.com,
        tfiga@chromium.org, zhengsq@rock-chips.com,
        laurent.pinchart@ideasonboard.com, zyc@rock-chips.com,
        eddie.cai.linux@gmail.com, jeffy.chen@rock-chips.com,
        devicetree@vger.kernel.org, heiko@sntech.de,
        Jacob Chen <jacob2.chen@rock-chips.com>
Subject: [PATCH v6 17/17] MAINTAINERS: add entry for Rockchip ISP1 driver
Date: Thu,  8 Mar 2018 17:48:07 +0800
Message-Id: <20180308094807.9443-18-jacob-chen@iotwrt.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180308094807.9443-1-jacob-chen@iotwrt.com>
References: <20180308094807.9443-1-jacob-chen@iotwrt.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Chen <jacob2.chen@rock-chips.com>

Add MAINTAINERS entry for the rockchip isp1 driver.
This driver is maintained by rockchip officially and it
will be used for rockchip SoC on all linux-kernel based OS.

Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4623caf8d72d..7a9ff4fa4592 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11852,6 +11852,16 @@ F:	drivers/hid/hid-roccat*
 F:	include/linux/hid-roccat*
 F:	Documentation/ABI/*/sysfs-driver-hid-roccat*
 
+ROCKCHIP ISP V1 DRIVER
+M:	Jacob chen <jacob2.chen@rock-chips.com>
+M:	Shunqian Zheng <zhengsq@rock-chips.com>
+M:	Yichong Zhong <zyc@rock-chips.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	drivers/media/platform/rockchip/isp1/
+F:	Documentation/devicetree/bindings/media/rockchip-isp1.txt
+F:	Documentation/devicetree/bindings/media/rockchip-mipi-dphy.txt
+
 ROCKCHIP RASTER 2D GRAPHIC ACCELERATION UNIT DRIVER
 M:	Jacob chen <jacob2.chen@rock-chips.com>
 L:	linux-media@vger.kernel.org
-- 
2.16.1
