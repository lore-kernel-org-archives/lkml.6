Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbeD3J1h (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:27:37 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43707 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752348AbeD3J1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:27:36 -0400
X-Google-Smtp-Source: AB8JxZoDO9qGwAwmXVTgVB4H/kwY4ePVs6JOBDh0xFXRSOULIa3JQRJ+bAWq2X7D0nFLQ3LlfnuZbw==
Date: Mon, 30 Apr 2018 11:27:31 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panel: Enable DSI transactions on the RPi panel.
Message-ID: <20180430092731.GA2270@ulmo>
References: <20171031193258.17373-1-eric@anholt.net>
 <20171031193258.17373-2-eric@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20171031193258.17373-2-eric@anholt.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2017 at 12:32:58PM -0700, Eric Anholt wrote:
> It turns out that I had just mistaken what type of write the register
> writes were supposed to be, using DCS instead of generic long writes.
>=20
> Switching to transactions instead of using the atmel as a bridge also
> seems to resolve the sparkling pixels problem I've had.
>=20
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Fixes: 2f733d6194bd ("drm/panel: Add support for the Raspberry Pi 7" Touc=
hscreen.")
> ---
>  drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Did you want to take this along with patch 1 through drm-misc-next? If
so:

Acked-by: Thierry Reding <treding@nvidia.com>

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrm4YEACgkQ3SOs138+
s6HOUQ//cWBKxhPHpo99liEnuylq30AaLeuGx99PVspiJ0nA2rrIV13o3n33QqFd
jApQojFJ6Y7hWmVF5sgf7jpj2Weq95L3a95a+Ko9hwIIfHCntPe4UEbKbizd0ChW
JCL4mI4oG+s7DPjzwOkfSCVAsF88lsqE6nfRJAIhFICACSxM4OvoR6YqJvizPYyd
uGo/se/iUoL7sAcAuAr0CR/2h4hnoQyRzwOSRY++UyqVgnJJ7rz6UESJ+glk5hQQ
v7yGlBHcnzqTVXhO6V1Crhw9uP66irUS0YrO9/0/OdJgcn/SYQoy8FGa1fwcpSz5
WqDdXk9p4q09eRmMW//9J8Wv1wqi3k02tHNxqnXq9DG3CxVw5weVw5298nnKpVkN
eRWEDy1J510UhokDsMiW6wO6szTo4Qkd/HOsN/jPo/NYyKN66Qpv4yAP5WTDrinU
0Hp7sNEU1DfZrxt3oFrpJ7rYRVRhYhqqEarqkepHJi3xum3rv6bGql2x+QTv+e40
zTvPvIsoBcR/ITvsC6+3bk90ElrswT033+A0N8s7sB7TI/0VjblIpLHlyliRykCh
UGRF9q72iK9riiwHTD9q8RTIGaiSp3r/RJcb62ru6W173BTquCFiyQCEekSQYOM/
CLkin+vu2YZ8ucqoJifmux05dVz4MEImbsDp4MIwYYnbG7dQ450=
=F8ks
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
