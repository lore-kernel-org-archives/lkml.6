Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753736AbeD2Pho (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 11:37:44 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:43716 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753436AbeD2Phn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 11:37:43 -0400
Message-ID: <b7aca3a0e1f90e5048c5ca81c42bf41b318b260b.camel@paulk.fr>
Subject: Re: [PATCH] ARM: dts: imx6qdl-cubox-i: Move card-detect GPIO to 1.5
 SOM devices only
From: Paul Kocialkowski <contact@paulk.fr>
To: Jon Nettleton <jon@solid-run.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Date: Sun, 29 Apr 2018 17:37:32 +0200
In-Reply-To: <CABdtJHun8DWbr-bUgwQEK61UXMLh5pPkwvUTF+KxhHmJaXEr-A@mail.gmail.com>
References: <20180422142151.17910-1-contact@paulk.fr>
         <20180422143911.GB16141@n2100.armlinux.org.uk>
         <8012696a7bf0132dd2361a896bf0abfbe8a3084e.camel@paulk.fr>
         <d167cc6987fdb7f04493c634873d430dcd216887.camel@paulk.fr>
         <CABdtJHun8DWbr-bUgwQEK61UXMLh5pPkwvUTF+KxhHmJaXEr-A@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-XSX1RzpL/GNuv6bJDJFk"
X-Mailer: Evolution 3.28.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XSX1RzpL/GNuv6bJDJFk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le dimanche 29 avril 2018 =C3=A0 16:09 +0200, Jon Nettleton a =C3=A9crit :
> You have either an initial early developer unit (pre-production) that
> was assembled like this for testing, or a unit that someone
> specifically ordered assembled this way.  You can see from the
> schematic that this option does not have a CD-pin because it is meant
> to be a more permanent storage option.

It turns out that the card-detection mechanism was somewhat broken on my
device (which does have a regular push slot). It would report card-
detect only when the card was not fully inserted, and stop asserting
card-detect when it was pushed fully.

I used a fitting tweezer to move the mechanical parts around and got it
to also detect the card when it is pushed all the way.

So no change is necessary after all, it was just my device that needed
fixing.

Thanks for the helpful answers!

--=20
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-XSX1RzpL/GNuv6bJDJFk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlrl5rwACgkQhP3B6o/u
lQwAbw/7Bzj6Jh6/I1RzqllJIIA8adB4sSHO/zK3B22fF3nCjqH3Cgct4FkI0m5B
Sy8sLagBySzdaCxbO8MS9LlqTGq5nJi2TG8N7WDEgHyBUKJZEH2syi7r9k5BURfZ
oAi68v9sfHQGfvwf+1qGmYIdyhfhMo1MEJxAeJP2NKqy0t/Gg8L6rWo3WE6dwdeD
7T/dagRIVFRTrvynfgER24nFDkQaiP5fYfyXqZ10m18obLVp+5VaXF/2lNnGcuJQ
huld+EEU/lfU/N1gg1I2DIG2mkG7LMgGMNWZzQ8CXi9oqeXA+VhPwmM/2MAZDlVF
uk/j9qfdIJbqGmACiBWL1jboeflGou451WLcLm/zCj7UpGfhUb1eXW23Mziqk7RR
WhYfT/of83OSRroqiSLmt+tfF7D+EdTg1bQibNCCEib5NiO6WUn4d9Gxaq2rb/Bn
aRvXRj1h4EiVv7FZC7FwPROPuVuK0B4JH+Aol8YOUk8HMbHBe65CHzihgV0851qJ
B08yjBRuYICRmRDMn3w6OGsnGWLk85PKBd9x0SC3P77+M1GxaSy5faDXrW8ziWpL
tSemOKUopQ0/qRwaVn4T2wRYLUKZBCRMbejMxKkEknDVPvqNprPwXwScZgj4vtD0
CDBW6G1xKLpR/srEPo5BmfVsHE+24FLFu6/V2sfb4z0L3X5Q4/I=
=1KCD
-----END PGP SIGNATURE-----

--=-XSX1RzpL/GNuv6bJDJFk--
