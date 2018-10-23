Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA892C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AB120652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="a5tbrl2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AB120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeJWRl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:41:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43902 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeJWRl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U705E0+xUa/nZ5KaHQgUff62hUgvpDcI8nNTrrYCFZE=; b=a5tbrl2VKFgdnXOhAQTKfyTF6
        bAFj2aP640EoSFHDfGtkp2M2buhyFIhGngkXEO+SvqNhLj7yqhYbeWhWgI2cW1ddw1hoxKBqvx8sW
        N/2LqTwr5AkEQT09S35gAOZU8TD78zaBRVcrEDdYz+uEADWr9ECX0+0e63mCLKg/fqm/w=;
Received: from [185.7.230.215] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gEsqN-0007Nz-VB; Tue, 23 Oct 2018 09:19:20 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7B3EC440078; Tue, 23 Oct 2018 11:19:19 +0200 (CEST)
Date:   Tue, 23 Oct 2018 10:19:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Git pull ack emails..
Message-ID: <20181023091919.GG2103@sirena.org.uk>
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nqkreNcslJAfgyzk"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
X-Cookie: Piece of cake!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nqkreNcslJAfgyzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 23, 2018 at 09:41:32AM +0100, Linus Torvalds wrote:

> In contrast, this email is written "after the fact", just scripting
> "who did I pull for and then push out" by just looking at the git
> tree. Which sucks, because it means that I don't actually answer the
> original email at all, and thus lose any cc's for other people or
> mailing lists.  That would literally be done better by simple
> automation.

> So I've got a few options:

>  - just don't do it

>  - acking the pull request before it's validated and finalized.

>  - starting the reply when doing the pull, leaving the email open in a
> separate window, going on to the next pull request, and then when
> build tests are done and I'll start the next one, finish off the old
> pending email.

> and obviously that first option is the easiest one. I'm not sure what
> Greg did, and during the later rc's it probably doesn't matter,
> because there likely simply aren't any overlapping operations.

I have a script that sends people rather lengthy "applied" e-mails when
I push things out with a lot of process blurb that new contributors
might need.  It tries to use patchwork to get the message ID and CC
list, though it will just fall back to scraping from git.  In my case
it's mainly there to help new contributors know what's going on but a
lot of other people have said they find them useful.

> So I'm mainly pinging people I've already pulled to see how much
> people actually _care_. Yes, the ack is nice, but do people care
> enough that I should try to make that workflow change? Traditionally,
> you can see that I've pulled from just seeing the end result when it
> actually hits the public tree (which is yet another step removed from
> the steps above - I do build tests between every pull, but I generally
> tend to push out the end result in batches, usually a couple of times
> a day).

It doesn't urgently bother me personally, honestly I was a bit alarmed
the first time Greg sent me an ack - your usual workflow is that if
there's any mail it means that there's a problem.  So long as it's
consistent.

--nqkreNcslJAfgyzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvO55YACgkQJNaLcl1U
h9DQHgf/RfeHWJKGoGzi5WcMGXUn2sQBRTHrfHTVFYVjxcmXHYWjxitoA6ryl2gd
/A8Z2ygFgmiFdwu6zqP7xJToTIaR7+rbj+tBxG+opYSNbBIUFFyKEy3hWmyV+tf5
rzJQXLL55armI/YoJn9YaEGinw+MaysZjVWsJvV4dYO749do7L+HQcbFiSpnmGD1
7N0L8Rs+7abiH2BB98y3QTR1D1fdMg55jxUO5v9+M702knLsovtNOtyZHKwdsayf
KG5to//bAurOProfvWpiedbIFY9OV/PvlQsTugLNmS2GCiYup05Nd+IlKIVbDAdB
M2lnEkjPd/qZ+L4x0yJkzHODxJChDA==
=/CFB
-----END PGP SIGNATURE-----

--nqkreNcslJAfgyzk--
