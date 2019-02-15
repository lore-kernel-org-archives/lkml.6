Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1F0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF1521925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bfD9ar+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbfBONYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:24:34 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:53631 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729262AbfBONYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vEWEfyi+qciWUPwtr4PbulPVWchEEKsUrWhVZNxdp6Y=; b=bfD9ar+r0fwX3s2DGzXMFQ1o0Y
        V00Ue/GnhTIs3iAjQuUJozweLEXrcBAbr/Kam4r0pnL4Piu308uv51qkNx/bAUnOdCL/HSLDkYcSn
        be0XULdNqumS84qm3Fee4oJvD2Lx3xQNjn6pzv0oIzncS6oer9VU8aHYUpvf4KJj4p8o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gudTg-0004v8-Ja; Fri, 15 Feb 2019 14:24:28 +0100
Date:   Fri, 15 Feb 2019 14:24:28 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com
Subject: Re: [PATCH net-next] net: phy: marvell10g: Don't explicitly set
 Pause and Asym_Pause
Message-ID: <20190215132428.GG5699@lunn.ch>
References: <20190215083347.5886-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215083347.5886-1-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 09:33:47AM +0100, Maxime Chevallier wrote:
> The PHY core expects PHY drivers not to set Pause and Asym_Pause bits,
> unless the driver only wants to specify one of them due to HW
> limitation. In the case of the Marvell10g driver, we don't need to set
> them.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Suggested-by: Andrew Lunn <andrew@lunn.ch>

Thanks Maxime

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
