Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935190AbeE2O0S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:26:18 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41556 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934882AbeE2O0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:26:09 -0400
X-Google-Smtp-Source: ADUXVKLzdcH9wSRvqp7CBI2HEn+jXQ7T2WNF9g8TRKKBfnKAXuQMG97EguGIhGy7phW+bX4cLjEinA==
Date: Tue, 29 May 2018 16:26:06 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] display: panel: Add AUO g070vvn01 display
 support (800x480)
Message-ID: <20180529142606.GA22634@ulmo>
References: <20180410102927.17787-1-lukma@denx.de>
 <20180514190849.18723-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20180514190849.18723-1-lukma@denx.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 09:08:49PM +0200, Lukasz Majewski wrote:
> This commit adds support for AUO's 7.0" display.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> ---
> Changes for v3:
> - Remove not used 'bus-format-override =3D "rgb565";' property
>=20
> Changes for v2:
> - Add *.txt suffix to the auo,g070wn01 file
> ---
>  .../bindings/display/panel/auo,g070vvn01.txt       | 29 ++++++++++++++++=
++++
>  drivers/gpu/drm/panel/panel-simple.c               | 31 ++++++++++++++++=
++++++
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/auo,g=
070vvn01.txt

Next time, please use the standard "drm/panel: " prefix, which increases
the chances of me seeing the patch.

Also, it's usually a good idea to split patches up into one that has the
device tree bindings and another one that has the driver changes.

Applied, thanks.

Thierry

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsNYvsACgkQ3SOs138+
s6EJ3A/7B3hYtcRF8nz6PhemNmpyvVMmtIkKN1VuUTw1ywWKe3sdv8mN3w3Hs25t
wOyRJKKvV5uOPMfWtyA8FIp/IaR+HCJABlYp/KQkAGsV5C0qRVSYBrLtPvCtM9c3
RsAsSN3Lg7hsA/W1IiNMt2JWBpeY7xGmk7HHXJWMKJjCmHelBKi3y/RMxAXejBs+
+RkDbTi7+g90b8pxQY/IjOsvSA3kIRQTrzqwXE8MmUQLLvGXwdkkd4bXBsmYA88I
kHpEAqo0eJC+bwtSjt/HZAtt1atiXMclzGwGdYzH/HjEk9/LZZ2AIHFS2YPtNKmr
AHza597m8P9UPp5lIzcG7s7AoPyNNTx8neblLCVMuJvSvGIFFJNLJ9vhHELRG1yb
2O21sdsAK0k/9ALOiOxgcDiZhijzgTl6H1RUCuIBDF8QLmObpgSxKhrqvyorjNHS
INCW0qOKL2OWkZR643OpWgV9gDujS3yah0Zaoj5G2h97J88SuCqKIlzJL8he8iWC
kV8tWSxUZ9p0x74kVNmvwFAGhJAYoySilxQ3j2VgDAxZh0kbCsL/EeP94MRp1f2v
+jam7fOGciLQ+XSWnC5J4VttBO64/oIsDx29CRZHBYqFwQ1vMxP26xcycNwsk/2R
+9kBLhcYeFguVGqjvJcX0jDpW2hxU0BSIKQfKrBP6IAvV2Ec6SU=
=vYjZ
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
