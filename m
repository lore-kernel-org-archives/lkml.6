Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8034C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5E821A03
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5E821A03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbeHFN2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:28:30 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:24560 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbeHFN2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:28:30 -0400
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="18193905"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Aug 2018 04:19:54 -0700
Received: from rob-ult-m19940.microchip.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Mon, 6 Aug 2018 04:19:55 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Cristian.Birsan@microchip.com>
Subject: [PATCH v7 0/3] ARM: dts: at91: sama5d2: Add nodes for I2S
Date:   Mon, 6 Aug 2018 14:19:45 +0300
Message-ID: <20180806111948.4522-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are the remaining dts patches from the series:
[PATCH v5 0/5] ASoC: add driver for Atmel I2S controller

v6 -> v7
 - addressed some comments regarding pin conflicts;

v5 -> v6
 - removed unnecessary phandles to audio PLL clock from the I2S nodes;
 - using assigned clocks to set gclk as parent of i2smuxclk;

Codrin Ciubotariu (1):
  ARM: dts: at91: sama5d2: add I2S clock muxing nodes

Cyrille Pitchen (2):
  ARM: dts: at91: sama5d2: add nodes for I2S controllers
  ARM: dts: at91: sama5d2 Xplained: add pin muxing for I2S

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 30 +++++++++++
 arch/arm/boot/dts/sama5d2.dtsi              | 56 +++++++++++++++++++++
 2 files changed, 86 insertions(+)

-- 
2.17.1

