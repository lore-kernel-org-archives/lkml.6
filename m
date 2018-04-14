Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbeDNDT0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 23:19:26 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:36670 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbeDNDTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 23:19:24 -0400
X-Google-Smtp-Source: AIpwx4+N9kkjmNOFBNZPBqv00FODwkhNaDeWMQVKfZhtvMHftdMdDJ92NcgcabSuWj//SMr+OTOWug==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, bjorn.andersson@linaro.org,
        will.deacon@arm.com
Cc: amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        dragonboard@lists.96boards.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/1] Add gpio-line-names property for Dragonboard820c
Date: Sat, 14 Apr 2018 08:48:10 +0530
Message-Id: <20180414031811.11351-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio-line-names property for 96Boards Dragonboard820c development
board based on APQ8096 SoC. The lines are named after the 96Boards
CE Specification 1.0, Appendix "Expansion Connector Signal Description".
There are 4 gpio-controllers present on this board, including the
APQ8096 SoC, PM8994 (GPIO, MPP) and PMI8994 (GPIO).

Considering the regular 96Boards Consumer Edition boards, this board belongs
to Entended edition form factor, hence includes additional Primary,
Secondary High Speed Connectors and one Camera Connector.

Line names for PMI8994 MPP pins are not added due to the absence of the
gpio-controller support.

Manivannan Sadhasivam (1):
  dts: qcom: db820c: Add gpio-line-names property

 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 240 +++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)

-- 
2.14.1
