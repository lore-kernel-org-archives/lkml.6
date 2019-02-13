Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C40C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C18222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550060206;
	bh=Rf8OeXFJAsC6iPy6gtijbSotEBgxmHzIU3P49vCQBMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l66ed7uiFOMiY58BHdwhP5SwIDsOHEWVocSuVzEExSNZi8jUvh6tRIRvHcDKU/wBY
	 syRjV/PuRfz4BupHvOcu/6MBjdrfTJmBgQ7Pl5MG0wJGDIEfOeZEkmDvmLucG25vow
	 sTk4m7oEgFX8g7lLfaAkV3WpGVYtz+I2hGLuD+Ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392045AbfBMMQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:16:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60128 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfBMMQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rf8OeXFJAsC6iPy6gtijbSotEBgxmHzIU3P49vCQBMY=; b=suNGuixZGiYd6HpV/DmUpdqlm
        3usp5PLma/PSaWGtpHYTEC4AVcNVYAdrFoE7H1pp7ml7HB2s3fvN3SVNwXACxvivmgELJj0p/0WAR
        05cMiYOfckc4Wl0QQx/G/awjEmo/v1PEkbgSlNTp20NQvZaMF2MpWie4mKTA1UaqsdD40=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gttSt-0004EJ-PR; Wed, 13 Feb 2019 12:16:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3DF741128159; Wed, 13 Feb 2019 12:16:35 +0000 (GMT)
Date:   Wed, 13 Feb 2019 12:16:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        zhengxunli@mxic.com.tw
Subject: Re: Applied "spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver" to the spi tree
Message-ID: <20190213121635.GD7540@sirena.org.uk>
References: <20190212142236.2807D1128113@debutante.sirena.org.uk>
 <4f91497a-96ee-4c10-436f-4d011edb3834@gmail.com>
 <20190212144359.GD20635@sirena.org.uk>
 <20190212164940.GI20635@sirena.org.uk>
 <OF9C8DA179.15D69C0A-ON482583A0.00283EB5-482583A0.002E45C8@mxic.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
In-Reply-To: <OF9C8DA179.15D69C0A-ON482583A0.00283EB5-482583A0.002E45C8@mxic.com.tw>
X-Cookie: Nothing is but what is not.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2019 at 04:25:32PM +0800, masonccyang@mxic.com.tw wrote:

> From current mainline branch, MFD seems support the device which is on=20
> the same hardware bus(i.e, I2C, SPI, MMIO and SPMI)for multi-function=20
> by Read/Write the common same registers.

That's most MFDs but there are some that do some level of enumeration
(even if it's just looking at the device ID that got registered) to
decide what subdevices get registered, that's what people are suggesting
here I think.

> I am checking and not sure if MMIO of MFD could support RPC-IF for=20
> different hardware bus on SPI and CFI.
> I also doubt if this method is a correct solution for RPC-IF works
> either in SPI mode or CFI mode.

For MMIO devices MFD just passes through the parent resources.

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxkCqIACgkQJNaLcl1U
h9DInQf/VCq6GImO2gWzb8POBs/8E+Zowh70BkglP3V8cajNwCqJm9L18qzSqyRe
C8GPNxySkek+ROrDjdDsGrRjtTkQYjG5+6/XLG63HQZRvbmutc/x2fIgzZlYXNWK
v9cRpwT3hBpDwI4jXqAX3Vz7aPUklAf5r2t1ui0tfN8ijrPefqrOkzgBJn6V0QUp
MJg0+9oGeGysfA3ssX2FKWBxU9d0B0C/acn4c46ZfKcANpwxufN9jZb33AON2uAQ
4LYtxSg2JZww1ZYlBd0BBKWb+bZg1TAvFjNvTrwUJWpeqJ7yS7IGR0BlvKO2VJAc
b3+u/ZFH9iS+ACmhOLukNPcuPpH0sg==
=Unbo
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
