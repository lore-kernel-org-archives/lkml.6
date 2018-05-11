Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbeEKMr7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 08:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeEKMr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 08:47:58 -0400
Date: Fri, 11 May 2018 13:47:53 +0100
From: James Hogan <jhogan@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: VPE: fix spelling mistake: "uneeded" -> "unneeded"
Message-ID: <20180511124752.GA9014@jamesdev>
References: <20180510165900.13733-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20180510165900.13733-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2018 at 05:59:00PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Trivial fix to spelling mistake in pr_warn message text
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

> -		pr_warn("VPE loader: elf size too big. Perhaps strip uneeded symbols\n=
");
> +		pr_warn("VPE loader: elf size too big. Perhaps strip unneeded symbols\=
n");

Applied for 4.18

thanks
James

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvWQ9wAKCRA1zuSGKxAj
8hZHAPwOzorxqzdhC0mAmwifelQKD5g4nHGCxd6ieKGXdNWW+wEAwuNvsZ5g325T
Soc3Jo1u4U5SIZr1VuYiu/RHB85Vegw=
=kRJ6
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
