Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935140AbeE2Oih (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:38:37 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43254 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935068AbeE2OiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:38:23 -0400
X-Google-Smtp-Source: AB8JxZqmRWIYLPmxSRzn2t8TbQv2XO4v8wJ0ta7VE1Lcvab8PhAbv94C+je1iD5haBn7oM28++9lyg==
Date: Tue, 29 May 2018 16:38:20 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] drm/bridge: cdns: mark PM functions as __maybe_unused
Message-ID: <20180529143820.GD22634@ulmo>
References: <20180525155030.3667352-1-arnd@arndb.de>
 <20180525155030.3667352-8-arnd@arndb.de>
 <20180528163243.538de32f@bbrezillon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Content-Disposition: inline
In-Reply-To: <20180528163243.538de32f@bbrezillon>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 28, 2018 at 04:32:43PM +0200, Boris Brezillon wrote:
> +Thierry
>=20
> Hi Arnd,
>=20
> On Fri, 25 May 2018 17:50:15 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>=20
> > These two functions are unused in some configurations, and using __mayb=
e_unused
> > is the easiest way to shut up the harmless warnings:
> >=20
> > drivers/gpu/drm/bridge/cdns-dsi.c:1353:12: error: 'cdns_dsi_suspend' de=
fined but not used [-Werror=3Dunused-function]
> >  static int cdns_dsi_suspend(struct device *dev)
> >             ^~~~~~~~~~~~~~~~
> > drivers/gpu/drm/bridge/cdns-dsi.c:1340:12: error: 'cdns_dsi_resume' def=
ined but not used [-Werror=3Dunused-function]
> >  static int cdns_dsi_resume(struct device *dev)
> >=20
> > Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>=20
> Hm, I thought such a patch had already been applied by Thierry [1].
>=20
> [1]https://www.spinics.net/lists/dri-devel/msg174363.html

Yeah, that's in drm-misc-next, but didn't seem to have made it into
linux-next until today.

Thierry

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsNZdwACgkQ3SOs138+
s6F4HBAAiEcTbFfNEgt0B2F0aZmaJL+oMi35fsOc8w+6Q+WCIV6JncQrjVdORIBc
NVcXK0nc0BA3TPOydDtDnHt6mxhM6wHdOVKSiFcIiZRnaQKV/WLZ+m1l+pUW9CJb
4saYvCDi+/xKUh2ISKyXu2AE1VQ7PNEBjFry8S2B4VevBxEJmkUFHSKgdKaUMum5
GZcWOF5bNYhs32tG4met3//szeYkMzWYX/auVWf8je8oDPphl4vLXiBnA/uj9xd6
aIcbnlvKP+ILjaqMd6Zi7bpSvHr57pYIRGxvu0bA+3daim/l3Rt6w8+NUcWEhvHy
Uip4XNdz+Fd9Y2kwluwD+l7Z/27HgnxO1mI147UfAdUHu9zg1jMCDRj2yjbvw/MW
X7UgjyM7TFlwJjBkF3WpJcS9ilRjdPDrz/+fbEDklCzCo54yFune9fgcpA1O8b5T
x1Ze2/3VmQ2FJrWDt+LncRbVdIhHZDJJN2ijFgdx3UzXdzTkRmsgsfgScfKJSZN9
41I5Pmx4WlKR6XW5A4/6F9Ymsn8dufdTPm41ujwkqevRujvIMVkAL6wmpaQsiDHb
NYh0+8+fdz8vwBRh58mTQe0fwfigUmTg69e4b8W7b3gqGAUITKQfdc7x3M4rRXzW
xvsVhh8DgsI7A9ru+plNNzi/sBHpC0vMC8xmtsBeuDl5WGuem2U=
=2/Rq
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
