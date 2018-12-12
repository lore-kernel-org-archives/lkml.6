Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1810CC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FEB20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8FEB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeLLMnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:43:32 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34892 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbeLLMnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:43:32 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1BDAB2037D; Wed, 12 Dec 2018 13:43:30 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id E8D932037D;
        Wed, 12 Dec 2018 13:43:29 +0100 (CET)
Date:   Wed, 12 Dec 2018 13:43:30 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: SoC for 4.21
Message-ID: <20181212124330.GA27581@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Not much this cycle, simply adding new SoC/SP ids to the SoC detection
code.

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.21-soc

for you to fetch changes up to 446e8986a2417148aed14f362831bf2425d434cb:

  ARM: at91: add support in soc driver for new SAM9X60 (2018-12-12 11:55:20 +0100)

----------------------------------------------------------------
AT91 SoC for 4.21:

 - Add new SoC IDs

----------------------------------------------------------------
Nicolas Ferre (1):
      ARM: at91: add support in soc driver for LPDDR2 SiP

Sandeep Sheriker Mallikarjun (1):
      ARM: at91: add support in soc driver for new SAM9X60

 drivers/soc/atmel/soc.c | 10 ++++++++++
 drivers/soc/atmel/soc.h |  7 +++++++
 2 files changed, 17 insertions(+)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
