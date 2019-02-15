Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BC4C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AC521920
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550231883;
	bh=I6CUj+CpgOTpt0dF/M9b/Fav5qFjWomdDsmc9o2FpIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Go9WcaSofncw7mCB5ddrprTxYJNkyEpRd2vr1yAWpp78WHKma83VjGk3aXq1lECBv
	 5vbBh1LrvXVBAQGXbjHc7y9AyTLbEiZk7ubxwu7xJmIkUYWpvSMPAR5M9Imdv1DP3Q
	 STTdfFg40FoIt5r7Ec+kH4obYgym9TttMM2Fy/Tc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393819AbfBOL6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:58:01 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34444 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733182AbfBOL6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I6CUj+CpgOTpt0dF/M9b/Fav5qFjWomdDsmc9o2FpIo=; b=t25LEwe+F9DmahhBOEUb1VvXO
        +ymctvpBXMqzKNzGqVIXYLEUtZvaYRsJbjYaLFpY7NqGFk6Fu70HKJ94uzXwoSasdnX6aOc2jSQAj
        ov9Fl0cHbzgGQEjqAhXM+51D3pAEPbaltdurgE2mJl595diMe0H8zgoQ3RpFqp74orGrs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1guc7x-0006F1-64; Fri, 15 Feb 2019 11:57:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A6C6F1127748; Fri, 15 Feb 2019 11:57:56 +0000 (GMT)
Date:   Fri, 15 Feb 2019 11:57:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        Ajit Pandey <ajitp@codeaurora.org>
Subject: Re: [PATCH AUTOSEL 4.20 10/77] ASoC: soc-core: Hold client_mutex
 around soc_init_dai_link()
Message-ID: <20190215115756.GC7897@sirena.org.uk>
References: <20190215020855.176727-1-sashal@kernel.org>
 <20190215020855.176727-10-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <20190215020855.176727-10-sashal@kernel.org>
X-Cookie: Neutrinos have bad breadth.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 14, 2019 at 09:07:48PM -0500, Sasha Levin wrote:

> Fixes: 8780cf1142a5 ("ASoC: soc-core: defer card probe until all component is added to list")
> Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

I just suggested not backporting the above fix for which this is an
incremental fix.

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxmqUMACgkQJNaLcl1U
h9DBkQf/X9TwoJij2h6bgM1d1CIgbjdnNl2fwGuPHaG0L0VNuOHtr5hWZCTqBfNu
430oH3R8xOgGRKh+e6BjJDbY0mEFrZHPzW6s8aBut9QyJfVMPiK9CS+z9R3svLOj
J96PpjrObnkiQvY17mJhEUKzfqr4zPl6gAgrohL4UJ1UrbTjyBRVwCArxAju2Xx7
6fotRSIuld+YiZXGuAV7qA9/Dkg906+FTF3w8qTIUWGK0pQdr+dVOdvmNu1dHQpP
TapL/WaT6fjk6gqKk0aJXZsHzjEjKc1GRo7gEoAmkM6b2kBDA0oez1axh0z8wElj
7xM25MVea38K3TJNPogQqcB9LFp/1g==
=ukmo
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
