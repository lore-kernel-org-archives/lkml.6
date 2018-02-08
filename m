Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeBHPVQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:21:16 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47460 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeBHPUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:20:49 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Brian Norris <briannorris@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        Chris Zhong <zyw@rock-chips.com>, William wu <wulf@rock-chips.com>,
        hl@rock-chips.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 2/3] Documentation: bindings: add usb3-host-disable and usb3-host-port for Rockchip USB Type-C PHY
Date: Thu,  8 Feb 2018 16:20:27 +0100
Message-Id: <20180208152028.9997-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180208152028.9997-1-enric.balletbo@collabora.com>
References: <20180208152028.9997-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William wu <wulf@rock-chips.com>

rockchip,usb3-host-disable is the register of type-c phy disable usb3 host
rockchip,usb3-host-port is the register of type-c phy usb3 port number

Signed-off-by: William wu <wulf@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
index c3be83be9615..9085d95d0079 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
@@ -36,6 +36,12 @@ offset, enable bit, write mask bit.
  - rockchip,uphy-dp-sel : the register of type-c phy enable DP function
    for type-c phy0, it must be <0x6268 19 19>;
    for type-c phy1, it must be <0x6268 3 19>;
+ - rockchip,usb3-host-disable : the register of type-c phy disable usb3 host
+   for type-c phy0, it must be <0x2434 0 16>;
+   for type-c phy1, it must be <0x2444 0 16>;
+ - rockchip,usb3-host-port : the register of type-c phy usb3 port number
+   for type-c phy0, it must be <0x2434 12 28>;
+   for type-c phy1, it must be <0x2444 12 28>;
 
 Required nodes : a sub-node is required for each port the phy provides.
 		 The sub-node name is used to identify dp or usb3 port,
-- 
2.15.1
