Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753840AbeDKQl1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:41:27 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35956 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbeDKQlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:41:25 -0400
X-Google-Smtp-Source: AIpwx4/lMSwrfFHlP6vaZ8+zBEsXOpVFEXriKBg4FuxeW78O19eMpcYqqSmxUCV6QLloRPsKKdNHGg==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: afaerber@suse.de, robh+dt@kernel.org
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/4] Add Actions Semi S900 SPS support
Date: Wed, 11 Apr 2018 22:10:32 +0530
Message-Id: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPS (Smart Power System) support to Actions Semi S900 SoC.

Manivannan Sadhasivam (4):
  dt-bindings: power: Add Actions Semi S900 SPS
  arm64: dts: actions: Add S900 SPS node
  soc: actions: sps: Add S900 power domains
  soc: actions: Fix help text in Kconfig for OWL_PM_DOMAINS

 .../devicetree/bindings/power/actions,owl-sps.txt  |  2 +
 arch/arm64/boot/dts/actions/s900.dtsi              |  6 +++
 drivers/soc/actions/Kconfig                        |  2 +-
 drivers/soc/actions/owl-sps.c                      | 58 ++++++++++++++++++++++
 include/dt-bindings/power/owl-s900-powergate.h     | 23 +++++++++
 5 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/power/owl-s900-powergate.h

-- 
2.14.1
