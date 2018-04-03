Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeDCOpv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbeDCOpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:45:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081D420CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Tue, 3 Apr 2018 15:45:45 +0100
From: James Hogan <jhogan@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, antonynpavlov@gmail.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] Add notrace to lib/ucmpdi2.c
Message-ID: <20180403144544.GA3275@saruman>
References: <mhng-e7e3dffe-bc80-4bea-8cf5-4d8afb76565a@palmer-si-x1c4>
 <4ba976ed-7294-18ec-187f-7105a9782283@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <4ba976ed-7294-18ec-187f-7105a9782283@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 02:51:06PM +0100, Matt Redfearn wrote:
> On 29/03/18 22:59, Palmer Dabbelt wrote:
> > Ah, thanks, I think I must have forgotten about this.=C2=A0 I assume th=
ese=20
> > three are going through your tree?
>=20
> Yeah I think that's the plan - James will need your ack to patch 2 if=20
> that's ok.

Yeh, I've applied v5 for 4.17 with Palmer's reviewed-by, but I'll change
to an ack if thats okay with Palmer.

Cheers
James

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrDk5gACgkQbAtpk944
dnqamg//R64Ip5J/m4tBbd+nw0V2HUzzGYqFe+K/+TSNn/pOo0zmqye1xNxuuPak
PUSH/3PgPeXkg/QadTi1DTxAIA8e9b5fyTX0H5OrOrTU3Ov5eQPrX/8tEoKd9j2H
49CibKK+A/VWrxnwYhEcJxeVDH0ELacXvYmhpjVpuaJbakJaHWj4x7ioTlPdPb6h
4juhWk0bIlrbt5DG3dxh5DVE+x45kbINMTMyGgIHt83JEzGfbPDV5k507b/5dGoV
Wxm/RlnclVKzwJsx62jF/WBu87c1G1dSZ8y8Q3vowRBuFExH3ic+OlMjNdh+VxtU
4jyrh3+EA2nON6INMKVqJOCvxcyd5v1yy0BnrjBUGebTaR1+UiiLDEbLLOe3uF+W
TlohkRBjTrnf9ODLmaBaGg1ccyeD/dM0jdpJryBddZF5H6x16XVPiAg2yGQli4rB
p7jY/k5qXAGVGHCrRZBd5l3c7TPYwPhdJwflRcLB7jjJK8qBP+Bt8itFtOKH4gF3
PeRv6/ggnRFV1EKPSgolAZOruA5ebsOjqAWIp8n+LDqcws0gkxhw1OsQfikMUb+B
zyI5yvI+WE6tHVYGYhKhb714ozpJ2wn4npmI/J1stXuy56gQnQ1Tpwfcu8eplio4
W3U99tJMe4adDlGtgBlGxTbXI/9nA3p0G/VKpgdX99c33i6txsw=
=Wr6i
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
