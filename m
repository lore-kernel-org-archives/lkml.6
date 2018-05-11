Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753366AbeEKPEn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:04:43 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:36754 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbeEKPEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:04:41 -0400
X-Auth-Info: q3Y0UD1V/kx1WOeKeTQhRbxmcf5RkEMoFtiLz56OyCM=
Date: Fri, 11 May 2018 17:04:07 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] display: panel: Add KOE tx14d24vm1bpa display support
 (320x240)
Message-ID: <20180511170407.6c1c6f97@jawa>
In-Reply-To: <CAL_JsqLHwOv5+yoJ8S+74TmA2nUxzohhAkksZtrBCK7CAnp46A@mail.gmail.com>
References: <20180412143715.6828-1-lukma@denx.de>
        <20180416192442.qnb53b6u3bsfet6y@rob-hp-laptop>
        <20180504122842.33643142@jawa>
        <CAL_JsqLHwOv5+yoJ8S+74TmA2nUxzohhAkksZtrBCK7CAnp46A@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xU.VF1Ch=hs4zt3QjPG/F=e"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xU.VF1Ch=hs4zt3QjPG/F=e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob, Thierry

> On Fri, May 4, 2018 at 5:28 AM, Lukasz Majewski <lukma@denx.de> wrote:
> > Hi Rob,
> > =20
> >> On Thu, Apr 12, 2018 at 04:37:15PM +0200, Lukasz Majewski wrote: =20
> >> > This commit adds support for KOE's 5.7" display.
> >> >
> >> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> >> > ---
> >> >  .../bindings/display/panel/koe,tx14d24vm1bpa.txt   | 42
> >> > ++++++++++++++++++++++
> >> > drivers/gpu/drm/panel/panel-simple.c               | 26
> >> > ++++++++++++++ 2 files changed, 68 insertions(+) create mode
> >> > 100644
> >> > Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.tx=
t =20
> >>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >> =20
> >
> > Gentle ping on this - as I don't know if this patch been applied. =20
>=20
> This should go thru DRM tree via Thierry.

Would it be possible to pull this patch along with:
[PATCH v3] display: panel: Add AUO g070vvn01 display support (800x480)

To your -next tree (as we are now with -rc4) ?

>=20
> Rob


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/xU.VF1Ch=hs4zt3QjPG/F=e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlr1sOcACgkQAR8vZIA0
zr195AgA5G6IoQZcFMD90RBg78llcnE9ygCo0yXiRhvqr5p5DJKjIH8IFNgg+mAx
5WJhLcVCQmXl+oe0jMfmKj4TOqx2KOsrkrj9Nq1hAXg0tX2GaluJ38VGlFGmjYzF
V6m0nMwbnvzuiqq0g8Dchmt1THkGoW6jH97ld/P3yefh0jh0MkpKHPmYf4hU9LJm
YnGnydpGgRpZ6OAEdJbpBVclpv8EBTcc5HaUEeeXq3xO5Bd/4FqhMjv6Iu1oujV4
Xu56C2TCTgplVsAh6q6S7dVnvd0JS6DjnnTRR5DwaqNE/rI5kbc2IBdyqWDTYB49
WWrnmD0iPCflJZS9dC9mRx2SsFU3fw==
=r/LW
-----END PGP SIGNATURE-----

--Sig_/xU.VF1Ch=hs4zt3QjPG/F=e--
