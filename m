Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DA8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDC720880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfBUKbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:31:52 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:52253 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfBUKbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:31:51 -0500
X-Originating-IP: 90.88.23.190
Received: from bootlin.com (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 6BE81FF81F;
        Thu, 21 Feb 2019 10:31:47 +0000 (UTC)
Date:   Thu, 21 Feb 2019 11:31:46 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 1/7] net: phy: marvell10g: Use get_features to
 get the PHY abilities
Message-ID: <20190221113146.119e67d4@bootlin.com>
In-Reply-To: <20190221102215.jg7bsxfdjkqrf6xn@shell.armlinux.org.uk>
References: <20190221095128.28188-1-maxime.chevallier@bootlin.com>
        <20190221095128.28188-2-maxime.chevallier@bootlin.com>
        <20190221102215.jg7bsxfdjkqrf6xn@shell.armlinux.org.uk>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russell,

On Thu, 21 Feb 2019 10:22:15 +0000
Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:

>> +	return 0;
>> +}
>> +
>> +static int mv3310_get_features(struct phy_device *phydev)
>> +{
>> +	int ret, val;  
>
>Please try to keep the formatting/style consistent in the file you are
>editing.  A blank line here would do that.  Thanks.

Sorry, I missed that (and so did checkpatch apparently). I'll send a V2.

Thanks,

Maxime
