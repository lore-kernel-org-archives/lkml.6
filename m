Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeEAUfz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:35:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50950 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbeEAUfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:35:53 -0400
Date: Wed, 2 May 2018 05:35:31 +0900
From: Mark Brown <broonie@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Leilk Liu =?utf-8?B?KOWImOejiik=?= <Leilk.Liu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org"
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] spi: mediatek: Use of_device_get_match_data()
Message-ID: <20180501203531.GA2714@sirena.org.uk>
References: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
 <94cba80f703be048666afde1ed53c15c3704c533.1523347340.git.ryder.lee@mediatek.com>
 <1525073196.21494.3.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <1525073196.21494.3.camel@mtkswgap22>
X-Cookie: Rubber bands have snappy endings!
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 03:26:36PM +0800, Ryder Lee wrote:
> Hi Mark,
>=20
> Is it okay with you?
>=20
> On Mon, 2018-04-16 at 10:33 +0800, Ryder Lee (=E6=9D=8E=E5=BA=9A?V) wrote:
> > The usage of of_device_get_match_data() reduce the code size a bit.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.
Sending content free pings just adds to the mail volume (if they are
seen at all) and if something has gone wrong you'll have to resend the
patches anyway.

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlroz5IACgkQJNaLcl1U
h9Aozgf/dlersQlemJt9YYytwTHQpJn6ykNz0dHqAHr3JotCFqSGnkYfnmf1BrhS
AmkDq4YgOtcv0XoGcdMCLMPeL5Ah2N2w+wkVG1JFXKSevbfAd19+rgyvrj7/iXRN
z2R2FJu2avyaAGJONG0PZ9raP0CpqaxAfd9vww/n+4py/fnFCp7/r5m1fBbN6rkF
8i6jOWvA302gUgRk9r8viElBvWNBGmeso2IJBkcevlPET6pCgUg+N0SA5bFY0yJz
U67oySQy/7z+Au+aJpdPiVsdIwGdRmWyeyGKQoVcuxl0NzERZ/9gjjA48gqTcRHT
kKupcvzZoCxZeArEo1RoLNrqE51Ynw==
=psBX
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
