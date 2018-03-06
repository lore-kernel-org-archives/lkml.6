Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753734AbeCFNFP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 08:05:15 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38097 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753487AbeCFNFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 08:05:12 -0500
X-Google-Smtp-Source: AG47ELsPEX/cqRF22xcofL2+ZiNyJoBMkZqEAmP88p7ixRIgogClSu3v+l1mXl2oNbVHH5BfIDuhMQ==
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-arm-msm@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>, Andy Gross <andy.gross@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Timur Tabi <timur@codeaurora.org>, Wei Xu <xuwei5@hisilicon.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [PATCH 0/3] Enable thermal management on MSM8916
Date: Tue,  6 Mar 2018 18:35:00 +0530
Message-Id: <cover.1520340931.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT entries to create cooling devices on MSM8916, enable the thermal
sensor on the platform and turn on other cpufreq governors to make it easy
for developers.

This patchset requires
http://patchwork.kernel.org/bundle/amitkucheria/8016-cpufreq-dts/ to be
applied first to enable thermal functionality by cpu frequency throttling.

Amit Kucheria (2):
  arm64: defconfig: enable thermal sensor on QCOM platforms
  arm64: defconfig: enable more cpufreq governors

Rajendra Nayak (1):
  arm64: dts: msm8916: Add cpu cooling maps

 arch/arm64/boot/dts/qcom/msm8916.dtsi | 31 +++++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig          | 10 ++++++++++
 2 files changed, 41 insertions(+)

-- 
2.7.4
