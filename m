Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755145AbeDCKHc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:07:32 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:59052 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754298AbeDCKH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:07:29 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Yixun Lan <yixun.lan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Jerome Brunet <jbrunet@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, Rob Herring <robh@kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 0/3] mmc: meson-axg: initial support for AXG SoC platform
Date: Tue, 3 Apr 2018 18:06:48 +0800
Message-ID: <20180403100652.41056-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

   The patches series try to enable basic eMMC support in the Meson-AXG platfrom.

   Currently HS200 mode is tested with clock running at 166MHz, since
not all boards are stable to running 200MHz (due to tuning phase error),
we will further improve the tuning phase driver in the future,
but in my opiton, this patch series itself is pretty good to go.

Nan Li (3):
  mmc: dt-bindings: update bindings doc to support Meson-AXG SoC
  mmc: meson-axg: add support for the Meson-AXG platform
  mmc: meson: update doc to support Meson-AXG platform

 .../devicetree/bindings/mmc/amlogic,meson-gx.txt   |  1 +
 drivers/mmc/host/Kconfig                           |  4 +-
 drivers/mmc/host/meson-gx-mmc.c                    | 63 ++++++++++++++++++----
 3 files changed, 55 insertions(+), 13 deletions(-)

-- 
2.16.2
