Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbeESRfO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 13:35:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33868 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbeESRfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 13:35:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16025602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From: Taniya Das <tdas@codeaurora.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        robh@kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 0/2] Add support for QCOM cpufreq FW driver
Date: Sat, 19 May 2018 23:04:49 +0530
Message-Id: <1526751291-17873-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 [v2]
   * Address comments given in v0 series.

 [v1]
    * Fixed compilation reported by Amit K.

The CPUfreq FW present in some QCOM chipsets offloads the steps necessary
for changing the frequency of CPUs. The driver implements the cpufreq
driver interface for this firmware.

Taniya Das (2):
  dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW bindings
  cpufreq: qcom-fw: Add support for QCOM cpufreq FW driver

 .../bindings/cpufreq/cpufreq-qcom-fw.txt           |  68 +++++
 drivers/cpufreq/Kconfig.arm                        |   9 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/qcom-cpufreq-fw.c                  | 317 +++++++++++++++++++++
 4 files changed, 395 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
 create mode 100644 drivers/cpufreq/qcom-cpufreq-fw.c

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
