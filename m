Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeCOKpQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:45:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54233 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbeCOKpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:45:14 -0400
X-Google-Smtp-Source: AG47ELtODgBC1ZZG/+LIs6nL7kdRqe5IG96K8zn210xi2owb9CQrQ1u4kuXkR0LWAyEC8YxqmFyWAA==
Date: Thu, 15 Mar 2018 11:45:11 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] drm/tegra: dc: Dedicate overlay plane to cursor
 on older Tegra's
Message-ID: <20180315104511.GC15393@ulmo>
References: <8d9c7220b1d2cf126bd2030e5d232ec06f761440.1521075485.git.digetx@gmail.com>
 <f48200af36c3358d549fc451fbc754c2a37b0d47.1521075485.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Content-Disposition: inline
In-Reply-To: <f48200af36c3358d549fc451fbc754c2a37b0d47.1521075485.git.digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2018 at 04:00:25AM +0300, Dmitry Osipenko wrote:
> Older Tegra's do not support RGBA format for the cursor, but instead
> overlay plane could be used for it. Since there is no much use for the
> overlays on a regular desktop and HW-accelerated cursor is much better
> than a SW cursor, let's dedicate one overlay plane to the mouse cursor.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)

Applied. I'm not entirely happy that we need to sacrifice one of the
overlay windows for this, but you're right, it's probably okay given
how little planes are used on a regular desktop.

We could always provide a module parameter to switch this on and off
if that's ever something we want.

Applied, thanks.

Thierry

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqqTrUACgkQ3SOs138+
s6FEEhAAgJOMBgV21IHagDteeJ/4/5iPivGgzdNaSD61iA5UCp07Ke/c4EiT1dmp
PGRFAfl6yvKkd0gPDIhBQSB7I9oJsCAsLsxxvJE5roqdoJj/i/ZgggjVAkNae10l
gcV4xmYCdwOgxKHbILO09Kw1+M0bL+oSXdCX2zCwAsfTUcRj28rQ/OLcAeP7iza3
JE2NePsmQ81kAlTsWcAgSJvEawhZ9l2w2J7fpP3rSlQT0ksdVWFAPfvZu6LkOBmF
KqH/PmiXqBZsIIPEYxXlB0KNNUfQ//0CeiBX+yrfnrCQC9tXNgf5ruAilzbXK7Rj
eFmLzc1vZNXzfNsCcvCL9/QIus4RSZJCBFMg294PEBiv04y2aMOsjbuvFUVvkXvb
2FGwjfYz69zEU6WYyx4ilt/1QzUnWGXKYSD9FmZ0aFtzzHk4QGuZd6ki0QDtLkFn
gllvffrnH4lcvRpyTjPjEP6+clnb70pE89LVwxtBKPmIIVEmS732Wl9ZDBtSDAQc
uicPBTBz1f1Z4ADuJ+ytK+yihaDWsAft9edGyDSmRULxZhi9RqRBjN14Y/t9bJwv
ZCdRVMln+jwCPB+0RaqtdslXZ/iJvWX+raGzxfDt224nFjqoXepk1mjxuPn2jqCT
mL64AI6arUnUDMfTe5GHB0ftOTehSDzPGgQSIYYKduIxFvf1QfY=
=Tl4S
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--
