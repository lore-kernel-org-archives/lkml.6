Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbeDDTAp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 15:00:45 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:18745 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbeDDTAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 15:00:36 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0pA1dWeZVY=
X-RZG-CLASS-ID: mo00
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: galak@codeaurora.org, andy.shevchenko@gmail.com,
        Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 0/5] none
Date: Wed,  4 Apr 2018 21:00:19 +0200
Message-Id: <cover.1522868422.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2:
* added PCA_PCAL flags if matched through of-table
* fix address calculation for extended PCAL6524 registers
* hack to map LEVEL_LOW to EDGE_FALLING to be able to
  test in combination with ts3a227e driver
* improve description of bindings for optional vcc-supply
  and interrupt-controller;

2018-03-10 09:32:53: no initial description

H. Nikolaus Schaller (5):
  gpio: pca953x: set the PCA_PCAL flag also when matching by DT
  gpio: pca953x: add register definitions for pcal6524 and fix address
    calculation
  [RFC] gpio: pca953x: hack to map LEVEL irqs to EDGE irqs (may loose
    interrupts/hang)
  DTS: Bindings: pca953x driver provides an optional vcc-supply property
  DTS: Bindings: pca953x: add example how to use interrupt-controller
    and gpio-controller

 .../devicetree/bindings/gpio/gpio-pca953x.txt      | 34 +++++++++++++++++++++
 drivers/gpio/gpio-pca953x.c                        | 35 ++++++++++++++++++----
 2 files changed, 64 insertions(+), 5 deletions(-)

-- 
2.12.2
