Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934770AbeEIOQS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:16:18 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:49078 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933546AbeEIOQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:16:17 -0400
X-Auth-Info: AjNoczvLg2SQkxNVzafp6eOswVQtrGuPpu4qUHvQEX0=
Date: Wed, 9 May 2018 16:15:45 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] display: panel: Add AUO g070vvn01 display support
 (800x480)
Message-ID: <20180509161545.6bba76ef@jawa>
In-Reply-To: <CAL_JsqJii+ssU8kjVgqvSn77smMb4+gkT=PcwfCwvavReuAo+g@mail.gmail.com>
References: <20180403101525.22369-1-lukma@denx.de>
        <20180410102927.17787-1-lukma@denx.de>
        <CAL_JsqJii+ssU8kjVgqvSn77smMb4+gkT=PcwfCwvavReuAo+g@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iVCV5_VFT3Ts81h1T37f06_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iVCV5_VFT3Ts81h1T37f06_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

> On Tue, Apr 10, 2018 at 5:29 AM, Lukasz Majewski <lukma@denx.de>
> wrote:
> > This commit adds support for AUO's 7.0" display.
> >
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> >
> > ---
> > Changes for v2:
> > - Add *.txt suffix to the auo,g070wn01 file
> > - Remove not needed bus-format-override =3D "rgb565"; property
> > ---
> >  .../bindings/display/panel/auo,g070vvn01.txt       | 30
> > +++++++++++++++++++++
> > drivers/gpu/drm/panel/panel-simple.c               | 31
> > ++++++++++++++++++++++ 2 files changed, 61 insertions(+) create
> > mode 100644
> > Documentation/devicetree/bindings/display/panel/auo,g070vvn01.txt =20
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

Gentle ping on this patch .... It is almost month now...


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/iVCV5_VFT3Ts81h1T37f06_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlrzApIACgkQAR8vZIA0
zr0iAgf9F96IbluwagWXGVlqyhZh+e1toEQjziwibpXSqEpD/VmuF0Tsa+96uYrt
/4k1vl0ZZIGDPOxgBxxi5qLi88qRmQzti5n7csiex7kX/DUx07AXS0Q4nqoKr2wY
w+A/dxyTickH4oCCVs4ZMWQy3OB9KtTP8+2l/q01MikjKFHLXfyWjbPKNi4DTac+
XtC6lY1po8QXub469++2MDoKC6CLZ/7kxQN51WsYbbqfap6SsFMaC5LJbotIZ/ry
bnwnFcFDCTYcd3kIlMmx1jiVSagzGb+IWDkHx1BpiRyO4MBeoB0L807teSKzceRO
hXfSS8Vyod86exk/QHRviUdvi/xcUw==
=K62i
-----END PGP SIGNATURE-----

--Sig_/iVCV5_VFT3Ts81h1T37f06_--
