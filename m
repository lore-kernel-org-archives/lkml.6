Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeEQVWp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 17:22:45 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:40394 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeEQVWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 17:22:44 -0400
X-Google-Smtp-Source: AB8JxZoZopvd7+Rd1pYcSYa7gpGtZ93QJGP+ua/syVHaf+eCu45YDfMrjH3oH4YN67NENZgXQhrY8Q==
Date: Thu, 17 May 2018 11:22:41 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH] scripts/tags.sh: don't rely on parsing `ls` for
 $ALLSOURCE_ARCHS generation
Message-ID: <20180517212241.jb7z6mj3nlynxuvx@gmail.com>
References: <20180516001311.ng6wyxdjqty5ef5j@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ckqo6g5yg2iasbxz"
Content-Disposition: inline
In-Reply-To: <20180516001311.ng6wyxdjqty5ef5j@gmail.com>
User-Agent: NeoMutt/20180323-62-378db9
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ckqo6g5yg2iasbxz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2018 at 02:13:11PM -1000, Joey Pabalinas wrote:
> and directly assign it to $ALLSOURCE_ARCHS; use a subshell
> so `cd` doesn't affect the current working directory.

Whoops, turns out the inner `()` isn't needed, so going to
revise and send a v2.

--=20
Cheers,
Joey Pabalinas

--ckqo6g5yg2iasbxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlr98qEACgkQruvLfWhy
VBmLaxAAoOOBxQSLCHYHXSAjqv7u/szt6XCR1RwGP1O1/ZAv1gOBBVVHQXOMCN6V
acsDTsdUoyo/IkPUnVBLlOcc+FRAOhWgHxH+P9ESX1uVVdSx+vAEgC2bYAYJCPXy
03pVZ6dnEYPoECe1LR575lY/1WyNgRwIt0XgbgNR04qfUK+0JLoxnfC/+8qr3uvh
fOzQPC0jEs8CQc4+ox7lnh3O3Gvx6jYMn4hRx6lE4nTPHo4TW92VSLLsUAx4wdZV
qKMp2RjL381BiXYts8lhstjrsti3aUcgJYE3qu5m0C5k7FPOmIngK+n5XBRh0HSF
rfu86SWz02lre6E/AOvEhLjSA2X5Dd9LPhode0Gq4+y9OEpdvra4vM46MRagfhEA
g+23jcXyFQHh2WLpZTClQUSrNRJIgiGdCRuIKw7uUz6W3Cb4PcVj/vxg9zW/eByH
NDIv4catAcH9CvpHlYiwqxuRTKA++/L3zDMqIneQEBqvSEMJ4wzmhOaLloICn0rz
lU2UmUuDNEF5UlXMi7V2IEqewCJRnC42zrKeq+z4bA7opQfFBlkTo/JvcgM9QhWm
/ylO2QL0BvPX+hgLL09lVEO9m7XSQLTbrwKyJA3DWCT3H8FM3TiZF7lYsEmRyBm2
umKASO/plV8ngtWHZv+G6l7s71QlFAywAQgYxaofdFw0gyy4Dyk=
=S7Kc
-----END PGP SIGNATURE-----

--ckqo6g5yg2iasbxz--
