Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA9AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C383205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547503185;
	bh=E7sZyLHEqEiBbEoFckXPL+EdZQJ8o3bUFV6EpNqa9B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k541Fd53bKHPgzowLZWEQ7OCq3KQ3kYSv937GzUpxjD5oALiRQ6rRnt0LH+xD84GL
	 xgyoLFMWW403RwBi0dbh1KlWEn1xBNapMDbUFSimEovQtg9nlZTzbg5ueeEPG41tvL
	 8zegxJwjtZrcuMivFDHfloDF/XvPMsH9hjMNf8eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfANV7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:59:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44678 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfANV7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g/V2nRjS6jVFRmTQrwvA7n1d8TlDMApw/1IW5XWeqFY=; b=esgOqX/vHBS4mJ5QcTyi9qOvU
        suIYT3HjvntXAT0gtvgL1JULn6Uw5lm8A/uEkG+N7NfLzsUK4z9C8erYcQ4Obo2Zaae1xyCzrWhSI
        cDseFPkqMwnxxG8adEwIHin+GtRTNr5UlwXIdgmioi5SOugsR7jTOge3ttsd/oZ6g+25w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjAGV-0008Di-Gg; Mon, 14 Jan 2019 21:59:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D23D71127AD0; Mon, 14 Jan 2019 21:59:26 +0000 (GMT)
Date:   Mon, 14 Jan 2019 21:59:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        Linus Walleij <linus.walleij@linaro.org>,
        matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-kernel@vger.kernel.org,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Paul Parsons <lost.distance@yahoo.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: broonie-regulator/for-next boot bisection:
 v5.0-rc2-20-g61b67608c6b9 on meson8b-odroidc1
Message-ID: <20190114215926.GF11073@sirena.org.uk>
References: <5c3cf3a4.1c69fb81.e81c0.fb80@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8TaQrIeukR7mmbKf"
Content-Disposition: inline
In-Reply-To: <5c3cf3a4.1c69fb81.e81c0.fb80@mx.google.com>
X-Cookie: From concentrate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8TaQrIeukR7mmbKf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 12:40:04PM -0800, kernelci.org bot wrote:

> Author: Linus Walleij <linus.walleij@linaro.org>
> Date:   Mon Jan 7 17:27:42 2019 +0100
>=20
>     regulator: gpio: Convert to use descriptors
>    =20
>     This converts the GPIO regulator driver to use decriptors only.

Linus, I'm going to revert this whole series - not sure what's gone
wrong here but I guess we can test easily with kernelci which is good.

--8TaQrIeukR7mmbKf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw9Bj4ACgkQJNaLcl1U
h9CQSQf/ZNxeO8TP3IdeM1f4m+PzX0ZvVQeav8eiT2IToghzAw5DzKDK+0KUuQNr
am1pypt00MWC3VF1jLJ6udoDgHFpEK+3EO8OBNTOJWaFS80F+FuCmiqp7qUMDsxh
YS9WF+Pj4OGUBQUhtErMkianCNMPcqSAlsl8pEQE6aHUrvQWJj4eh6Tqs7U/fQXp
0ZnUgpO6BoqmA70HdyQffwT4mEioLp050UH8fppAZyS58wYoa3Z95tKpGe9x9pss
uAYh5ScW16LglwaoXIrb8VardCQekGkfXIK3KuRyn7y8f94Ri62GIy3B6PR+9ijM
g4Rd4hJiDd2yIbF/wfs6CDOI0kX3Zw==
=m49H
-----END PGP SIGNATURE-----

--8TaQrIeukR7mmbKf--
