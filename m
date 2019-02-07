Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ECAC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BE621907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfBGNzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:55:24 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:39719 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfBGNzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:55:23 -0500
Received: from bootlin.com (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 024EC100017;
        Thu,  7 Feb 2019 13:55:18 +0000 (UTC)
Date:   Thu, 7 Feb 2019 14:55:17 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next v2 01/10] net: phy: Update PHY linkmodes after
 config_init
Message-ID: <20190207145517.08bb8975@bootlin.com>
In-Reply-To: <20190207134807.GD23970@lunn.ch>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
        <20190207094939.27369-2-maxime.chevallier@bootlin.com>
        <20190207134807.GD23970@lunn.ch>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Thu, 7 Feb 2019 14:48:07 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

>On Thu, Feb 07, 2019 at 10:49:30AM +0100, Maxime Chevallier wrote:
>> We want to be able to update a PHY's supported list in the config_init
>> callback, so move the Pause parameters settings from phydrv->features
>> after calling config_init to make sure these  parameters aren't
>> overwritten.  
>
>Hi Maxime
>
>I have a patch which makes some core changes to support PHY doing
>runtime feature detection. I would prefer to use them, than this.
>
>Either I or Heiner will post them soon.

Sure, no problem, thanks for doing this. I'll be happy to review and
test that on my side.

As I said, I lack the big picture view on that part so my approach was
pretty naive, I'm glad you can take care of this :)

Thanks,

Maxime
