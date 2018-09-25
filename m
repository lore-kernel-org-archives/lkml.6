Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FBDC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E66214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E66214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbeIYTf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:35:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45138 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeIYTfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:35:55 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AF448807A8; Tue, 25 Sep 2018 15:28:20 +0200 (CEST)
Date:   Tue, 25 Sep 2018 15:28:20 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Christoph Conrads <contact@christoph-conrads.name>
Cc:     Edward Cree <ec429@cantab.net>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <20180925132820.GA22767@amd>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net>
 <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
 <20180925112832.GA10951@amd>
 <20180925143645.af1457944142ecfec7199d80@christoph-conrads.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20180925143645.af1457944142ecfec7199d80@christoph-conrads.name>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > Your above argument that the Code of Conduct is problematic because=
 of
> > > > who wrote it seems to contradict your statement that we shall judge=
 by
> > > > code (or text) alone.
> > > I think there are important differences between code to be run by CPUs
> > > =A0and a Code to be run by humans.=A0 And when the author goes on a v=
ictory
> > > =A0lap on Twitter and declares the Code to be "a political document",=
 is
> > > =A0it any surprise I'm worried?
> >=20
> > Would you have link on that?
>=20
> The CoC is a political document:
> https://web.archive.org/web/20180924234027/https://twitter.com/coralinead=
a/status/1041465346656530432
>=20
> Possible victory lap 1:
> https://web.archive.org/web/20180921104730/https://twitter.com/coralinead=
a/status/1041441155874009093
>=20
> Possible victory lap 2:
> https://web.archive.org/web/20180920211406/https://twitter.com/coralinead=
a/status/1042249983590838272
>=20

Thanks!

I thought you was referring to this... http://archive.is/6nhps
=2E.. which is somehow even more disturbing to me.

							Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluqN/QACgkQMOfwapXb+vKUogCfcmEPrDVV2sJyJzW7RhOSmTEM
ocMAnRoLuoqlbFn9xs3/9aM1/HxH4lr/
=zNz4
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
