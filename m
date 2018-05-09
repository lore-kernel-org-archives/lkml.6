Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756560AbeEIOK2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:10:28 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:53735 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756434AbeEIOK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:10:26 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Yixun Lan <yixun.lan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Jerome Brunet <jbrunet@baylibre.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>, <linux-gpio@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] pinctrl: nand: meson: fix missing data pins
Date: Wed, 9 May 2018 22:08:25 +0000
Message-ID: <20180509220827.22286-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus
   We found the data pins of NAND controller are actually mising from
the nand pinctrl group in the GXBB, GXL SoC driver, these two patches
will fix these issue.
   I have prepared the two patches separated with different Fix tag,
but I can squash them into one patch if you prefer, since the meson nand
driver has never been pushed into mainline (so probably the Fix tag is
useless).
   Btw, the patches are formated on top your 'for-next' branch,
and I'm fine with this merged as for-next.

   Thanks

Yixun Lan (2):
  pinctrl: nand: meson-gxbb: fix missing data pins
  pinctrl: nand: meson-gxl: fix missing data pins

 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 4 ++--
 drivers/pinctrl/meson/pinctrl-meson-gxl.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.0
