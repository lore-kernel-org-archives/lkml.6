Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428840AbeCBOy6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:54:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423277AbeCBOy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:54:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 883E82133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Fri, 2 Mar 2018 14:54:50 +0000
From: James Hogan <jhogan@kernel.org>
To: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Carlos Munoz <cmunoz@cavium.com>
Subject: Re: [PATCH v8 4/4] MIPS: Octeon: Add a global resource manager.
Message-ID: <20180302145449.GB4197@saruman>
References: <20180222230716.21442-1-david.daney@cavium.com>
 <20180222230716.21442-5-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <20180222230716.21442-5-david.daney@cavium.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 03:07:16PM -0800, David Daney wrote:
> From: Carlos Munoz <cmunoz@cavium.com>
>=20
> Add a global resource manager to manage tagged pointers within
> bootmem allocated memory. This is used by various functional
> blocks in the Octeon core like the FPA, Ethernet nexus, etc.
>=20
> Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
> Signed-off-by: David Daney <david.daney@cavium.com>

Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqZZbkACgkQbAtpk944
dno0Qg//baI4uYcIrHAIINLd1Uv82DzJaQTAwxh+SwVUxMANY3aMdyRfCwbsBrHK
xmLvwGTpxrZK7MMtecr08sf7wQX9CZz738EyBRU9fe9LaYlBVS0gh6PofqJEIN28
DzAfQoEjaCk6uwnyjwOPR2GIv870Nk5Y6fIYohfUagpKOn6nhcaqGoUZrradgpzx
JGpdQPxKylu6Xeg71kZ5bibj7cPBkXITXFKto3gTlh1kLbjynxnRJnN8BzPcyjIf
XdLSEiPLE3+8ytlwTai802DCSFkZwyYfJLfpwkLwtcEbftFLxpbcglINu8pzDTUV
E7iefzVVC8EZXZwFG5fxJcCxSH5pRo65LGMM2c9KDIeZNeWGGLg3FQ0Bv9kQ7boX
7QeVAguGRbFIBqaVy9wLTchCly3lHtCMAw4BM3D/mpFhHOT/uS6tvRO2LxX80NFd
GD49JjZ8sZGpJ7RdzPzYy9w22SXuyt8BzKuPY+IuQgXVTU6ndm8X0dkW9D+Vok+Q
zVBzsEBiygLi2xP2m/Ikqv7reZZP3WOwohu1UFCjHPxvyNcSH43D4IyiAM5cpDTb
mr+Z8GmRvMYPWQI8DMzI34jKyvneMaDoUr0GyR66LjB6ahC02XWi1UK6890xg++2
baIt3Zjn9zgE1ovkKcFRPTN/HCMy1bx6MVVZVoY01qP6g0bAesc=
=l4I2
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
