Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033083AbeBNQ5t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:57:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032821AbeBNQ5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:57:48 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC332177D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 14 Feb 2018 16:57:43 +0000
From: James Hogan <jhogan@kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] MIPS: mscc: add ocelot dtsi
Message-ID: <20180214165743.GD3986@saruman>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-6-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
In-Reply-To: <20180116101240.5393-6-alexandre.belloni@free-electrons.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 11:12:37AM +0100, Alexandre Belloni wrote:
> Add a device tree include file for the Microsemi Ocelot SoC.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

May I suggest Cc'ing the DT folk on this patch.

> diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/M=
akefile
> new file mode 100644
> index 000000000000..f0a155a74e02
> --- /dev/null
> +++ b/arch/mips/boot/dts/mscc/Makefile
> @@ -0,0 +1,4 @@
> +obj-y				+=3D $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> +
> +# Force kbuild to make empty built-in.o if necessary
> +obj-				+=3D dummy.o

I don't think you need this since f7adc3124da0 ("kbuild: create
built-in.o automatically if parent directory wants it"). It was removed
=66rom other places in bf070bb0e6c6 ("kbuild: remove all dummy assignments
to obj-").

Cheers
James

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqEaocACgkQbAtpk944
dnr/eQ/7BOCB34KhnDCkU8TtMAAmYg63tT8gCWBZoH6MLtUED8zftuwL4VbbkRLh
asip9p1141ReZokYC8HeRVORK+i2PzmIRUPAltvjNAn+QbBl4+q9twMH6fTImzBF
/OoNSyAQxwPGxffsOXlbIz6xUR9H8JFuErLwOyue490ne6OSBixe/RTFb+0MgLHa
E6p1JaYCRkwjEWMTUSZpLQ2ogryv+DV5fuRjSQC27XSR/22hMqOEWdEK9C52kOuS
9cCoPd0gy0wUs9KzBmezceBMRS6pXVbkeMErzl0Uq3UsGlchcz56hRcQ4eCQ33pG
wHOlP2K+aSadpKaPgpPdirWqRgCfVNta2l0MHAVhNddIYIWuEYs7n+CLrKmm138q
odWxdku4K4f2+zLpE+FXz80bPxy9Yd1mMnS4aG433GFcVEExlUXNe+1ukBqS1c8w
ppOUYmxE8L+liKSKl2sskw6/rLMIC/cXQAVbY/xcQw1KtySsFBA4MLRdSg/887qZ
NzaFX7+BDtaw4Z487Vgs8xRzso60Jbvnry1ehuCfIh7ouSTWaTBWy5nEyHiItgBw
xdiiJFrbTurR7zbudXC10RaXzXBnTFl0KKImrxT6thj8Tap8Ye+WmbTeklzQuW5i
/sV3L+eDE1S00+AtV8sRW6PMnnqam1e6MEYByFbEKAVfK5A5eRs=
=zP3d
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
