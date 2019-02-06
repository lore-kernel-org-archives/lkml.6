Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A579C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47270217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549469315;
	bh=WoEo4TreuEOnYRgdmDLp325sBp/GToj/Jo7yOYszqck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mf7Iv9kKbNbdXYELrEh6HSlp5cvwepxLysetHs7ERd6BMF3iiQywcQAj9hgxycdXm
	 yrgIHL7EcSMtL2kCBOG0rfsZE72KrCsyIW5HRiyYlfAcA9UOMM9BJWXkDn93q9h1Kx
	 nuNxuD7+0TxNBtSeQg3kuuoohr8tecCevskUgkXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfBFQId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:08:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46810 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBFQId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WoEo4TreuEOnYRgdmDLp325sBp/GToj/Jo7yOYszqck=; b=grIXahZ8baCm0LQnjSbhy2IVK
        k7H9LsProEhhxCDqCfAWmNq0+WiqdDjaHD5kD24Tk5D2NkIOLCD0deKej51tB0PuJsvKehynu8u9I
        kMy8PoyCLSphhlIhKav9nSMubNEjtewgElsXOIydEx0TUhcP9AIkzwbJS2s52wE7kHO9o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1grPkL-0006tB-R8; Wed, 06 Feb 2019 16:08:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 43FE41127EA3; Wed,  6 Feb 2019 16:08:16 +0000 (GMT)
Date:   Wed, 6 Feb 2019 16:08:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tudor.Ambarus@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, bbrezillon@kernel.org,
        Cyrille.Pitchen@microchip.com, bugalski.piotr@gmail.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v6 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Message-ID: <20190206160816.GD17630@sirena.org.uk>
References: <20190205173254.16388-1-tudor.ambarus@microchip.com>
 <20190205173254.16388-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline
In-Reply-To: <20190205173254.16388-2-tudor.ambarus@microchip.com>
X-Cookie: In space, no one can hear you fart.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 05:33:06PM +0000, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>=20
> Set the controller by default in Serial Memory Mode (SMM) at probe.
> Cache Mode Register (MR) value to avoid write access when setting
> the controller in serial memory mode at exec_op().
>=20
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> v6: no change
> v5: collect R-b

You say you've collected a reviewed-by for this but there's no
reviewed-by on the patch?

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxbBm8ACgkQJNaLcl1U
h9DUSwf/SwsNZqQQTTU5XFciBiMdWRRBaxg3WW4hWjTWIrLVYjcB21QsuvC9Sxds
4yfqRnDD0VNgpxnNN2UhQ+RuDXjwpvZasc3goyrR432ilG/+GdRRNWLMGkxxRC8u
kcEG3E6TSA2WdXRahvhepBK53R7lnnYD8GdZIrOMNKu0c3mJdX3Ksy3aYZ9XD0Rf
k+uTgCHDekLYThyaxeWc52Npo12yh8oOJt4VzA4+olU5ZQ/mqptZM5hDNc0b5VrJ
YXeLvvSkog3krfdK5mpDrcFp0/zg2vAqat8d5TxqR3dR8z3LRyxykfTOH5ZAjdP/
kYJ5nrbTOz0QV1Ato4twWY63x3rKkg==
=Ij/B
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
