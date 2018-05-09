Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934491AbeEIKX2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 06:23:28 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33066 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934262AbeEIKXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 06:23:02 -0400
X-Google-Smtp-Source: AB8JxZo/dO+J7lrCZHEAaC3mJF5ZNAq/TdWAdOEz1H435Z7/n1QYFMPdsbI9Q29u9ig7rf9nD5vlOQ==
From: Lin Huang <hl@rock-chips.com>
To: seanpaul@chromium.org, airlied@linux.ie, zyw@rock-chips.com
Cc: dianders@chromium.org, briannorris@chromium.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        daniel.vetter@intel.com, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com,
        Lin Huang <hl@rock-chips.com>
Subject: [PATCH v2 3/4] Documentation: bindings: add phy_config for Rockchip USB Type-C PHY
Date: Wed,  9 May 2018 18:22:43 +0800
Message-Id: <1525861364-26323-3-git-send-email-hl@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525861364-26323-1-git-send-email-hl@rock-chips.com>
References: <1525861364-26323-1-git-send-email-hl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If want to do training outside DP Firmware, need phy voltage swing
and pre_emphasis value.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v2:
- rebase

 Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
index 960da7f..eda26dd 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
@@ -17,7 +17,9 @@ Required properties:
 
 Optional properties:
  - extcon : extcon specifier for the Power Delivery
-
+ - rockchip,phy_config : That's phy voltage swing and pre_emphasis
+			 setting, if want to do dp training outside
+			 dp firmware, need to add these value.
 Required nodes : a sub-node is required for each port the phy provides.
 		 The sub-node name is used to identify dp or usb3 port,
 		 and shall be the following entries:
-- 
2.7.4
