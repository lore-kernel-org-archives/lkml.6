Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B784C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28ABA218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548438442;
	bh=0Z+qTGaRKSxDsSh+kYy2Jmy+M1JfTLTxZMhiniM5sb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xbqKXbi6vUUWJ2UZd1Zc6JdLlokJAmB5T6fvVehXZ5YV8dma0IGnUutnE1bfFubdb
	 63qM0JrrmoaCKaTRtHAepO25Ep9B/fHr7tG+URn50Es0l3qInZ2mfoGs7fcUeEgFo8
	 v+omw8yy9Z3amB0wy2VQjXVpB9UAt5FaSqw7gjbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfAYRrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:47:20 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34296 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYRrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jp0ESmevg+3eVpFgCSGhcwzL//NUG3B5AKD7zupC8Hc=; b=Ses3Y4S43xeXfAlYZJCNTZR7p
        uruvwJolTHIr7d2VfhcJzfuUqbbJL7bNf80MkV3r6PT14TZZteQnvqUY2ihYyqQ/pa0KwxWsxSqJu
        IH9XsDa8Brg//RTwnw5PEQq63PScTSzEQJcMKUfU0UssHnZCsnivfeMt3SrnmTitmLJT0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gn5ZS-0004Qp-KL; Fri, 25 Jan 2019 17:47:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E766E1126FC0; Fri, 25 Jan 2019 17:47:13 +0000 (GMT)
Date:   Fri, 25 Jan 2019 17:47:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] spi: support inter-word delay requirement for devices
Message-ID: <20190125174713.GA6939@sirena.org.uk>
References: <20190125114429.20066-1-jonas@norrbonn.se>
 <20190125114429.20066-2-jonas@norrbonn.se>
 <CAMz4ku+sqzK19994BpdSfaDjNdXW_-gnCutr_fYQiv5ynxOq2g@mail.gmail.com>
 <f34151c8-28a3-3d53-a27e-b5ff512d9c94@norrbonn.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <f34151c8-28a3-3d53-a27e-b5ff512d9c94@norrbonn.se>
X-Cookie: diplomacy, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 25, 2019 at 01:06:45PM +0100, Jonas Bonn wrote:
> On 25/01/2019 12:53, Baolin Wang wrote:
> > On Fri, 25 Jan 2019 at 19:44, Jonas Bonn <jonas@norrbonn.se> wrote:

> > Can we configure it at runtime by the device rather than at DT time by
> > the controller? If yes, we already have a patch for this, please
> > check:

> It's a characteristic of the SPI slave, in the same sense as CPOL/CPHA are,
> and therefore it makes sense to specify it in the device tree.

No, that doesn't follow at all.  There's two bits here - where the
configuration gets done and the mechanism by which it gets done.  If
something in DT is completely orthogonal to which device it is a
property of.

> Having this as device property rather than a transfer property allows this
> to be configured one time in setup() rather than having to fiddle with the
> configuration register for every transfer.

That doesn't mean that the coniguration should be done in DT though, and
given that this presumably is a property of the device there seems to be
no reason why we'd have it in DT - if every instance of the device is
going to need to set the property we should just figure it out from the
compatble string instead.

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxLS58ACgkQJNaLcl1U
h9Ci1Af+KPQ6Fd4EwOmXjTuA/3wvO5WHx034mRClNaY5DwGvpFwEr3ZJmUQlIDND
5Sd8+g6AjlOmkjsv7Lhoe2UCvYcPVUqbr5J0HId083UZDlHi7vIBChD9JnW5a0Up
u0aur6HuzudvMplSCT1eaCtp0EZ81TdwfPsLESCTAe1dGUQUSANCpv2SpbJfDtBO
dLituQEv3GeGhiGtoEcfajriq0k+IaI/zC6D+iaFgR1qgzU9YCmPQCYtw+MtaI2X
nUXxQyOx8G7W09bToK55cHSBd6k5uwrCBK0rGbDERSp+h+nnQoZMiLxxFMVd+PTm
ceJVw/ruBPHRTpIz0bLX3wrAUWLiXQ==
=xcYV
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
