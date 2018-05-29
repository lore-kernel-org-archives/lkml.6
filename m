Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbeE2ExX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 00:53:23 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35577 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbeE2ExT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 00:53:19 -0400
X-Google-Smtp-Source: AB8JxZqX4LTXQ8SjE/j+phDbAoe+3TxQcDl/aqUilLeiiX2qRNMdle0YmvmA0FRisTkC1EQlv3kX/Q==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: matthias.bgg@gmail.com, robh+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, taiten.peng@linaro.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] Add Mediatek X20 Development Board support
Date: Tue, 29 May 2018 10:22:56 +0530
Message-Id: <20180529045258.1415-1-manivannan.sadhasivam@linaro.org>
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

Manivannan Sadhasivam (2):
  dt-bindings: Add vendor prefix for ArcherMind
  arm64: dts: Add Mediatek X20 Development Board support

 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../boot/dts/mediatek/mt6797-x20-dev.dts      | 33 +++++++++++++++++++
 3 files changed, 35 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts

-- 
2.17.0
