Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeFDH4k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:56:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37082 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbeFDH4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:56:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B1E5604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From: Taniya Das <tdas@codeaurora.org>
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>, robh@kernel.org
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH 0/2] Add display clock controller driver for SDM845
Date: Mon,  4 Jun 2018 13:26:23 +0530
Message-Id: <1528098985-3676-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the display clock controller found on SDM845
based devices. This would allow display drivers to probe and
control their clocks.

Taniya Das (2):
  dt-bindings: clock: Introduce QCOM Display clock bindings
  clk: qcom: Add display clock controller driver for SDM845

 .../devicetree/bindings/clock/qcom,dispcc.txt      |  18 +
 drivers/clk/qcom/Kconfig                           |  10 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/dispcc-sdm845.c                   | 704 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,dispcc-sdm845.h     |  42 ++
 5 files changed, 775 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc.txt
 create mode 100644 drivers/clk/qcom/dispcc-sdm845.c
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sdm845.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
