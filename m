Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C43C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616C220652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616C220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeJBUEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:04:13 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:45389 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbeJBUEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:04:13 -0400
X-IronPort-AV: E=Sophos;i="5.54,332,1534834800"; 
   d="scan'208";a="18815636"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 02 Oct 2018 06:20:52 -0700
Received: from localhost.localdomain.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Tue, 2 Oct 2018 06:20:52 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 0/4] ARM: dts: at91: even nand memory partitions
Date:   Tue, 2 Oct 2018 16:20:34 +0300
Message-ID: <20181002132038.27189-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sam9x5cm, sama5d2_ptc_ek, sama5d3_xplained and sama5d4_xplained nand
flashes have a common memory map. Even the nand memory partitions to
match our NAND flash map available at:

http://www.at91.com/linux4sam/pub/Linux4SAM/SambaSubsections//demo_nandflash_map_lnx4sam5x.png

Tudor Ambarus (4):
  ARM: dts: at91: sama5d2_ptc_ek: fix bootloader env offsets
  ARM: dts: at91: at91sam9x5cm: even nand memory partitions
  ARM: dts: at91: sama5d3_xplained: even nand memory partitions
  ARM: dts: at91: sama5d4_xplained: even nand memory partitions

 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts   |  8 ++++----
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 11 ++++++++---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 11 ++++++++---
 arch/arm/boot/dts/at91sam9x5cm.dtsi         | 16 +++++++++++++---
 4 files changed, 33 insertions(+), 13 deletions(-)

-- 
2.9.4

