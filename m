Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166126AbeBOSLD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:11:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:54563 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163921AbeBOSLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:11:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,517,1511856000";
   d="asc'?scan'208";a="35064664"
Message-ID: <1518718272.6698.2.camel@intel.com>
Subject: Re: [PATCH] i40evf/i40evf_main: Fix variable assignment in
 i40evf_parse_cls_flower
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To: "Ramamurthy, Harshitha" <harshitha.ramamurthy@intel.com>,
        "garsilva@embeddedor.com" <garsilva@embeddedor.com>,
        David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Date: Thu, 15 Feb 2018 10:11:12 -0800
In-Reply-To: <1518717442.29950.1.camel@intel.com>
References: <20180215174435.GA19969@embeddedor.com>
         <1518717442.29950.1.camel@intel.com>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-McQKnkFd89n/5+Q/Qt1N"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-McQKnkFd89n/5+Q/Qt1N
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-02-15 at 09:56 -0800, Ramamurthy, Harshitha wrote:
> On Thu, 2018-02-15 at 11:44 -0600, Gustavo A. R. Silva wrote:
> > It seems this is a copy-paste error and that the proper variable to
> > use
> > in this particular case is _src_ instead of _dst_.
> >=20
> > Addresses-Coverity-ID: 1465282 ("Copy-paste error")
> > Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
> > Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>=20
> Thanks for the patch!
>=20
> Acked-by:Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

Dave, no need for me to pick this patch up and then push to you.  You
can circumvent me and pick this up.

> > ---
> >  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

--=-McQKnkFd89n/5+Q/Qt1N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlqFzUAACgkQ5W/vlVpL
7c6fvQ/8CU+jDbtzgBG3xyVrYIh0/1r6K6T3Lt0Z+fjRnXFl/Q9ztvBRgCT6JOqN
H2niHs965m9ck6og/F9UVhFN3oer8EcxX2Q2yNBsnYEmAnB6tt5X3LH4RIE0qvTM
qGLrDaK5GTaCmnZM2j5XO4k5CqKqTyitxTmj8nmDS9VWI3k91FfwQI1oMF2KNPdi
HBai5LOly5dgVKWf/z3Ydx2YDnXfRQkG8TbJXycUhpdrWFqanPx8apWwqZPGU6Ow
+zGGZBufXGOUBHkkxvmhKVR1q7msSsd6OMWnNNxcRjbXVF7UDjb9JEcdrUNFLlQl
qp2V5yrENAt3xSvuO3qIxQeFOdfH62YQWNO8ph4dI6Pelvcg3HBnavB7vAuL/p0m
9K+XTy4SyhcMXXIRzzjGAujkh0CxkUXKUtbISx+jFz/WBekA394/VdqVx6uLEyMD
BqnXBZo9DsQ5qC4PHFd3xzMA9+KwXu70Mj06Ft8Ci3nB5Jd1pAvYzxPLRC64WWfw
2Fd08xcZUX7Rlr1fnLz3h7GQ4w3MsB7s4eRhXAnDIS5s2PJ3dLKbeOoqRwEu8LxY
fjD+n3UrSOUb0C9x4sVx6/NnsI3K/2rwaJbHuo14RaGrV5IZfqqgSNuIOaO1Hqwp
4cqPDIE/B5kvbx8qW6XuKUTPy1C4MXTf2kFXXmJU64qQeYUPQIw=
=x+2A
-----END PGP SIGNATURE-----

--=-McQKnkFd89n/5+Q/Qt1N--
