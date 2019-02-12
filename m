Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF2BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12B52190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfBLT2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:28:42 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:46537 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfBLT2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:28:41 -0500
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id EDE311C0007;
        Tue, 12 Feb 2019 19:28:38 +0000 (UTC)
Date:   Tue, 12 Feb 2019 20:28:38 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: DT for 5.1
Message-ID: <20190212192838.GA12677@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Here is the only AT91 pull request for this cycle.

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-5.1-dt

for you to fetch changes up to 31f031f73a01fb83fd6f4abfff04a79b360219e1:

  ARM: dts: at91: replace gpio-key,wakeup with wakeup-source property (2019-01-08 19:12:40 +0100)

----------------------------------------------------------------
AT91 DT for 5.1

 - Enable QSPI NOR on sama5d2 SoM1
 - replace deprecated gpio-key,wakeup property

----------------------------------------------------------------
Claudiu Beznea (2):
      ARM: dts: at91: at91-sama5d27_som1: add QSPI1 + SPI NOR memory nodes
      ARM: dts: at91: at91-sama5d27_som1_ek: enable qspi1 memory

Sudeep Holla (1):
      ARM: dts: at91: replace gpio-key,wakeup with wakeup-source property

 arch/arm/boot/dts/at91-nattis-2-natte-2.dts |  2 +-
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi   | 30 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts |  4 ++++
 arch/arm/boot/dts/at91-wb45n.dts            |  2 +-
 arch/arm/boot/dts/at91-wb50n.dts            |  4 ++--
 5 files changed, 38 insertions(+), 4 deletions(-)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
