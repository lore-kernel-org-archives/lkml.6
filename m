Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B544C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EF82081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="JO73lYxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5EF82081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeKHAtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:49:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41806 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeKHAtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3xrD2QG8zjEAvkzC/4L9zLaQscVbrMf1n9wD665NyM4=; b=JO73lYxkqNh8zZbMLVOvWlfm+
        lJ8ILbprQDcMeSwn0z+i0JZSWy5DBbJEok7oLEe3QyhlBejeQif6d8fnNWoP0WZRU0pJtyVu+lZ5I
        Gk0jIxcFG5x4Wu4l3p+N4HkZEVB/nbDJbPKMWBHQShigrMvwGOJBk7Gne07ONjY/Vutag=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKPbJ-0006d3-9Y; Wed, 07 Nov 2018 15:18:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DC3E11124E14; Wed,  7 Nov 2018 15:18:36 +0000 (GMT)
Date:   Wed, 7 Nov 2018 15:18:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Piotr Bugalski <bugalski.piotr@gmail.com>
Cc:     linux-spi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: Applied "spi: Add QuadSPI driver for Atmel SAMA5D2" to the spi
 tree
Message-ID: <20181107151836.GB6809@sirena.org.uk>
References: <20181105103625.9644-6-bugalski.piotr@gmail.com>
 <20181107150327.B6DC41124E14@debutante.sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <20181107150327.B6DC41124E14@debutante.sirena.org.uk>
X-Cookie: PURGE COMPLETE.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 03:03:27PM +0000, Mark Brown wrote:
> The patch
>=20
>    spi: Add QuadSPI driver for Atmel SAMA5D2
>=20
> has been applied to the spi tree at
>=20
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git=20

Sorry, I got confused about which patch series Boris had asked me to
apply for him - it wasn't this one!  Since the review looked like it was
just one minor issue last time I'll just leave them for now, they were
applied on a separate branch for sharing with the MTD tree so it's easy
for me to drop them if that's required or if I should put together the
pull request for MTD.  Sorry for any confusion this ends up causing,
it's entirely my mistake.

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvjAkwACgkQJNaLcl1U
h9BDbQf9E18lZnH3x2dWbttEi5+uZ2JKiG2LDRupEP+Q+HQwKLvG0PZjZnTSYATF
w6PcSeKrdklNCUA7xJ9mRQRqSFle2GeAcz2q99C8chxIJwZRMSmtCLa6XXJnzk5U
VzraDwtWpdq30oaKVolnMMK7HhC5dizaOGzqmO/FXwm+5bg/btEUaflNKv4Fd+ky
aFwczzjLZqmifG04qb+FawwLM9a0QEztI4R6ExglYreyd9dIdd1v9PYlm4bL9vf9
WUjbjAENs1ROZAmNagR0FlObCzEWakEZzmj0j3XZrqS6cpJw+uySFJaAWk8J7F/a
sK7McZRulXT94oAXsv2STr5loc+1NQ==
=RV/S
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
