Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759494AbeD1CVS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 22:21:18 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:34894 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759307AbeD1CVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 22:21:16 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>
CC: Yixun Lan <yixun.lan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/2] net: stmmac: dwmac-meson: 100M phy mode support for AXG SoC
Date: Sat, 28 Apr 2018 10:21:09 +0000
Message-ID: <20180428102111.18384-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the dwmac glue layer register changed, we need to 
introduce a new compatible name for the Meson-AXG SoC
to support for the RMII 100M ethernet PHY.

Change since v1 at [1]:
  - implement set_phy_mode() for each SoC

[1] https://lkml.kernel.org/r/20180426160508.29380-1-yixun.lan@amlogic.com

Yixun Lan (2):
  dt-bindings: net: meson-dwmac: new compatible name for AXG SoC
  net: stmmac: dwmac-meson: extend phy mode setting

 .../devicetree/bindings/net/meson-dwmac.txt   |   1 +
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 120 +++++++++++++++---
 2 files changed, 105 insertions(+), 16 deletions(-)

-- 
2.17.0
