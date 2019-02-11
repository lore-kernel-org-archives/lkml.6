Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427BFC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D59A20811
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBKHqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:46:48 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:46395 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKHqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:46:48 -0500
X-Originating-IP: 90.88.22.177
Received: from bootlin.com (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D066620003;
        Mon, 11 Feb 2019 07:46:43 +0000 (UTC)
Date:   Mon, 11 Feb 2019 08:46:43 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next v2 00/10] net: phy: Add support for 2.5GBASET
 PHYs
Message-ID: <20190211084643.0d4766d6@bootlin.com>
In-Reply-To: <81c340ea-54b0-1abf-94af-b8dc4ee83e3a@gmail.com>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
        <81c340ea-54b0-1abf-94af-b8dc4ee83e3a@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiner,

>Hi Maxime,
>
>Andrew and me are working on Aquantia PHY support and he handed over
>to me a patch series which includes parts of the first version of your
>series. Having said that I'm especially interested in your patches
>5 and 6. Because your series is somewhat bigger and there are a few
>review comments, preparing the next round may take time.
>
>I'd propose that you extract generic patches being submission-ready
>and split the patch series into two. I think the following patches
>would be candidates for the first series: 2, 3, 5, 6
>(provided they have no dependency on the other patches)
>Based on that both of us can go on with our work.

Sure, I'll sent that shortly. Thanks for the help,

Maxime
