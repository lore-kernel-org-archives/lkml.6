Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50582C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148FB20843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148FB20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeIARR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:17:26 -0400
Received: from mout.perfora.net ([74.208.4.196]:38447 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbeIARR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:26 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MZmmm-1gC5ll3l2k-00LZQ0; Sat, 01 Sep 2018 15:05:16 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel@ziswiler.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 00/19] ARM: dts: tegra: apalis-tk1: minor revamp
Date:   Sat,  1 Sep 2018 15:04:45 +0200
Message-Id: <20180901130504.14318-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:snuHS803cmD4tUDlC4Q9PrBvwI98tchN7FxW3uduJiNkWY6CXlh
 5ocmSGRMdxXYiORDfBJdKpqoSzU729H4krjzr8WoyXCGVtip8PzAtM+ZpjIcdxsd9Owh3GK
 X1uZ+eCd4W490Gjq8XojcjjyBVxQMdQg1AUYtezMKMZhUrOVku5S0YgJ8s2ExubQT+VkzqX
 Sqy06DMDyndms83veORyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TyWxVSmF37k=:gbQgMm62Y0JNHUSPSinyWz
 j93jUKmoZ8QBGPs5RXaAbpsowFQ2ZMdR/wEHkpAlvJ3fdbldN/R/GE/rXinjnDe+nBVKv9w6D
 YW9dJCekbkWVBalix/l2ILCs1vDejqAjZejo41zLZAHezke0MvAcK1+ZfCHNGjFo8mK1tjxJT
 8tfygVSfX4T4x4NxIK1CnVAda7du40HhYf4GxrftpfXfPO8BnXdYJjLDowzA8FzBdFQkVvfhe
 0wxPFp7vK/ANbqrI+H68R1+xLq3knvC1fT+eluCLhKQ4uyYX4JeRrPNJu6t9y1mmHrFxDyNUM
 kz96nYXw/JWHVGYVgdVWa0AqB2gq0DruLYBkDvrPcf7xeXy7eq6JPMezzZ9Tt5IMPISAb/T5e
 u0MI4KQXSzsLcMPLx/P7g7SJq+v+R1B4nYiKv2/+KJ8qtpBKbmVQK9CKcUecfP3h4J0blqKAf
 CmUlhfYEK/+9D4rzAWESthTkD3wgszUf1Nr+N8gXuCn9H+J6iYjWPytliZEMNyj2dREhGEg7A
 CL/Io5ZO0fu11BXq17idjfNVcTZC+x9wAKq2AMBhc7R7ImmcQlFYlrkxE6CPYP1//XFmRJhZJ
 aTrYAo2mxeCOHtWCtcFwfX/cay/h5Jr/kgc/sKgrylkdw5bKoXNn9/9tLhR2qqnvYsuBLlJEt
 Aa5MJh2U9uvA8YJ0sVRwl15fZYwxGG372MNIzqiwOhLJNHf5s8ob39t/EMq/wTT4cX+I=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a minor overhaul for the Toradex Apalis TK1 system on
module.

Changes in v2:
- Add Rob's reviewed-by.
- New patch as suggested by Rob.
- New patch.
- Get rid of fake clocks simple bus as suggested by Rob.
- Change cover-letter subject to indicate minor revamp.
- Drop "[PATCH 02/15] ARM: tegra: apalis-tk1: reorder pcie properties"
  as requested by Stefan.
- Drop "[PATCH 13/15] ARM: tegra: apalis-tk1: fix pcie switch vendor
  compatible" in favour of the new "[PATCH v2 26/34] dt-bindings: add
  broadcom (formerly plx technology) vendor prefix" posted earlier as
  part of the apalis_t30 revamp v2 as suggested by Stefan.

Marcel Ziswiler (19):
  ARM: tegra: apalis-tk1: add local-mac-address property
  ARM: tegra: apalis-tk1: reorder host1x/hdmi properties
  ARM: tegra: apalis-tk1: reorder padctl properties
  ARM: tegra: apalis-tk1: regulator clean-up
  ARM: tegra: apalis-tk1: add missing regulators
  ARM: tegra: apalis-tk1: drop unused pinmux label
  ARM: tegra: apalis-tk1: white-space clean-up
  ARM: tegra: apalis-tk1: reorder backlight properties
  ARM: tegra: apalis-tk1: add proper emmc vmmc and vqmmc supplies
  ARM: tegra: apalis-tk1: enable emmc ddr52 mode
  ARM: tegra: apalis-tk1: add toradex,apalis-tk1-v1.2 compatible
  ARM: tegra: apalis-tk1: reorder cpu dfll clock properties
  ARM: tegra: apalis-tk1: reorder SD card properties
  ARM: tegra: apalis-tk1: drop module level model and compatible
  ARM: tegra: apalis-tk1: drop obsolete spidev nodes
  ARM: tegra: apalis-tk1: replace underscores in node names with dashes
  ARM: tegra: apalis-tk1: get rid of fake clocks simple bus
  ARM: tegra: apalis-tk1: shorten temperature-sensor node
  ARM: tegra: apalis-tk1: drop unused hdmi_ddc label

 Documentation/devicetree/bindings/arm/tegra.txt |   2 +
 arch/arm/boot/dts/tegra124-apalis-eval.dts      |  40 ++-
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts |  43 ++-
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi     | 452 ++++++++++++------------
 arch/arm/boot/dts/tegra124-apalis.dtsi          | 451 +++++++++++------------
 5 files changed, 508 insertions(+), 480 deletions(-)

-- 
2.14.4

