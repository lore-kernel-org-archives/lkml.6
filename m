Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4860C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D73520861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="JX3zqu1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfAWKjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:39:23 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:51366 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbfAWKjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:39:21 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id A9BF225BE34;
        Wed, 23 Jan 2019 21:39:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1548239958; bh=7jrAaIQiY8DIIXJjIYDERg1SohpHVc1BLgKhR6yw+Nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JX3zqu1VXtTU6+0u03clHUGlX5BCrOcW31VcL6gWNU3nwxJjfwoizmCMK4PzB+5b3
         T1R7ISHbg/C01Xo8IElvMNmsWelIBJsDQH5OBNKYzkqIcmSUi6kIvnYw1rKBmeOLYd
         tpJ9gr7b6UY9gOFAZaDmPEzPc6mkB0WmdQ1y70bQ=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 8CCCB940471; Wed, 23 Jan 2019 11:39:16 +0100 (CET)
Date:   Wed, 23 Jan 2019 11:39:16 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the renesas tree
Message-ID: <20190123103914.u7nlz624j5dmy7yr@verge.net.au>
References: <20190123075605.116ddbd0@canb.auug.org.au>
 <TY1PR01MB1770C404E14E88CB912D12D4C0990@TY1PR01MB1770.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1770C404E14E88CB912D12D4C0990@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC linux-renesas-soc]

On Wed, Jan 23, 2019 at 08:55:21AM +0000, Fabrizio Castro wrote:
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Sent: 22 January 2019 20:56
> > To: Simon Horman <horms@verge.net.au>
> > Subject: linux-next: Fixes tag needs some work in the renesas tree
> >
> > Hi all,
> >
> > In commit
> >
> >   8d6e2bbaeceb ("arm64: dts: renesas: r8a774a1: Fix hsusb reg size")
> >
> > Fixes tag
> >
> >   Fixes: ed898d4fc19d ("arm64: dts: renesas: r8a774a1: Add USB-DMAC and
> >
> > has these problem(s):
> >
> >   - Subject has leading but no trailing parentheses
> >   - Subject has leading but no trailing quotes
> >
> > Please don't split Fixes tags across 2 lines.
>
> Hello Stephen,
> 
> I am sorry for the trouble. My editor is configured to automatically wrap lines when they are too long, I'll be more careful next time.
> Do you need me to do anything about this patch?

Hi Fabrizio,

I should have noticed this myself. I'll fix up the fixes tag
in my next push. I don't think any action is needed by you
at this time.
