Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932533AbeD0Jfi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:35:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53014 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932509AbeD0Jfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:35:32 -0400
X-Google-Smtp-Source: AB8JxZqvf6bcmCn4MpnH1ZH8tciX/AxdXJl8HPbdSttMNEBuCU0CuDfdfFLOi+ObVrX9tgrUbBUPjQ==
Date: Fri, 27 Apr 2018 11:35:29 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/15] dt-bindings: arm: tegra: Remove duplicated
 Tegra30+ MC binding
Message-ID: <20180427093529.GC30388@ulmo>
References: <cover.1523301400.git.digetx@gmail.com>
 <1ac41372c213e96871df1e02cada2e1899f03a7b.1523301400.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <1ac41372c213e96871df1e02cada2e1899f03a7b.1523301400.git.digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 10:28:23PM +0300, Dmitry Osipenko wrote:
> There are two bindings for the same Memory Controller. One of the bindings
> became obsolete long time ago and probably was left unnoticed, remove it
> for consistency.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/arm/tegra/nvidia,tegra30-mc.txt           | 18 ------------=
------
>  1 file changed, 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,te=
gra30-mc.txt

Applied, thanks.

Thierry

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri7uEACgkQ3SOs138+
s6EO4BAAq8j7hAxQ9InPsy3sOeg8IvvzcLMr0FMqcu9djpq/LAfrbJFTPWx7oKZw
yYFYmpvwN2BZLuFH85SQkaeC8Xy+WpKyWQpsigLa1kdUMBpa/y6a7ttaersgp01T
T8kpmxMxRHB0rHTvlXj7wLf6KP91xqI9QDjelgl65VqWAYVE0AjWP4ir21Rv4iLK
XfPdBimRy1bTRNxTtXKltS6lGdoIvsBNIDiPvluyuPo+2k35r4ad28J30fvRdBUc
Jtphka90MpHcY6OJr/+Zdl7/cJzZcHNCvcyG6spLsQ3l7K82NRBJnUAPHI2Yp6w2
DkfxPh1LQjdECCZPFRmskzqorhEvd0oVFFR/wZlqr31qDAB3KXM2tJDH0VvXX/ds
mCQ7DO3oPeMRcjr6NiiyRkVJnfhpQB6utrTf1PROEDynrqrj0QWp+gpY8BqwZHCg
QvCamz2O1fOjeyJqXFFsacPUmzTXydKbn+XpRlV4o7gFV1TtTnGaG3gw4lIT46JO
osYcDfJfZ+5Dbd+scfeamzOwYrV2XAmrlQ4vWjsoDZNHl4ycSGfK1vDteunfaiWI
azRBD9JdBEOaCQCPZUQGmIA1tv4vSViYVHP5WdLbZJpQ5SRyEFX03aqJpw98ZEPa
zWgva52D0El8pyn4Jo8w3ZU390GQ5infPuGzxruCNvQ84DpoiOg=
=avVn
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
