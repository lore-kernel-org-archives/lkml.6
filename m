Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15709C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37A22077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="KRu80Cpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37A22077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeIEPb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:31:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39832 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeIEPb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S8SD5He3LdvjXjtummzn1IiJlpuYazc6L7by6gFKEAk=; b=KRu80CplOsCiCzdebLzqpr1ku
        kWpLWXSy3QxPrwZQIoZA5BGzo6FgPROIxIrhXzlFiBqS1HXIBPsDEnaJP+NvadLEHfpy1W5UvxpEw
        701UxZahJCm8FPc3CIXIOAbWYuu5quo7Ggh2/fx1FK5mkRTuDaExT2A9gtokuI8ImPaY8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fxVZ7-00027H-49; Wed, 05 Sep 2018 11:01:41 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D94C911229D0; Wed,  5 Sep 2018 12:01:40 +0100 (BST)
Date:   Wed, 5 Sep 2018 12:01:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 1/5] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20180905110140.GG9781@sirena.org.uk>
References: <20180905104120.17252-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0hHDr/TIsw4o3iPK"
Content-Disposition: inline
In-Reply-To: <20180905104120.17252-1-ckeepax@opensource.cirrus.com>
X-Cookie: Two heads are more numerous than one.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0hHDr/TIsw4o3iPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2018 at 11:41:16AM +0100, Charles Keepax wrote:
> From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
>=20
> Lochnagar is an evaluation and development board for Cirrus
> Logic Smart CODEC and Amp devices. It allows the connection of
> most Cirrus Logic devices on mini-cards, as well as allowing
> connection of various application processor systems to provide a

Copying Linus who's been working on improving support for plugin modules
recently, he has some patches out for review at the minute adding a
framework for such modules.

--0hHDr/TIsw4o3iPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluPt5QACgkQJNaLcl1U
h9Duqwf7BAGem8JcPsaC6mPWi7EJDt1jct1iUA6/PU7xd+QmuIduIcWEdn5uaGME
e21BdE4RU7YVrTuBqt6BWqPmU+QTNMikG1oyK0pNknwxNrXPBgszSDy5IiAqlXi4
puGMKnfK6VqfkuGw3jOzmPbNwIG2MlWvgixdJ0LL48Ydr0vIYroS2JgFgRWcmmgV
L3YhnAYBWCeAbRkRO7WnQUT8R0Aqhh0gFQHyS0bmlXBr/KOXqyzKtsa4Oy4uYtg6
Lrznvsqxn/HE69wJE0W+tjt12aWyy22HMz5+6u++b7+9wSBxK3rQlriKG7cg8DSE
ROn09UZp/zZqHTkrs1p5CrPLrRn+RQ==
=4MS5
-----END PGP SIGNATURE-----

--0hHDr/TIsw4o3iPK--
