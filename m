Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F9FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610E820868
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610E820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbeH2S3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:29:04 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:6449 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbeH2S3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:29:04 -0400
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="18915829"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Aug 2018 07:31:51 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Wed, 29 Aug 2018 07:31:50 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <miquel.raynal@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Boris BREZILLON <boris.brezillon@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 00/11] MAINTAINERS: update of of some Microchip entries
Date:   Wed, 29 Aug 2018 16:31:36 +0200
Message-ID: <cover.1535552609.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an update of most of Microchip MAINTAINERS' entries. I took advantage
of the addition of Ludovic as co-maintainer to go through some of the entries
that were outdated.

There are moves of entries in the 3 last patches of this series. You can drop
them if they introduce too much headaches while updating this MAINTAINERS
file.

Series based on v4.19-rc1.

Nicolas Ferre (11):
  MAINTAINERS: ARM: at91: add co-maintainer for ARM/Microchip
  MAINTAINERS: update entry for Microchip NAND driver support
  MAINTAINERS: media: change Microchip ISI, ISC maintainers
  MAINTAINERS: ASoC: change maintainer for Microchip ALSA drivers
  MAINTAINERS: USB: change maintainer for Microchip USBA gadget driver
  MAINTAINERS: dmaengine: add files to Microchip dma entry
  MAINTAINERS: pwm: add entry for Microchip pwm driver
  MAINTAINERS: iio: add co-maintainer to SAMA5D2-compatible ADC driver
  MAINTAINERS: remove the / ATMEL string from MICROCHIP entries
  MAINTAINERS: move former ATMEL entries to proper MICROCHIP location
  MAINTAINERS: sdhci: move the Microchip entry to proper location

 MAINTAINERS | 196 ++++++++++++++++++++++++++++------------------------
 1 file changed, 105 insertions(+), 91 deletions(-)

-- 
2.17.1

