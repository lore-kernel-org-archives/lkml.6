Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbeBTQqL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:46:11 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33585 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbeBTQqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:46:08 -0500
X-Google-Smtp-Source: AH8x224brYEacEdXZsMUhWDLdcr/ANkru9b7y90a448L0LBch1anavOfPNQCoiatbH6qNN2Cw1krgA==
Date: Tue, 20 Feb 2018 08:41:22 -0800
From: Moritz Fischer <mdf@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Moritz Fischer <mdf@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 2/2] power: reset: gpio-poweroff: Add support for
 timeout from DT
Message-ID: <20180220164122.GA32079@tyrael.ni.corp.natinst.com>
References: <20180219225918.2311-1-mdf@kernel.org>
 <20180219225918.2311-2-mdf@kernel.org>
 <CAHp75VfKXe-7pzPT=9N3r20YV5Sq1UyHPoYwoLL1L4mjt8cEUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <CAHp75VfKXe-7pzPT=9N3r20YV5Sq1UyHPoYwoLL1L4mjt8cEUA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 04:12:59PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 20, 2018 at 12:59 AM, Moritz Fischer <mdf@kernel.org> wrote:
> > Add support for reading a timeout value from devicetree.
> > Fall back to previous default of 3s if nothing is specified.
>=20
>=20
> > +       of_property_read_u32(pdev->dev.of_node, "timeout_ms", &timeout);
>=20
> Perhaps stop being OF-centric by using device_property_read_u32() instead?

Good catch, will do. Should probably change commit message accordingly,
too.

Thanks,

Moritz

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAlqMT64ACgkQUVwKRFcJ
cNhfLwgAvdUUqoE3q2++dLoXZJ6YqurxkID/VWkbsqDIkWsjNQ4woqXct9Z9Kymm
Is9oetzJ1Gni5wvUPL6FgVOX+BlkD7/1JmuBrbl5IB8J2H1MKCMYwWgFy0LxHZq9
dK/w0Pj8/ywLpGIBrOjJA3aEnZNmZIuXQaH2Aw0xbEVlBj570UCgT7SDEpMNwK8C
KHbiO5FpScy0wGHcGvSlmyWj+Qa4QbznP16vIOWzKJ7+JnpThF41hMxnElxoNoEy
eM5Px3Qa/00A23nE89yBvx/+DQX6CNg5hgeDc+fMPRFSQET8q5gGnu7716FpNnug
Tc9hzy9EPRv43wB0+EgfIWFvOuzWLg==
=jG01
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
