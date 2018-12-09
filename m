Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CC1C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DEB20874
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JnwfXhZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DEB20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbeLIVtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:49:12 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:40321 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeLIVtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=B6Uqkv7tkNjaPq/K0FL2QZYDmLv/KCK0qM71dEwPcIA=;
        b=JnwfXhZ9RiG6qhPZHFpb1pTRJP9FYedOe5Xwu3+srabZSBWbogHIuKLtrwxk0S+1GRoe4htziarCKLtdj6JAj0ElYEWY/hhnsYcG2qND9+4F0VXq1EvgiL6KNLEIAXLIa2gGh4bPxMGMz+ExHF/9jc21eDIWGy+wQo7KCNEI/00=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gW6wl-0005tU-6v; Sun, 09 Dec 2018 22:49:07 +0100
Date:   Sun, 9 Dec 2018 22:49:07 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the net-next
 tree
Message-ID: <20181209214907.GC21186@lunn.ch>
References: <20181210080045.0e67ad79@canb.auug.org.au>
 <20181209211139.GB21186@lunn.ch>
 <011f5be3-4bc1-2e64-0ddf-b43b8dbc4dcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011f5be3-4bc1-2e64-0ddf-b43b8dbc4dcd@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 10:33:10PM +0100, Heiner Kallweit wrote:
> On 09.12.2018 22:11, Andrew Lunn wrote:
> > On Mon, Dec 10, 2018 at 08:00:45AM +1100, Stephen Rothwell wrote:
> >> Hi all,
> >>
> >> Commits
> >>
> >>   dc9d38cec71c ("net: phy: mdio-gpio: Add phy_ignore_ta_mask to platform data")
> >>   04fa26bab06d ("net: phy: mdio-gpio: Add platform_data support for phy_mask")
> >>
> >> are missing a Signed-off-by from their author.
> > 
> > Hi David.
> > 
> > Any idea what happened here? The version in my git repo has SOB.
> > 
> > https://patchwork.ozlabs.org/patch/1009811/ also has my SOB.
> > 
> Instead of
> v2
> --
> int -> u32 in platform data structure
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> shouldn't it be
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v2
> - int -> u32 in platform data structure

Hi Heiner

David said he wanted to see the version history. So i deliberately put
it above the ---.

I'm just wondering if -- was enough to trigger something in David's
scripts? Or patchwork. The -- has disappeared in the commit which made
it into net-next.

   Andrew
