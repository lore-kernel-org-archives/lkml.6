Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeFEQfh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:35:37 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38289 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeFEQff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:35:35 -0400
X-Google-Smtp-Source: ADUXVKLZjyZYDQdWssnia7HjiMOFGhJMKGEbh9ZLJF8FSTlJl6EMWNvyJCkei4iAg+Il/fPFUa/ySA==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: matthias.bgg@gmail.com, robh+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, taiten.peng@linaro.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/2] Add Mediatek X20 Development Board support
Date: Tue,  5 Jun 2018 22:04:40 +0530
Message-Id: <20180605163442.4812-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for Mediatek X20 Development Board by Archermind.
This board is based on the Deca-Core MT6797 SoC from Mediatek and is
one of the 96Boards Consumer Edition platform.

With this devicetree change, board can boot into initramfs.

More information about this board can be found in 96Boards product page:
https://www.96boards.org/product/mediatek-x20/

Thanks,
Mani

Changes in v2:

* Added documentation for board compatible
* Dropped vendor documetation patch since it got applied

Manivannan Sadhasivam (2):
  dt-bindings: arm: mediatek: Document Mediatek X20 Development Board
  arm64: dts: Add Mediatek X20 Development Board support

 .../devicetree/bindings/arm/mediatek.txt      |  3 ++
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../boot/dts/mediatek/mt6797-x20-dev.dts      | 33 +++++++++++++++++++
 3 files changed, 37 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts

-- 
2.17.0
