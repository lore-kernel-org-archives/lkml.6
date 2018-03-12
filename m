Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeCLHXm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:23:42 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:44551 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeCLHXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:23:41 -0400
X-Google-Smtp-Source: AG47ELvkLHLj5rY+8yMSk1Z8dKUwKmwuCc841py1tM7Vkivy0eyk5+XznK/+Ix74rfP0dKfNWlTkaA==
Date: Mon, 12 Mar 2018 08:23:38 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: simple: Fix the bus_format for the Ontat
 panel.
Message-ID: <20180312072338.GC23060@ulmo>
References: <20180309233332.1769-1-eric@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
In-Reply-To: <20180309233332.1769-1-eric@anholt.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 03:33:32PM -0800, Eric Anholt wrote:
> This fixes bad color output.  When I was first testing the device I
> had the DPI hardware set to 666 mode, but apparently in the refactor
> to use the bus_format information from the panel driver, I failed to
> actually update the panel.
>=20
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Fixes: e8b6f561b2ee ("drm/panel: simple: Add the 7" DPI panel from Adafru=
it")
> Cc: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqmKvoACgkQ3SOs138+
s6FR7w/9GXOrz3Pjyfsf2QI+yD0B2zb4HKO6htFUV1sGc4QPv5YFuEuruAde84WG
czuzh7/eIqApyjt7h7MnkR433xXe2Hxq4my77giE4p3ilj305JoIgkEsTFFsUquc
gOdRWgJ+DR55Xe0zCDP0dEvf8K6rGMsKH1CA1XfxyMvwtjBVBTE4SDY9W+4u3DJs
G8p8xPy83OpAiPGanzrTmUYbd1hK91PnvAInIuVsSTmUt/IRmnc86/Kg0aJUaGup
QPg2c/mjOGFjHnAsbvSUEF2ISbDSnKeacGXLr8X8MoXK45dkYNpTAX3u8ei5GBJb
rRY+AYC128UHC9CxjIa1DLz9c2FzCvBzTpy8S13UbZVPV3ZCFoAcHFDzS5/Qb9Cr
zDF2MO3jzz5pEoAfitmlB4mPyfU+B4B/frvN7ychbC0m8o7uR1TaL6VFGEvuU/V1
Vk4tDT2i3+eDAjKDp5FFYiwhZd9F6gD0JIU2Vbylfsytf7k8T3jbfvUp3yaUKzr+
wACqRqBqeC0t7iQySkBDp+CkYqdjMahBVkUq/SQSS0ng8D914f841j7iCfz3LSVG
VACdD5SstRfVpyJ9UBMfJNrGY5JlPdKMKaVXSfndqM2XYL5QVP81ql+fU3exXo1X
O6ts6obhKc5/RwRn31fNAKk11IX/GFX1rhG8+fFPz6DGzJDbDoc=
=R9/U
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--
