Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A999DC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6856A20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FT6kTS2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6856A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbeLIVLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:11:46 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:39902 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeLIVLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=om4lC/RlnqSFvOZuMTGFufl6v9UzPXoDo5FJ+xTtWIE=;
        b=FT6kTS2DGrNSsRLlsLa+qhIilflhbCot6fJkLHUe7IDwW2/FEjHoqjYnegWpODn4DYPxKvibvW0+fAc//8QFo1dKC6x5+wYSeWEKYntCfnB/XMKkJ4KRrPwj+1T4bNEoQ1WHW3xn4/cv3Khp+2rcaMrnwIa6Sz/iKVIO7A99344=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gW6MV-0005gd-7Q; Sun, 09 Dec 2018 22:11:39 +0100
Date:   Sun, 9 Dec 2018 22:11:39 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Miller <davem@davemloft.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the net-next
 tree
Message-ID: <20181209211139.GB21186@lunn.ch>
References: <20181210080045.0e67ad79@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210080045.0e67ad79@canb.auug.org.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 08:00:45AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   dc9d38cec71c ("net: phy: mdio-gpio: Add phy_ignore_ta_mask to platform data")
>   04fa26bab06d ("net: phy: mdio-gpio: Add platform_data support for phy_mask")
> 
> are missing a Signed-off-by from their author.

Hi David.

Any idea what happened here? The version in my git repo has SOB.

https://patchwork.ozlabs.org/patch/1009811/ also has my SOB.

     Thanks
	Andrew
