Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B06ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612F720877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612F720877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbeGQIaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:30:03 -0400
Received: from regular1.263xmail.com ([211.150.99.132]:47640 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbeGQIaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:30:02 -0400
Received: from cl?rock-chips.com (unknown [192.168.167.42])
        by regular1.263xmail.com (Postfix) with ESMTP id 7FBBD93D8;
        Tue, 17 Jul 2018 15:51:43 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id D25583D0;
        Tue, 17 Jul 2018 15:51:36 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: cl@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: cl@rock-chips.com
X-UNIQUE-TAG: <62fc3a7e09781474e035f65e9798558e>
X-ATTACHMENT-NUM: 0
X-SENDER: cl@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 16092LWKAF1;
        Tue, 17 Jul 2018 15:51:43 +0800 (CST)
From:   <cl@rock-chips.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        klaus.goger@theobroma-systems.com, cl@rock-chips.com,
        jagan@amarulasolutions.com, djw@t-chip.com.cn,
        jacob-chen@iotwrt.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        frank.wang@rock-chips.com, lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        yamada.masahiro@socionext.com, arnd@arndb.de,
        zhangqing@rock-chips.com, shawn.lin@rock-chips.com,
        kever.yang@rock-chips.com, david.wu@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com,
        sugar.zhang@rock-chips.com, huibin.hong@rock-chips.com,
        william.wu@rock-chips.com, sandy.huang@rock-chips.com
Subject: [PATCH v1 0/7] arm64: dts: rockchip: add basic dts file for PX30 SoCs
Date:   Tue, 17 Jul 2018 15:49:00 +0800
Message-Id: <1531813747-8804-1-git-send-email-cl@rock-chips.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

Liang Chen (7):
  Documentation: usb: dwc2: add description for px30
  Documentation: rockchip-dw-mshc: add description for px30
  Documentation: spi-rockchip: add description for px30
  Documentation: rockchip-i2s: add description for px30
  Documentation: rockchip: grf: add grf and pmugrf description for px30
  arm64: dts: rockchip: add core dtsi file for PX30 SoCs
  arm64: dts: rockchip: add PX30 eavluation board devicetree

 Documentation/devicetree/bindings/arm/rockchip.txt |    4 +
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |    1 +
 .../devicetree/bindings/soc/rockchip/grf.txt       |    2 +
 .../devicetree/bindings/sound/rockchip-i2s.txt     |    1 +
 .../devicetree/bindings/spi/spi-rockchip.txt       |    1 +
 Documentation/devicetree/bindings/usb/dwc2.txt     |    1 +
 arch/arm64/boot/dts/rockchip/Makefile              |    1 +
 arch/arm64/boot/dts/rockchip/px30-evb.dts          |  539 ++++++
 arch/arm64/boot/dts/rockchip/px30.dtsi             | 2044 ++++++++++++++++++++
 9 files changed, 2594 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30.dtsi

-- 
1.9.1


