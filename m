Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1004FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C787420867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C787420867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbeIYRAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:00:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38736 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbeIYRAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:00:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E637920725; Tue, 25 Sep 2018 12:53:43 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id BBE1A203DA;
        Tue, 25 Sep 2018 12:53:43 +0200 (CEST)
Date:   Tue, 25 Sep 2018 12:53:44 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: defconfig for 4.20
Message-ID: <20180925105344.GA32532@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof

The addition of the generic ADC touchscreen driver can probably benefit
other architectures. Also add the sama5 I2S driver.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.20-defconfig

for you to fetch changes up to 4eb2534057b1b01014a2b2bb6898d9934d2ba831:

  ARM: multi_v7_defconfig: add Atmel I2S driver (2018-08-30 22:19:32 +0200)

----------------------------------------------------------------
AT91 defconfig for 4.20

 - addition of sama5 I2S
 - addition of generic ADC resistive touchscreen

----------------------------------------------------------------
Codrin Ciubotariu (2):
      ARM: configs: at91: Add I2S driver to sama5
      ARM: multi_v7_defconfig: add Atmel I2S driver

Eugen Hristev (2):
      ARM: configs: at91: add generic resistive touchscreen to sama5
      ARM: multi_v7_defconfig: add generic resistive touchscreen

 arch/arm/configs/multi_v7_defconfig | 2 ++
 arch/arm/configs/sama5_defconfig    | 2 ++
 2 files changed, 4 insertions(+)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
