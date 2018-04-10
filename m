Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752908AbeDJWZa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 18:25:30 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34343 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752878AbeDJWZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 18:25:27 -0400
X-Google-Smtp-Source: AIpwx4/eYvrOpMME8QdDxdYuv0wqahXBqupsE7bKMnae0Shwv4QwN9UwOdtyZfv4mXX0YY/az7NgcQ==
Date: Tue, 10 Apr 2018 12:25:23 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Al Viro <viro@ZenIV.linux.org.uk>, Christopher Li <sparse@chrisli.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] sparse: add -Wpointer-arith flag to toggle
 sizeof(void) warnings
Message-ID: <20180410222523.6vart7pch3zkhywq@gmail.com>
References: <20180410010204.qeudkkru4jilun3v@gmail.com>
 <20180410194117.ei4eo3kaxvv2ezdx@ltop.local>
 <20180410220944.vnpzmugf5xbdsnpl@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ruzuhg4w35nttn6s"
Content-Disposition: inline
In-Reply-To: <20180410220944.vnpzmugf5xbdsnpl@gmail.com>
User-Agent: NeoMutt/20180323-62-378db9
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ruzuhg4w35nttn6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2018 at 12:09:44PM -1000, Joey Pabalinas wrote:
> Not a problem; I will rebase it on the v0.5.2-rc1 tag and
> take out the function pointer test-case.

Sorry, I meant v0.5.2, heh. Sending the v4 now.

--=20
Cheers,
Joey Pabalinas

--ruzuhg4w35nttn6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlrNOdMACgkQruvLfWhy
VBkDIRAAj3RUdUdyzgqORR6/UZYK8uAmF+Kh9kABNhPEuM4vXEDeWoNraZjW7rl9
UpTb7ctIxwf4m6oi/XzoeLuVKGjW53jsnPwOLidzPh+uq1P4tVr4Wx9201e3elWt
I8hc/f1FuMgMB7BDx1IOK64Hy3EfRcFPIfAcVNM1GitKfwt5I+gxIH5W/bHbi2bq
daXqfYf7gq9PyYXfICONfWevZYucZZNBeDMaaomEHf09F2GoZ3TmsTUgD1ROlh9t
QgksPOOGqTKO/YviMI7CVM2+YOQhjZ8+bU2G7dkbi8u+nLxbldZpIckFgDUIcXKV
/VLfzzCl5ldpPmsLMMrg/x6rQpcoBrdNk9+4VV9D41qkYP08cwHwtDzavAc9Lts9
+lwHWjzmE0yCA3IwUqrvRPd/iroet7rn+kqKt8tT0tobgN8dGRkz/b/vaBIqJaCC
c5oBw9zOZNFCzlTK/isM/qgkEWZBa3b+XATxFh83CJep8hYBIddX4u6ZKUTVIDwK
j4mOPd5lgPqj7DGHD1LOMeLr5yGGWMe1YCawr+OYjsQTva8aLWffqwsTQOECEVNL
HPZS3nl5qBUk/pW4AWuQDITz8nTGETSl1zbbo6r6UEldCBHBGCnk9nGCRsPBVWUZ
u5O+14K4iGf/gWwrfvzTkYTtXGua8EEsUkljBXnClt+GdM7Uvo4=
=vSny
-----END PGP SIGNATURE-----

--ruzuhg4w35nttn6s--
