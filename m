Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B35EC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AB02087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AB02087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeJRTPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:15:01 -0400
Received: from mout.perfora.net ([74.208.4.197]:35177 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeJRTPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:15:01 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LfyXt-1fppru2pjP-00pgHF; Thu, 18 Oct 2018 13:14:18 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LfyXt-1fppru2pjP-00pgHF; Thu, 18 Oct 2018 13:14:18 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 0/7] ARM: dts: tegra: last minute fixes
Date:   Thu, 18 Oct 2018 13:14:04 +0200
Message-Id: <20181018111411.26623-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:PvD7EU+Up7K9KuIjjtPdZ16oyPoMfeo6ANUgLoHESMGz7F6z8zS
 6pCZnMK7qks5OE0QZr5D4XK8HPh8OUcbGjroKzbadq8Ql9D1EQR0/OqfMBsNP72ZiFVlU46
 xTOdL3qLtF7DzNrhpiw4b4XONjHuCa3mniw9YkqS5RYeRyapawcgHvcuG5KvVMUFwRkxOWP
 2fGPfQSnhTaPnPuo+d8DA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WwqGVH1D/bc=:xshE3ChDCyWmYD4rpC5W8F
 jyY0b2Uf+/EJVIYWKpD40mKz8I7uys6TtbKMi/gmh16ynl/0c0BM1Fqblk5dUVHn1+OE/AE/4
 0XflAfhWoRymVgkqgLUTBZanDo6LQ9b8bFavU+p+ZXRMPTPSCPo6gIUiSzs5pjct4Dz6ywSaJ
 K+oNTd3lXTxzqO+UaxF6iWRHCx6wRrn+GCeuDSHrWe/vtZ7vO+14JRBTxmf0K64WVFwfJBzXJ
 2iBeHm3glDBd/vSg5otIvZrXOLA0jeHyQIuS202OI5iMW2OW8jcH+cDuFyn01qnzRltvHOsKs
 A+adTsB9IGd/54MD7mQf5xSTsm7OT1n0CM++2fmDM/aLIEgLdjQA1anylWXfP/BySXgBf+Mef
 1ipaLaZVH+f7gqVsWxQMhP4ZN2loQ8IsuK2rKcfH/lOlmjVkTc8ooHtgEENTWjA1QBLhn0i3Z
 38fjgPomx1jULfs9Hb/Dg/+VPa++7Ca4ipxzDHofxNkS1bk9OZNeGcF81OZt/dpX7vIvbSNS1
 zIWpwCYtjvBsVlks+cT7M2U+LBAIefVOtCDX1341qqRRNl8kjr3KlTPV3TR394FdQVSdKMO9n
 1PvBAWOXC6QCuVN3bLEmd7GfrGsjwQ3x+Zd9FyDbYP8mwbED40LZrAX5akLbB/eCPij6QJa7l
 2xNieUE1QoGx5VFKDhVtd779c/qEk94xsZzsGjOHeOVQPLw54+kXrL+7rgW1XEunVIc0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series comes with some last minutes fixes and further clean-up.

Changes in v3:
- Dropped ASoC patches in favour of sending them as a separate series.

Changes in v2:
- Dropped "[PATCH v1 3/8] ARM: tegra: apalis/colibri_t30: fix hdmi
  regulator" as suggested by Russell et. al.
- Added 2 new patches improving/fixing audio on Apalis TK1.

Changes in v1:
- Remove simple-panel compatible as suggested by Rob.

Marcel Ziswiler (7):
  ARM: tegra: fix simple-panel compatibles
  ARM: tegra: apalis-tk1/colibri_t20/t30: eval/iris: fix regulator gpio
    enable
  ARM: tegra: colibri_t20: reorder pmic properties
  ARM: tegra: apalis-tk1: further regulator clean-up
  ARM: tegra: apalis_t30/tk1: annotate power I2C being on-module
  ARM: tegra: colibri_t30: further regulator clean-up
  ARM: tegra: apalis_t30: further regulator clean-up

 arch/arm/boot/dts/tegra114-dalmore.dts          |  3 +-
 arch/arm/boot/dts/tegra124-apalis-eval.dts      |  4 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts |  4 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi     | 17 +++---
 arch/arm/boot/dts/tegra124-apalis.dtsi          | 17 +++---
 arch/arm/boot/dts/tegra124-venice2.dts          |  2 +-
 arch/arm/boot/dts/tegra20-colibri-eval-v3.dts   |  4 +-
 arch/arm/boot/dts/tegra20-colibri-iris.dts      |  4 +-
 arch/arm/boot/dts/tegra20-colibri.dtsi          |  4 +-
 arch/arm/boot/dts/tegra20-harmony.dts           |  2 +-
 arch/arm/boot/dts/tegra20-medcom-wide.dts       |  2 +-
 arch/arm/boot/dts/tegra20-paz00.dts             |  2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts          |  2 +-
 arch/arm/boot/dts/tegra20-ventana.dts           |  2 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts       |  2 +-
 arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts  |  4 +-
 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi      | 72 +++++++++++--------------
 arch/arm/boot/dts/tegra30-apalis.dtsi           | 70 ++++++++++--------------
 arch/arm/boot/dts/tegra30-cardhu.dtsi           |  2 +-
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts   |  4 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi          | 45 ++++++++--------
 21 files changed, 123 insertions(+), 145 deletions(-)

-- 
2.14.4

