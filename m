Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01A4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B406620841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B406620841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbeGaQTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:19:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40799 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730230AbeGaQTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:19:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3658C20799; Tue, 31 Jul 2018 16:38:56 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 11E1020731;
        Tue, 31 Jul 2018 16:38:56 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, Paul Burton <paul.burton@mips.com>
Cc:     James Hogan <jhogan@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v4 0/3] Add support for MSCC Ocelot SPI
Date:   Tue, 31 Jul 2018 16:38:52 +0200
Message-Id: <20180731143855.7131-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series only contains the DT documentation and the corresponding DT addition
since it has been rebased on spi-next.

Alexandre Belloni (3):
  spi: dw: document Microsemi integration
  mips: dts: mscc: Add spi on Ocelot
  mips: dts: mscc: enable spi and NOR flash support on ocelot PCB123

 .../devicetree/bindings/spi/snps,dw-apb-ssi.txt       |  6 ++++--
 arch/mips/boot/dts/mscc/ocelot.dtsi                   | 11 +++++++++++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts             | 10 ++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.18.0

