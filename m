Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeDRNqu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:46:50 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:41312 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752714AbeDRNqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:46:48 -0400
X-Google-Smtp-Source: AIpwx4929/YjE0nhzcoZn96Ojro5Vw0n6+KEJY3UTWvPADBn+bPE1i+rmCTHgj0NlY/M5MVPJYfZIw==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, bjorn.andersson@linaro.org,
        will.deacon@arm.com
Cc: amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        todor.tomov@linaro.org, dragonboard@lists.96boards.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/1] Add gpio-line-names property for Dragonboard820c
Date: Wed, 18 Apr 2018 19:16:00 +0530
Message-Id: <20180418134601.8502-1-manivannan.sadhasivam@linaro.org>
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

Changes in v2:

* Added schematic names in comments for lines with 96Boards spec names

Manivannan Sadhasivam (1):
  dts: qcom: db820c: Add gpio-line-names property

 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 239 +++++++++++++++++++++++++++
 1 file changed, 239 insertions(+)

-- 
2.14.1
