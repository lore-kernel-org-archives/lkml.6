Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF294C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835E920656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="dii0z4mi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfAOICn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 03:02:43 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:45776 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfAOICn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 03:02:43 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id ADCFD25B812;
        Tue, 15 Jan 2019 19:02:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1547539361; bh=omrUf4oVMq6RvP84L7n93zm+6YpMNICRn9h38Wq3OSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dii0z4miFoI/muIU7+7ZKTy5yq82yn0fXpyT+1aA3HX3Vu9sY41w8Om3nBFfsDchD
         NuprwlBGP8Sb93KJ8mv5fe9WOiMjsCpxzFflGRHy/DWuo5FEGBld6TVzb/qcPvrMU7
         7/P5Nyq0sTDJm714iLdFRuD3KK9AO9okZbQy/Gp8=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 12EB59402FD; Tue, 15 Jan 2019 09:02:38 +0100 (CET)
Date:   Tue, 15 Jan 2019 09:02:38 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: serial: Convert snps,dw-apb-uart to
 json-schema
Message-ID: <20190115080233.dllow4e4vsdp3k63@verge.net.au>
References: <20190110222017.6390-1-robh@kernel.org>
 <20190114093022.hjouckoss2zemefg@verge.net.au>
 <CAL_JsqJd_kHi+XU7_oe0upg1iJT2rjjEup3YpyrDQA-OhkgKTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJd_kHi+XU7_oe0upg1iJT2rjjEup3YpyrDQA-OhkgKTw@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 10:23:15AM -0600, Rob Herring wrote:
> On Mon, Jan 14, 2019 at 3:30 AM Simon Horman <horms@verge.net.au> wrote:
> >
> > On Thu, Jan 10, 2019 at 04:20:16PM -0600, Rob Herring wrote:
> > > Convert the snps,dw-apb-uart binding to DT schema using json-schema.
> > >
> > > The Rockchip and Broadcom compatible strings were not documented,
> > > so add them here.
> >
> > I believe the documentation of the Renesas compatible strings is also new
> > in this file. Perhaps it would be worth mentioning that too.
> 
> Ah, that should be in patch 2. Will respin.

Thanks!

> 
> > In any case
> >
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> >
> 
