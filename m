Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC0AC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9842820881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9842820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeJPSid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:38:33 -0400
Received: from mout.perfora.net ([74.208.4.194]:46185 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbeJPSic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:38:32 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LzZcy-1fZARo4BBy-014h58; Tue, 16 Oct 2018 12:47:43 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LzZcy-1fZARo4BBy-014h58; Tue, 16 Oct 2018 12:47:43 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 0/9] ARM: dts: tegra: last minute fixes
Date:   Tue, 16 Oct 2018 12:47:21 +0200
Message-Id: <20181016104730.4598-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:7ZkmbOIVWsPqZTIAFVKMzudKwPgztL7VdiKiNRey1jsVUQI1KAS
 Y6DyHtxWHQBh/RM2ETQOB5gec21q22TXtuZ9X9ZsrMd6bD22eXjz8fLmw9EY1ZLoWg8NMZd
 LPQKV+xSN2xu3jiRlT22uruGVAVujPYxPbQBSm+YOJ/ocBbMa1H8UYXYKjbVwhs5iB4SIP3
 bf6ZEvhZADUywoQdwa0zg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1Fch+V8Z9Ig=:YWQONB9DgYRCFDoMGfLuyq
 Uvpq9aXabNonnSPT8JR5Oikrgp5gnDL+ydmNRusUVR4PwbpY3kvq+JcdFSc47D7s6fLqKG9hw
 2NzBsFcJMsfGQlp+QiX9PJwFctLUowxEKZ1H8Hg43xTUMHzOk9mqC/F2ML/ZikKhrpBBj3OPf
 sExXdtVXixsm8Qq4AxRpaZPHVeOC6ABA3SXs0R8m+DnrHrHLV90KGCtoK7Jn4hJ5EvevBYYH1
 Aa+Xrxk3BvCV+Md4A1TNo+mCsg2EG8JTWBnmKxLOxIDYm2/hBdNRe7k6Db7vwSsxUET/ULEFw
 2Cczoaa1RESLr1vVdVklIG7G3wJjrAzPkq5bkcwPl4SwMlNh2dyvBEnplIHt/YcYVi/GHwU3R
 QtxKFt9DrVAqQlfgNdelCQOPssDETEv7APw0TC/S5a7vdDyHUvTHR7/dP73K2+zr4zr9safPA
 jBRSe0VEZ0JY7vRBRJTgYZi8AimZatZo2CYoLw+zzZdVrxqj9b//XXAx4cQAvmXczwez+ig08
 ktnN6lgIHueDjmR/WU5kZvIE/b6DqVXCN04NzS8kkMY+X4zxS/ZHKwGGk2vSLlg6f2jFxzN34
 kZ6uJLgF/tjWPW72dg9uq7gJvrUfnW3thtncQpDEiaeh/n8Uuezm0wl3vZojMyVaLtDJMDT7m
 We2JsLgqtg1pP8JiVRbCwdCGGRwT+OnNzIbeen6+JqZhlHl4RUkN6IuLgyJZSEW7ZyG8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series comes with some last minutes fixes and further clean-up.

Changes in v2:
- Dropped "[PATCH v1 3/8] ARM: tegra: apalis/colibri_t30: fix hdmi
  regulator" as suggested by Russell et. al.
- Added 2 new patches improving/fixing audio on Apalis TK1.

Changes in v1:
- Remove simple-panel compatible as suggested by Rob.

Marcel Ziswiler (9):
  ARM: tegra: fix simple-panel compatibles
  ARM: tegra: apalis-tk1/colibri_t20/t30: eval/iris: fix regulator gpio
    enable
  ARM: tegra: colibri_t20: reorder pmic properties
  ARM: tegra: apalis-tk1: further regulator clean-up
  ARM: tegra: apalis_t30/tk1: annotate power I2C being on-module
  ARM: tegra: colibri_t30: further regulator clean-up
  ARM: tegra: apalis_t30: further regulator clean-up
  ASoC: tegra_sgtl5000: fix device_node refcounting
  ASoC: tegra_sgtl5000: fix platform name vs. of_node assignement

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
 sound/soc/tegra/tegra_sgtl5000.c                | 22 +++++++-
 22 files changed, 143 insertions(+), 147 deletions(-)

-- 
2.14.4

