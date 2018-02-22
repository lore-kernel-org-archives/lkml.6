Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeBVFtP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 00:49:15 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:4375 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751577AbeBVFtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 00:49:07 -0500
X-UUID: c412029a3a334d2a8c2d84dbe6bcd152-20180222
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>
CC: James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v1 0/5] update Mediatek MT2712 clock and scpsys support 
Date: Thu, 22 Feb 2018 13:48:45 +0800
Message-ID: <20180222054851.26096-1-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.12.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on v4.16-rc1 and composed of scpsys control (PATCH 1-2) and clock control (PATCH 3-5).
Basically, all changes are for the ECO design change of MT2712.

Weiyi Lu (5):
  dt-bindings: soc: update MT2712 power dt-bindings
  soc: mediatek: update power domain data of MT2712
  dt-bindings: clock: add clocks for MT2712
  arm64: dts: add clock device nodes of MT2712
  clk: mediatek: update clock driver of MT2712

 arch/arm64/boot/dts/mediatek/mt2712e.dtsi |  28 +++
 drivers/clk/mediatek/clk-mt2712.c         |  69 +++++--
 drivers/soc/mediatek/mtk-scpsys.c         |  42 ++++-
 include/dt-bindings/clock/mt2712-clk.h    | 294 +++++++++++++++---------------
 include/dt-bindings/power/mt2712-power.h  |   3 +
 5 files changed, 277 insertions(+), 159 deletions(-)
