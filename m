Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754715AbeCGPKg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:10:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:42592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754682AbeCGPKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:10:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444BF21777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 7 Mar 2018 15:10:25 +0000
From: James Hogan <jhogan@kernel.org>
To: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, linux-clk@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Dominik Peklo <dom.peklo@gmail.com>
Subject: Re: [RFC 3/4] MIPS: Ingenic: Initial X1000 SoC support
Message-ID: <20180307151025.GP4197@saruman>
References: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
 <20170927151527.25570-4-prasannatsmkumar@gmail.com>
 <20180306000832.GL4197@saruman>
 <CANc+2y5_R5xYQuLbW7NAjO4mcW5RNn3Da77tAhYU5zj=0rkBDQ@mail.gmail.com>
 <20180307143541.GN4197@saruman>
 <CANc+2y5wsvGWszu3pePYhs2wb1_AgPdjG+ugfOCzbZVfVHDMvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ffBYM5qgR8HH9Mta"
Content-Disposition: inline
In-Reply-To: <CANc+2y5wsvGWszu3pePYhs2wb1_AgPdjG+ugfOCzbZVfVHDMvw@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ffBYM5qgR8HH9Mta
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 08:35:00PM +0530, PrasannaKumar Muralidharan wrote:
> On 7 March 2018 at 20:05, James Hogan <jhogan@kernel.org> wrote:
> > On Wed, Mar 07, 2018 at 07:14:49PM +0530, PrasannaKumar Muralidharan wr=
ote:
> >> > Does X1000 use a different PRID, or is it basically just a JZ4780 co=
re
> >> > with different SoC peripherals?
> >>
> >> Yes X1000 does have a different PRID (PRID =3D 0x2ed1024f). X1000 has
> >
> > Right, so thats 0x2e000000 | PRID_COMP_INGENIC_D1 | PRID_IMP_JZRISC |
> > 0x4f, which cpu-probe.c already handles (apparently the D1 company code
> > is used for JZ4770 & JZ4775 too).
>=20
> Okay. Does this mean I need not modify get_board_mach_type() and
> get_system_type()?

You still need to modify them, otherwise it won't understand
"ingenic,x1000" compatible string, and will call it a JZ4740 in
/proc/cpuinfo.

> >> I used to get my code tested from Domink but I could not reach him for
> >> quite some time. Before buying the development board myself I would
> >> like to see if anyone can help me in testing. Do you have any contact
> >> with Ingenic who can help in testing this?
> >
> > Not personally, but I'll ask around. Of course if nobody much cares
> > about it in practice and nobody has the hardware, there may be little
> > value in supporting it upstream.
>=20
> Seems Jiaxun is interested in the board and is willing to help.

Okay, cool.

Cheers
James

--ffBYM5qgR8HH9Mta
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqgAOEACgkQbAtpk944
dnq2tA/9GgJebgZ1Sqh3YkkT5rAjetuUyvMwU+OMWBwMunIu+1ImhcSTWocj0RRT
JjRAbBM4KhYJWb+IfmRytEQZ4zXzRN8vZhf7vxD9q6JNa7bhCDZq2AXU7AHpF4aS
I72mOO7J6DlgdP6j6qS4T9t7o/TyzgH50w1tMIFKPYCVP74LwSjWtB1goNiAPD/H
+m9QZt3vvWJM6dUM0PT4RYXxgBQbcx6UaDqjR7FTf+J5DWrAKmduC4v1Yoo0192q
N2BbyiiLdSsRGJ3nMdtcSRuVnU2b5xhU1Kh1Fg29ufhaiHLkeQJrkVeRZlwHDVUj
Sl8gmny2316B3JTJyRUQXDA043dCcs4aCVKnFUMLJdW3z/p8DtTFoR6QVJzvEwoy
jNmCiOVz8S9cK4u0TVhmUQGwPmO0bibcwycSfHQWMk3sX/fU+bz6O4D4YqriELOs
xqB8tM89hEZlbqsAHs6npFTMJl7bih1jyDyoo1GBlvvLNKbiw1qpmn4K5QP7oNtk
IWwS7150My7k6PZsm8HmdtiblrIHV27uy3/b20YcBhBsDewdUUP51ukbkwzTPwi9
Oq0pLUWo4uGkIacqISG37diUWrhqpyZjQOsi2jwimiPLjizih/3b7RIbfMez3Ur+
L4gqLfw2U/3ajhm7VZgnvu+/SKpWmBkSU+INlKktfcpKqiWWqXo=
=NHQN
-----END PGP SIGNATURE-----

--ffBYM5qgR8HH9Mta--
