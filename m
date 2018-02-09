Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbeBIHAE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 02:00:04 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:31779 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeBIHAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 02:00:02 -0500
From: Yixun Lan <yixun.lan@amlogic.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh@kernel.org>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] clk: meson-axg: Add AO Cloclk and Reset driver
Date: Fri, 9 Feb 2018 15:00:24 +0800
Message-ID: <20180209070026.193879-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This patch try to add AO clock and Reset driver in Amlogic's
Meson-AXG SoC.

  Please note this patchset actually depend on the clock regmap
conversion series [1].

[1] clk: meson: use regmap in clock controllers
 https://lkml.kernel.org/r/20180131180945.18025-1-jbrunet@baylibre.com


Yixun Lan (2):
  dt-bindings: clock: reset: Add AXG AO Clock and Reset Bindings
  clk: meson-axg: Add AO Clock and Reset controller driver

 drivers/clk/meson/Makefile             |   2 +-
 drivers/clk/meson/axg-aoclk.c          | 236 +++++++++++++++++++++++++++++++++
 drivers/clk/meson/axg-aoclk.h          |  25 ++++
 include/dt-bindings/clock/axg-aoclkc.h |  26 ++++
 include/dt-bindings/reset/axg-aoclkc.h |  20 +++
 5 files changed, 308 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/meson/axg-aoclk.c
 create mode 100644 drivers/clk/meson/axg-aoclk.h
 create mode 100644 include/dt-bindings/clock/axg-aoclkc.h
 create mode 100644 include/dt-bindings/reset/axg-aoclkc.h

-- 
2.15.1
