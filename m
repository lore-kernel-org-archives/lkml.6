Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753100AbeCFDLt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 22:11:49 -0500
Received: from ozlabs.org ([103.22.144.67]:49995 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752480AbeCFDLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 22:11:47 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 6 Mar 2018 14:11:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Herring <robherring2@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the devicetree tree
Message-ID: <20180306141129.17edd0a9@canb.auug.org.au>
In-Reply-To: <CAL_JsqL_BSY5Xr8xS+mz_k1eVVaScPZVDE4UpdnV-vQwKhKc+A@mail.gmail.com>
References: <20180306120511.1b480c32@canb.auug.org.au>
        <CAL_JsqL_BSY5Xr8xS+mz_k1eVVaScPZVDE4UpdnV-vQwKhKc+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/98wXG95qUazi3ODtmvuuIFL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/98wXG95qUazi3ODtmvuuIFL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Mon, 5 Mar 2018 20:34:46 -0600 Rob Herring <robherring2@gmail.com> wrote:
>
> Yes. I've sent out patches for all these. Waiting for various
> maintainers to pick them up.

Excellent, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/98wXG95qUazi3ODtmvuuIFL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqeBuEACgkQAVBC80lX
0GzIrwf9G5wDis2mXdtNZkizHRU/UuE9/qbrnrnwh78tl+G9MvRb85GnAM1vhBv4
xpyFQc2TKzJzdCYn/DJTh5L9ZIiD0N03009snzJguzPnuA03WycAUFnntOCBG3wG
MPzABsuy/FmVXr1Jz8BSX/KmYW1Mz70I2tH6a06aQEFLcHqCD/L/Iew/Yviiumth
LwfPQV80dRLfzF6lGDuAYkUD7gVztc2j8btxkSZ2fTO4Pj2bqrIPnTBeb06ao+3w
QSGYFtIzqhgrwRs7Px4QRFWpOcQNzJt6lHtLLnLo5msnvIJpqPsZYumh4iMwiBC/
k4wscGLAo0nF3enXH712KPzx/ty8Sg==
=044S
-----END PGP SIGNATURE-----

--Sig_/98wXG95qUazi3ODtmvuuIFL--
