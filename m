Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F64C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236ED2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236ED2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJIWnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:43:03 -0400
Received: from mout.perfora.net ([74.208.4.196]:47723 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJIWnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:43:03 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MLhDB-1gAjEZ22XD-000tzE; Tue, 09 Oct 2018 17:25:29 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MLhDB-1gAjEZ22XD-000tzE; Tue, 09 Oct 2018 17:25:28 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel@ziswiler.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v1 0/8] ARM: dts: tegra: last minute fixes
Date:   Tue,  9 Oct 2018 17:25:15 +0200
Message-Id: <20181009152523.3771-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:4RfaGsk4PxzXq4pU5ioM3/7/I4EhjbdYw06On61QqoRFicJ4GLp
 dMwnw+1yRqVfRmxiBaT4UJYV2xJ8IarzRJ+2qVN+5dUEsCvGrfMf9AdFn1pcJbC47INNdmv
 ouZEvs2qbVlfK5Allz1j5sTk4Rd59qM48AyQs9W7SXGy6VDm9+R4sVlxgRIIPoqpOS9doAP
 WbfIC2jzuvKBWHmDXgt3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KgS1Wfry0lE=:Wn5o+5geSuqpdVO58cWfIR
 W4RaqzwCXYQMBzH0H6h2O0Z9OOi5w1rCagyzzzYNcgn9cFDZcoHoz+tfPIeZS0ApHamYmWqwG
 JdK9p4WuUL6Fq0hHv7eDYvFZtTzZE+41OrW1G1MnPs62MXwxb76jyhLs4IRd3XxYFDZAqk5va
 YfjIb4cXE2n+NbNGwqn2XPL7Hdud7YWDPK822M/lJFiTI4mE2CL8b6Uoy7rqrwP3sEI/AELDZ
 kde97PaXBRX18HzHtEWap48R//Z9CwhwUpRia0S9wHG7Z7pqwue9LoBRM5t45u+fz5Pc/iuGb
 3zibA4Wte3U5gCTU1Z26nOLZczbZ8AOBeCtYtRXErw/fwLcey1nNp0yrqoyZc4BnX8A3g8RJZ
 DjYjEClEdmYnaqlwWlxS1Oqmyv8i6MGBG3GH4BTuDvmUk1cs3K0Rt8OvBt05AZVlCGzMh4hPj
 nisr8ilidEcWRdzSJsvwpCsyyA/X4bi68P5cYcQTRD+TF7a/FjY1diReTfjdFzR7a+O9Wy5rg
 EwWRMdI/7aRM/alM+eVSdJWahnzXULVoRgVB77rkEk9te2socsnp8FHrGjfwm9zmiZ/Kn2PnA
 SZT0rJriMLK/9yfYuHlCzuiYJH5Y5lc8b5S06Pyt8YHnUVehHHYf7oGAR7RawVpPB71pJyx3W
 DT59N9yyh3Dxud9kkZLBaFTISWdcwWPgcYBjOQ25KKeHJh0U2N4MgHJiyhso/qD/B+Yw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series comes with some last minutes fixes and further clean-up.

Marcel Ziswiler (8):
  ARM: tegra: fix simple-panel compatibles
  ARM: tegra: apalis-tk1/colibri_t20/t30: eval/iris: fix regulator gpio
    enable
  ARM: tegra: apalis/colibri_t30: fix hdmi regulator
  ARM: tegra: colibri_t20: reorder pmic properties
  ARM: tegra: apalis-tk1: further regulator clean-up
  ARM: tegra: apalis_t30/tk1: annotate power I2C being on-module
  ARM: tegra: colibri_t30: further regulator clean-up
  ARM: tegra: apalis_t30: further regulator clean-up

 arch/arm/boot/dts/tegra114-dalmore.dts          |  3 +-
 arch/arm/boot/dts/tegra124-apalis-eval.dts      |  4 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts |  4 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi     | 17 +++--
 arch/arm/boot/dts/tegra124-apalis.dtsi          | 17 +++--
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
 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi      | 88 ++++++++++++-------------
 arch/arm/boot/dts/tegra30-apalis.dtsi           | 86 ++++++++++++------------
 arch/arm/boot/dts/tegra30-cardhu.dtsi           |  2 +-
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts   |  4 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi          | 61 +++++++++--------
 21 files changed, 159 insertions(+), 157 deletions(-)

-- 
2.14.4

