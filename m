Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBB7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E74820850
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i/A/2j1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E74820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbeGQPxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:53:46 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:36907 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729620AbeGQPxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=ZN+ZUADlaMX/bul7u0bAHnyEXRZOfxWn2mRC3ROXORQ=;
        b=i/A/2j1ayD/QQ3ZhCnclZXNLdESEltPz77oYO6pna2QOt7nYRWC/ZT58vGV81CoLymXUeaqsPwtVQ8CbCrui1ahrp9xo1ujjquAKxsTShOLh80qJ0Plb7UwhPGi0ckB8J39THOgAFWfZCXBoyleyleppXjGVH+f4Dgk71R/ChtE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ffRmF-000508-E6; Tue, 17 Jul 2018 17:20:35 +0200
Date:   Tue, 17 Jul 2018 17:20:35 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Healy <cphealy@gmail.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: vf610: Add ZII SSMB SPU3 board
Message-ID: <20180717152035.GD16320@lunn.ch>
References: <20180717040651.641-1-andrew.smirnov@gmail.com>
 <20180717144638.GB16320@lunn.ch>
 <CAFXsbZpKyLjp0bO7MVR5StKf=3UkXUANydhM+8_13G3itRmE+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFXsbZpKyLjp0bO7MVR5StKf=3UkXUANydhM+8_13G3itRmE+Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
> >> @@ -0,0 +1,343 @@
> >> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >> +
> >> +/*
> >> + * Device tree file for ZII's SSMB SPU3 board
> >> + *
> >> + * SSMB - SPU3 Switch Management Board
> >> + * SPU - Seat Power Unit
> >
> > I think this is the first Zodiac board with mutually recursive
> > acronyms.
> >
> > Probably a question for Chris: Does SSMB specifically refer to version
> > 3 of the SPU?
> >
> >    Andrew
> 
> SPU3 is the third generation of seat power unit.
> SSMB is the SPU3 Switch Management Board.
> 
> So, SSMB is a backronym.  This naming scheme breaks down a bit though
> when follow on designs (that are not the SPU3) also use the SSMB, but
> that's what it is... ;-)

O.K, i was just wondering if the 3 was in the wrong place. More
logically, it would be

* SSMB - SPU Switch Management Board
* SPU 3 - Seat Power Unit, version 3.

But you are saying the Marketing guys messed up the naming and
engineering is now stuck with it.

	    Andrew
