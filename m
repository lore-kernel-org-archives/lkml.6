Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031627AbeBNVwk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:52:40 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55923 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031509AbeBNVwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:52:36 -0500
X-Google-Smtp-Source: AH8x225Zs7QAXPcR4v1VX1x2Gcn2NSrkkAwvMQcE0hvvO88u/T6BOeRlItfD6HzNkFbVUFWxwr70wQ==
Date: Wed, 14 Feb 2018 22:52:33 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Andreas Bombe <aeb@debian.org>, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: Linux & FAT32 label
Message-ID: <20180214215233.tbcoieywczdwvy37@pali>
References: <20171004153332.GA6696@pali>
 <20171011212435.znmtdnsxcd5ectub@pali>
 <20171105130608.5oww3b2fnnrwe7ok@pali>
 <20171109212131.uxraxzwpvrlyfyys@pali>
 <20171119124440.ffxx64zjmwedmtdp@pali>
 <20171120111256.zqvmpzdcf6ncyi5m@ws.net.home>
 <20171126191925.zowfpduhyic5w4n5@pali>
 <20171127121301.b6obxoqr4azm3zvs@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="al5y6zy7cw5rjetk"
Content-Disposition: inline
In-Reply-To: <20171127121301.b6obxoqr4azm3zvs@ws.net.home>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--al5y6zy7cw5rjetk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 27 November 2017 13:13:01 Karel Zak wrote:
> On Sun, Nov 26, 2017 at 08:19:25PM +0100, Pali Roh=C3=A1r wrote:
> > On Monday 20 November 2017 12:12:56 Karel Zak wrote:
> > > Go ahead and send patch :-) (also with LABEL_FATBOOT=3D)
> >=20
> > Ok, I prepared patches for util-linux including LABEL_FATBOOT:
> > https://github.com/karelzak/util-linux/compare/master...pali:master
>=20
> Seems good. I'll wait for official pull request. Thanks!
>=20
> > I have not created official pull request on github yet as Andreas have
> > not decided yet about dosfstools/fatlabel...
>=20
> OK.

Looks like that Andreas is not responding to mailing list, nor to
private emails, nor on github for 3-4 months ... I hope he is OK.

But I do not know what happened with dosfstools project now in this
case, if it is going to be fixed or not.

I have prepared more patches for dosfstools project, but do not know if
I should open new pull requests or wait (how long?) or do something
else.

If it helps for somebody, I can create fork of dosfstools project and
include there all changes which I have prepared.

Any opinion? What other people think about this situation right now?

Karel, do you want to create official pull request for above util-linux
changes, even without fixes in dosfstools project?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--al5y6zy7cw5rjetk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWoSvngAKCRCL8Mk9A+RD
UhwAAKC9+ps9lSDMUEnq/dR7ZfeNUIE83ACgvNwrECrMRrgLB0RYH7RYkSiR0GM=
=Kl/L
-----END PGP SIGNATURE-----

--al5y6zy7cw5rjetk--
