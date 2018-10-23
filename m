Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B696EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822F720671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ofzH+bgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822F720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbeJWRX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:23:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41926 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbeJWRX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ai2lof6YJITadEvAfImw4261w8Eo+D5omeBfQ/SZSbA=; b=ofzH+bgFnftTMMpPvOWeV975E
        o99wx8JVRhpOCPMLKcOeDzf88+U8Wy5m+FmvmFM8nuLFk6/B2sPk1oQ/u3++3u4Ja4qea50MGFUNI
        OtRqS4IFSeXT1QPqabcEG5TCFA8vDnw3tac9zSpWJQmg9AjvVGUEFt6ExdvunxElsaq2M=;
Received: from [185.7.230.215] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gEsYw-0007NS-EY; Tue, 23 Oct 2018 09:01:18 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B6937440078; Tue, 23 Oct 2018 11:01:17 +0200 (CEST)
Date:   Tue, 23 Oct 2018 10:01:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Joe Perches <joe@perches.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] [GIT PULL] code of conduct fixes for 4.19-rc8
Message-ID: <20181023090117.GF2103@sirena.org.uk>
References: <1540066514.3464.22.camel@HansenPartnership.com>
 <20181022211025.GA8911@kroah.com>
 <23e41205115d317908c63d37a20ee316b44a8404.camel@perches.com>
 <20181023070750.GB3068@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HCdXmnRlPgeNBad2"
Content-Disposition: inline
In-Reply-To: <20181023070750.GB3068@localhost>
X-Cookie: Piece of cake!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HCdXmnRlPgeNBad2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 23, 2018 at 08:07:50AM +0100, Josh Triplett wrote:
> On Mon, Oct 22, 2018 at 09:16:20PM -0700, Joe Perches wrote:

> > As James Bottomley has suggested multiple times,
> > I'd much rather kernel development use the debian
> > code of conduct verbatim than even this modified one.

> > https://www.debian.org/code_of_conduct

> The Debian code of conduct doesn't do nearly as good a job of addressing
> issues. (Debian also adopted that code of conduct back when such codes
> weren't nearly as well understood or established.) Many people *in*
> Debian, including supporters of their current CoC, have an interest in
> improving it further and/or adopting a more well-established one.

It was recent enough that a lot of the complaints people might have
these days actually got levelled at Debian at the time it was
introduced, and those divergences were for the most part the result of
deliberate decisions.  A big part of this was based on the knowledge
that there's a particular tendency to rules lawyering in parts of the
Debian community, both generally and specifically with the sorts of
behavioural stuff that codes of conduct are designed to address (there's
been examples of people trying to push the limits there before, it's not
just a theoretical concern).  It's definitely an old code of conduct and
could be improved but that's not the only thing going on there.

--HCdXmnRlPgeNBad2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvO41wACgkQJNaLcl1U
h9CfEQf/W7QHvYHc49aUTNLdmE1k9E2PTkAUSbdOBpuIbEmhpGIEOdm9XwrD6ZLH
qRfs9GDZQ5hsuQaQSIB+kNoKSzDoPlYNsyD47Z2MMQOEz7snZL7+Dt+NTwLBnN4o
M60iy9m0H+NHPV+AvinfHxdR5LsmkVzE5k2onAzmr+UR6QCSLZQI0S/rssZIvXKn
o58dHMZ2oG9RNN985CimoqExGXK+GH/E8ctMM63W+aUWwFxjnDfcUkGg7PSLPB0J
wCMoMTJ+GU68HHnhhSPilkwOiQbjShnVtyi7DO1DteD7LGs8DwF25hIR3g+vKzDO
EWC/mAtYQyl6BxPzOdaCtNAT9CeacA==
=8nCx
-----END PGP SIGNATURE-----

--HCdXmnRlPgeNBad2--
