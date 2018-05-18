Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbeERJ6i (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:58:38 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42183 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeERJ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:58:37 -0400
X-Google-Smtp-Source: AB8JxZr0FFx3W902DYUBZaNs7v0YtLN/uPS31U8bTjnEduOvENtdSiLChnNyRKZ6T0LUj6ZQe0scyg==
Date: Thu, 17 May 2018 23:58:33 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joey Pabalinas <joeypabalinas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3] scripts/tags.sh: don't parse `ls` for
 $ALLSOURCE_ARCHS generation
Message-ID: <20180518095833.kua6rcsrvz3vb4qv@gmail.com>
References: <20180518062553.kodjjrlrosrg7vfq@gmail.com>
 <CAK7LNAQaR6bLCL8cu4qbqB=oonr7kD_8XuLdG_ntRr_W_rfKUg@mail.gmail.com>
 <20180518093131.7g5m4mu3mtrgb7so@gmail.com>
 <CAK7LNATYiKYzD11anXzCqjWaqeezHo4R1db+qAdCAAJLkvuf9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zzglkc3szrlmlunn"
Content-Disposition: inline
In-Reply-To: <CAK7LNATYiKYzD11anXzCqjWaqeezHo4R1db+qAdCAAJLkvuf9A@mail.gmail.com>
User-Agent: NeoMutt/20180323-62-378db9
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zzglkc3szrlmlunn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2018 at 06:52:48PM +0900, Masahiro Yamada wrote:
> Why is 'paste' necessary?

Without it newlines from find are retained from the find
output (at least in bash when I tested it). Though it doesn't
really matter here since we are feeding it to a for loop, I
just wanted to be sure this didn't surprise someone in the
future by squeezing the newlines into spaces.

--=20
Cheers,
Joey Pabalinas

--zzglkc3szrlmlunn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlr+o8kACgkQruvLfWhy
VBn4ZA//TKTGyWObBezaEfvXe5c+b3vlCxcbZK4AKo/q/4PzRWHbHubMwxtOJTbu
4oFyIQk7BZ1P77dmAPFXHC/oTCUO+3QQCE0olvoaFeprLx3di6owAu43cvbSt4Tp
YxDeVyFFvUOhz0L422gvsiFJs9FY9QP+Cs+0t621ST4aoXH08svoIm8CWcIV5n6c
B6SUfbOaVjW9oYkunOI3RUn5Mm6BrUlW5TLgcEF+c2gWX4tNgarYq5ipXVNlHbYG
oufA9n6lsxF6EYgKTOlFiI5kMdFqsHUAf1svyZScsgk4lOa6RBjcjf98CtFXyL7U
E+g27idz8MUysXsbQUkMPQqzY9AbfC0KYgLPIbq6aI4cxFsEwcdyZK8ciaJwer/g
OqjmPYm9TqV3NYxa4SBlkRn3Xwmk9lXNnBSJ6mv0f4CJB9lRO6YQ4/a46HjvIZxq
lz/soSJbu7s7siAI7IBU9UQZqMxg+4ESNkl3lEa33t0paJ2EwgZdrkTmiv/8+uf+
IUoYuDHfycULgg2737xjCxKWr+q4Uw4BredkkfdRdL1m4SPR0bfLu7amQCNtr4Wj
yApkx6HWSxgnGFHUf05sNf4Lc8tEgBN2W1VgtkJMPwzumYuIbR56ycrvCVMNe2HX
4lSRe8Z+bI9L3uww84d5hbfSCpsVn39g/qV8ez6uHdeHElPSSIo=
=gjVE
-----END PGP SIGNATURE-----

--zzglkc3szrlmlunn--
