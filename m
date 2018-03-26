Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeCZISf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:18:35 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:51335 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeCZISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:18:31 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
CC: Yixun Lan <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 0/3] clk: meson: drop unnecessary AO clock flags
Date: Mon, 26 Mar 2018 16:18:06 +0800
Message-ID: <20180326081809.49493-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This first two patches will drop unnecessary flags for
the AO clock driver.
  The third DTS patch is a follow-up fix for the second patch,
and I've tested them on P200, P212, Q200, S400 boards.

 Note: this patch series was made on top of patch [0]

[0] https://lkml.kernel.org/r/20180323143816.200573-1-yixun.lan@amlogic.com

Yixun Lan (3):
  clk: meson: drop CLK_SET_RATE_PARENT flag
  clk: meson: drop CLK_IGNORE_UNUSED flag
  ARM64: dts: meson: fix clock source of the pclk for UART_AO

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 4 ++--
 drivers/clk/meson/axg-aoclk.c               | 1 -
 drivers/clk/meson/gxbb-aoclk.c              | 1 -
 5 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.15.1
