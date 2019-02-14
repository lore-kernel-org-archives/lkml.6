Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E50CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3915222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404937AbfBNATP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:19:15 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46542 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbfBNATP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:19:15 -0500
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1FF1514BA2BEB;
        Wed, 13 Feb 2019 16:19:13 -0800 (PST)
Date:   Wed, 13 Feb 2019 16:19:12 -0800 (PST)
Message-Id: <20190213.161912.1056928506839061227.davem@davemloft.net>
To:     maxime.chevallier@bootlin.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next 0/4] net: phy: Add 2.5G/5GBASET PHYs support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190211142529.22885-1-maxime.chevallier@bootlin.com>
References: <20190211142529.22885-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 13 Feb 2019 16:19:14 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Mon, 11 Feb 2019 15:25:25 +0100

> The 802.3bz standard defines 2 modes based on the NBASET alliance work
> that allow to use 2.5Gbps and 5Gbps speeds on Cat 5e, 6 and 7 cables.
> 
> This series adds the necessary infrastructure to handle these modes with
> C45 PHYs. This series was originally part of a bigger one, that has
> seen 2 iterations [1] [2] that added support for these modes on Marvell
> Alaska PHYs.
> 
> Following some discussions with Heiner and Andrew [3], we decided to
> split-out the generic parts so that we can work together on the
> following steps to get these mode fully working with Aquantia and
> Marvell PHYS.
> 
> The first 3 patches are reworking some of the internal network phy
> infrastructure to handle the new modes in a more generic way.
> 
> The 4th patch adds all the C45 register definition and accesses that
> follows the 802.3bz standard to support 2.5GBASET and 5GBASET.
> 
> [1] : https://lore.kernel.org/netdev/20190118152352.26417-1-maxime.chevallier@bootlin.com/
> [2] : https://lore.kernel.org/netdev/20190207094939.27369-1-maxime.chevallier@bootlin.com/
> [3] : https://lore.kernel.org/netdev/81c340ea-54b0-1abf-94af-b8dc4ee83e3a@gmail.com/

Series applied, thanks Maxime.
