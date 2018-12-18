Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A700DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF2120874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeLRDFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:05:44 -0500
Received: from mout.gmx.net ([212.227.17.20]:52787 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbeLRDFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:05:43 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LufbI-1hYiqS0Vgu-00zqfU; Tue, 18
 Dec 2018 04:05:40 +0100
Date:   Tue, 18 Dec 2018 04:05:38 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/13] powerpc/mm/32s: rework mmu_mapin_ram()
Message-ID: <20181218030538.GA24278@latitude>
References: <cover.1543517818.git.christophe.leroy@c-s.fr>
 <8835330baa77d88e0267b0b1215b78c991e6d17a.1543517818.git.christophe.leroy@c-s.fr>
 <20181203215558.GK15324@latitude>
 <84624899-bbda-9f08-2527-151fddbd1b01@c-s.fr>
 <a253e9f8-1e0a-1596-e0ea-54261ac62212@c-s.fr>
 <20181217012837.GT15324@latitude>
 <18ba3a7c-ebfa-66aa-e231-b56985d0e89a@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <18ba3a7c-ebfa-66aa-e231-b56985d0e89a@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:WipPLp+OgFYtVGKKVsk29qrSTLpvF4f2h992eqjU4Q+1C77WkXm
 WYdhbElKUKEc2wxoBknxRfs8roAkpqxCxEX+5ciD9qdPwAFFxaGpfvSM437D/5vCQropigo
 tyz0Pgvjh7mJSzraleX/BMOoxx5Te1SeEBHXDlpNdXmheIx7SncbQNwPwnj0OhIi4iVyd3E
 m/DbM9+tG0ordhQPrh7qw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:khvHMg/dDzs=:heO0200MxX4jPfAxSAaGzh
 +XZOHLQk2Ygn1qXKuX+v4mpeEniqNAdWcEJsjCDwr7/J000KsRlyN5d/SUl/trL7Sqt4+o30L
 pHZ4M6UnJfmhiShRTw6tCi0zBvym2vzrkPvuKJ5TbfpW990EzSAFYp67dn7DSU8Q+ZjUbrAGR
 WEBIZsd09EWJeS5zVZvxQKqF7YEHpMjDFBpbZcIlcIwMKPODAGrcWxdecstymQHvvsBAsMLEU
 rq8uP3PxHf39MQmoyWgn54P6hpLsNfqsuGPE2Oas2T7Lze6YPoCAM6dtNfeKjBhm0hD+D9IxI
 FB3bOJ9Ik8fzWmcZg0eUnayCQpq3LZ5ftWlo28baP8XY0KbwayQVoCgfnd2DM78Su9oF4Keah
 ef4AVRYkJbaFqzeeDGdfpxKsWRgMtpD/Mv+oUbNThpO4OSf2o60qa93K7Z5wJ4FU2caP5wV/L
 N+LnyIfuXYiX20UbkuygZ9TdIXXgSVCcqP3XbbVlAKGwlZTZUniS7WF98FgAWEv26bdd5lkBu
 p5tfTekP1SI8NwpanVeedCdfdmDHyqSDhzMOWAFDw5PIg3E28LIi2KiUtXBSr7Qfl0UlBkWbw
 SpikvN/37pmxgJysFTuLpkMRV6WlMS1P9EJNr5XRrwqkbvaxoRD0Ek8ifUeGCICSu8rR/QcMs
 wvrhox0smnaLQOleDxQrMmbWTHPDisayO64fzLwwUryxxKBWZJwFw55y9YF/UiZnk6Pie9LBF
 YRtXaPeKmjDJOlf4PJekf+rbgr5qObeZFMW3KperjhDjX13s2o2Stz3oBAMkDATHXx5ByYHV3
 2Ut9H1gkSbiKe2LYJ0zLsr4Nluzpqq+VUCa0doFUYxd/vH/K6ulFAiFRg6fzV2STnIpcVd6hp
 R1DRfR3F2UslJtQRysRyRAusrtHOdL51WN5SuT2MYzb+6RUvkAG8HeTFzUitTH
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:29:18AM +0100, Christophe Leroy wrote:
> > With patches 1-3:
> > [    0.000000] setbat(0, c0000000, 00000000, 01000000, 311)
> > [    0.000000] setbat(2, c1000000, 01000000, 00800000, 311)
> > [    0.000000] setbat(4, d0000000, 10000000, 02000000, 791)
>=20
> What we see is that BAT0 is not used in the origin. I have always wondered
> the reason, maybe there is something odd behind and BAT0 shall no ne used.
>=20
> Could you try and modify find_free_bat() so that it starts at b =3D 1 ins=
tead
> of b =3D 0 ?

In this case, setbat is called with index 2, 3, and 4, but the Wii still
doesn't boot.

> > According to arch/powerpc/include/asm/book3s/32/hash.h,
> >   - 0x591 =3D _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT =
| _PAGE_PRESENT
> >   - 0x311 =3D _PAGE_EXEC | _PAGE_ACCESSED | _PAGE_COHERENT | _PAGE_PRES=
ENT
> >   - 0x791 =3D _PAGE_RW | _PAGE_EXEC | _PAGE_ACCESSED | _PAGE_DIRTY | _P=
AGE_COHERENT | _PAGE_PRESENT
> >=20
>=20
> Yes, patch 1 added _PAGE_EXEC which explains this 0x200.
> Do you confirm it still works well with only patch 1 ?

Patch 1 alone boots to userspace.


Jonathan

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlwYY/kACgkQCDBEmo7z
X9srjQ//YkSw5N9QwnyF4TE1jp1QLg5wnwHtbepzoxOfaZ4xDejB9bVXT6+smkhH
aUa+AVVkkBwiBv6Ce6X4DHaYTHxu2kXoDJWt3pN28ZZ99F64oNgnHbQpy+XWJ1sJ
mc/MQlaIDsoDjwniZQjr+gp55rZkrDVdI2GaAbVeFUlGEMKYvIGmM/w+K8X/K87N
eBJHfXM1ztnfoUqeto9H/DsajuYqxXAuGqIHyw9KqRTnUYpCXztdgfOmyiR/QlRO
9O4W9xv1eS5FiOR0XwC/QBBhE2rgOp7uRbk9d6eh8ii4edrO3oe/61xFF9E+uRJf
EP2fDPUnsHY83l8UosYcillYbsZBlIbjojflXTuyqbb+HSRl8lFxl0JDsokkCrUi
dYwbB/up8ljHlfb9Zku/h4LhOpYklWYNeAMcAJZY6W2ewiQkazIw2NA5o6YFyG1N
dowfvYPUGqbfG7OtqWbhRkfTYlliLojFpifjH1jpkwm7jDOcno4eATKojfDf0qUt
40vXg/P3UCvX+T5jkr92peYwL5S5ChCWNZQ9GlvpigFCnP0BY5NKY+KqBqDpzBuM
Z7VrVZ4WIQkoebpW90gt0DAofubFJII+4pINM/HPuiBBkq/FyFyRRfEl58DO+kqT
KorhpRuKkUb+z4bI44+6A1WM6HlORjXBpDBPe/vkqLNXAbOtEkU=
=UInt
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
