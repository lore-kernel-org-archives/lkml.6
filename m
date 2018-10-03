Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F53C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93412213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93412213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeJCUeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:34:24 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:22470 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJCUeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:34:24 -0400
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="18890102"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Oct 2018 06:45:55 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch04.mchp-main.com
 (10.10.76.105) with Microsoft SMTP Server id 14.3.352.0; Wed, 3 Oct 2018
 06:45:54 -0700
Date:   Wed, 3 Oct 2018 15:45:53 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <arnd@arndb.de>, <olof@lixom.net>, <arm@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <Nicolas.Ferre@Microchip.com>
Subject: [GIT PULL] ARM: at91: DT for 4.20 #2
Message-ID: <20181003134553.aqbogomrxqmpgpmo@M43218.corp.atmel.com>
Mail-Followup-To: arnd@arndb.de, olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com,
        Nicolas Ferre <Nicolas.Ferre@Microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Here are the second round of DT changes for 4.20. It consists in NAND
description fixes (size and partitions).

Regards

Ludovic

The following changes since commit 97181516b0785dd032700ae4899842389c6bea78:

  arm: dts: sama5d2: Update coresight bindings for hardware ports (2018-09-19 19:12:25 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.20-dt2

for you to fetch changes up to 767466b63de3368376323958b7777b9319bfa8d8:

  ARM: dts: at91: sama5d4_xplained: even nand memory partitions (2018-10-03 10:26:57 +0200)

----------------------------------------------------------------
AT91 DT for 4.20 #2

 - fixes NAND size and partitions for some boards

----------------------------------------------------------------
Tudor Ambarus (6):
      ARM: dts: at91: sama5d4_xplained: fix addressable nand flash size
      ARM: dts: at91: at91sam9x5cm: fix addressable nand flash size
      ARM: dts: at91: sama5d2_ptc_ek: fix bootloader env offsets
      ARM: dts: at91: at91sam9x5cm: even nand memory partitions
      ARM: dts: at91: sama5d3_xplained: even nand memory partitions
      ARM: dts: at91: sama5d4_xplained: even nand memory partitions

 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts   |  8 ++++----
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 11 ++++++++---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 13 +++++++++----
 arch/arm/boot/dts/at91sam9x5cm.dtsi         | 18 ++++++++++++++----
 4 files changed, 35 insertions(+), 15 deletions(-)

