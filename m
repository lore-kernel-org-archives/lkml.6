Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbeEDK3F (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:29:05 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:54925 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeEDK3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:29:02 -0400
X-Auth-Info: 01g/1B0wQtA922cDWE77wd6bZE6PB9R/7jFIaOHa2uk=
Date: Fri, 4 May 2018 12:28:42 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] display: panel: Add KOE tx14d24vm1bpa display support
 (320x240)
Message-ID: <20180504122842.33643142@jawa>
In-Reply-To: <20180416192442.qnb53b6u3bsfet6y@rob-hp-laptop>
References: <20180412143715.6828-1-lukma@denx.de>
        <20180416192442.qnb53b6u3bsfet6y@rob-hp-laptop>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vW.pxVg+QsLWJxUUfG=jmkD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vW.pxVg+QsLWJxUUfG=jmkD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

> On Thu, Apr 12, 2018 at 04:37:15PM +0200, Lukasz Majewski wrote:
> > This commit adds support for KOE's 5.7" display.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  .../bindings/display/panel/koe,tx14d24vm1bpa.txt   | 42
> > ++++++++++++++++++++++
> > drivers/gpu/drm/panel/panel-simple.c               | 26
> > ++++++++++++++ 2 files changed, 68 insertions(+) create mode 100644
> > Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt =
=20
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
>=20

Gentle ping on this - as I don't know if this patch been applied.

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/vW.pxVg+QsLWJxUUfG=jmkD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlrsNdoACgkQAR8vZIA0
zr2C1Af+KPlXskVTiaT8QMTA/1HLzsFY7FXlA+zWBgOpgV3QZBB69A+WCCZQplzl
dRs43NMKuig9Lq4SOOKoSL+loF9g0i/saWVgo2oKro6Bitlzc/KDl0W800HnwSVm
manbykIv1EchHXPdNFGiRF9yEfvVHWm46gtE80QCRofmKAWfW6cPiQokob/q9qhL
qWxKKmbraH/5W9LcEUucOZzUIsa4m7hVjqO8PL1k2Oeu0JhhIqB/fdkoDiFv6K1n
Jq5ZcYb9UvkcxFGeqXWPsPgyvm5xZyevuXDI2FTjPMOet4m7HfocajAGK2Mr8Vdo
iLtcmpjv7cwyttMjyIzw1yV9Erg6xQ==
=ZOoF
-----END PGP SIGNATURE-----

--Sig_/vW.pxVg+QsLWJxUUfG=jmkD--
