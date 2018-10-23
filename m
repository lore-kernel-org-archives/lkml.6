Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94964C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7E62075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="w+SaUZwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7E62075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeJWSIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:08:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59792 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWSIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wRW24QkdR4j6itEf2rY50ah/tDYGkmMzgbnND2lDTkY=; b=w+SaUZwSMxv/c0zbOvG9zfeF0
        9ZAfUnjsu1P/Y9bFc6uYn6IBv+sGbC0W+56QAYUQcPUuWhL1yixM3OrYg6BIt0eKuapLyE6YSVmrB
        lCwvfZi4goyGe7ufYet1+8CJsv9K3gxG1mGGZhgQBGrR/YtEGSldmFB5WGpWAOuAXnmkc=;
Received: from [185.7.230.215] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gEtFn-0007Os-P2; Tue, 23 Oct 2018 09:45:35 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 3D2E1440078; Tue, 23 Oct 2018 11:45:35 +0200 (CEST)
Date:   Tue, 23 Oct 2018 10:45:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Git pull ack emails..
Message-ID: <20181023094535.GH2103@sirena.org.uk>
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
 <CACRpkdbi2gqqc271eMgHjD68bqf2mzw8zw+iAhYv2LFajfo-eQ@mail.gmail.com>
 <CAHk-=wiiC65aZFrDp69vdcSALLDZNPkTL1diadxNL54tBPeAzQ@mail.gmail.com>
 <20181023093521.dm3l5oen2j7etsot@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JI+G0+mN8WmwPnOn"
Content-Disposition: inline
In-Reply-To: <20181023093521.dm3l5oen2j7etsot@kshutemo-mobl1>
X-Cookie: Piece of cake!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JI+G0+mN8WmwPnOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 23, 2018 at 12:35:22PM +0300, Kirill A. Shutemov wrote:
> On Tue, Oct 23, 2018 at 10:10:47AM +0100, Linus Torvalds wrote:
> > So I feel that he automation model is just not good. The reply should
> > go to the actual pull request, not to the git history. People who want
> > just _that_ could already automate the git history thing without me
> > even doing anything at all, either scripting it themselves or by using
> > some filtering on the kernel commit mailing list..

> Can you tag merge commit with message-id of the pull request?
> Automation machinery can reply to the pull request with proper CC list
> obtained from the archive?

If you're doing that you could even just put all the info you'd get from
the e-mail like the CC list into the tag (or git note or whatever), no
need to bounce to a list archive.

--JI+G0+mN8WmwPnOn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvO7bsACgkQJNaLcl1U
h9CznQf9HVK9LURmS+mDLveJP3YsHJNUjGhuxtDX0dTjChyr0sqMsvv1bJMMGop1
R3DNhhLIYO8aUCM9EsPewSEFlCtah+MQOCnUrlTBVqxUggIpdWobev9F/3M3MKXo
M8EDoE8TmKnRCpoNdqf/PIYsHP4EtCdeiA4r8rU10ZV6X5k4UN0Rp/Oquc2Nx3Tl
pgwq7UrCe+FVWEVKi/QzXbcyaVMZVayLtR5jIRcq6qn6pmPaqIn/0QB4IztPilCq
v80ZzF0hxc0heKC9nC/HfOYwmj8XDmNioUtIR829ClLeXQIoJbypJ2lnedVqCL6M
IMY8mRPM6dDdvFzNPql83/foDbYiRA==
=SRWh
-----END PGP SIGNATURE-----

--JI+G0+mN8WmwPnOn--
