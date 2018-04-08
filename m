Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeDHG75 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 02:59:57 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:44175 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbeDHG74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 02:59:56 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
CC: Yixun Lan <yixun.lan@amlogic.com>, Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, Rob Herring <robh@kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 0/3] irqchip: meson-gpio: add support for Meson-AXG SoCs
Date: Sun, 8 Apr 2018 14:56:57 +0000
Message-ID: <20180408145700.23520-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This series try to add GPIO interrupt controller support for Meson-AXG SoCs.
  The first patch is a trivial typo fix, I can fold the first two patches
together if necessary.

Yixun Lan (3):
  dt-bindings: interrupt-controller: fix the double quotes
  dt-bindings: interrupt-controller: New binding for Meson-AXG SoC
  irqchip/meson-gpio: add support for Meson-AXG SoCs

 .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt | 11 ++++++-----
 drivers/irqchip/irq-meson-gpio.c                              |  5 +++++
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.16.2
