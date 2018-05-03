Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeECNir (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:38:47 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:9146 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbeECNio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:38:44 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Mark Brown <broonie@kernel.org>
CC: Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Sunny Luo <sunny.luo@amlogic.com>, <linux-spi@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] spi: meson-axg: add few enhanced features
Date: Thu, 3 May 2018 21:36:41 +0000
Message-ID: <20180503213645.20694-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Add a few enhanced features for the SPICC controller of Meson-AXG SoC.

  These patches are actually quite independent from each other, I send them
together in case to avoid the file conflicts.

Sunny Luo (3):
  spi: meson-axg: support MAX 80M clock
  spi: meson-axg: enhance output enable feature
  spi: meson-axg: add a linear clock divider support

 drivers/spi/spi-meson-spicc.c | 270 ++++++++++++++++++++++++++++------
 1 file changed, 222 insertions(+), 48 deletions(-)

-- 
2.17.0
