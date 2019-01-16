Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF5EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE11C205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Tc6nVXXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405136AbfAPQGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:06:30 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45416 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbfAPQGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Tk1f7fFIOHhlUxI/DgzUnABxxilbTd/RX6CjkTa2KVA=;
        b=Tc6nVXXcXJwNTtt9esqj8UpDh8/2y8s58Bi3iUoCu5Bh3KB7e0WyRX83bthZqfZJmZdiriFEeeO8Rn0hU6276da3VBhk1yREa+UnjbroiujOV9yUmZ3XkaU3oxvL00bf5CSlKvZ0gwyoiCul1Eyfz7XOhCmup6EguLfHXvgdWlc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gjnhz-0008Av-Sw; Wed, 16 Jan 2019 17:06:27 +0100
Date:   Wed, 16 Jan 2019 17:06:27 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: Add helpers to determine if PHY
 driver is generic
Message-ID: <20190116160627.GE29244@lunn.ch>
References: <20190115230936.28890-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115230936.28890-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 03:09:35PM -0800, Florian Fainelli wrote:
> We are already checking in phy_detach() that the PHY driver is of
> generic kind (1G or 10G) and we are going to make use of that in the SFP
> layer as well for 1000BaseT SFP modules, so expose helper functions to
> return that information.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
