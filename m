Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeDJA7S (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 20:59:18 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38697 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbeDJA7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 20:59:17 -0400
X-Google-Smtp-Source: AIpwx49tRHzXrhhBuVfK85bBjdX1tWNa4QdcTXQBRLuuvLeZ/EY7/vLwpqBYjPelyk+gmM5NIhH1xw==
Date: Mon, 9 Apr 2018 14:59:03 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Al Viro <viro@ZenIV.linux.org.uk>, Christopher Li <sparse@chrisli.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] add -Wpointer-arith sparse flag to toggle
 sizeof(void) warnings
Message-ID: <20180410005903.i5daqksatgdjvndz@gmail.com>
References: <20180407215805.ze5rx4v3slbjngmo@gmail.com>
 <20180408074823.fgrmtrjzzjb7dlt2@ltop.local>
 <20180409225101.uzztpdv6bbjmlwwr@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bsg5mfzz7mx7lthw"
Content-Disposition: inline
In-Reply-To: <20180409225101.uzztpdv6bbjmlwwr@gmail.com>
User-Agent: NeoMutt/20180323-62-378db9
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bsg5mfzz7mx7lthw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 12:51:01PM -1000, Joey Pabalinas wrote:
> Ah, so should I include that change in the patch itself when I make a V3?

Sending a v3 now incorporating the suggestions.

--=20
Cheers,
Joey Pabalinas

--bsg5mfzz7mx7lthw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlrMDFcACgkQruvLfWhy
VBnpOw//akqShmY9OFwstYUhMYeYNGXBJtypTqFD6rQ3TZoMCmMEz5jV1SB70xfz
qyzMYgShKokTiJoDgS+Z3lwqJEN3FHNt6b3pWu49QOwuHF44ZfOfkjRrJ2BXizGk
F1gUlMLY2BV3a138w+GVNNKfvK/qQyqLe50V0JN2PwuEiLeS1BNGTeawBHIegsz8
PjD3BxqNzGRZhaENVl++BqxGoUcwgOtONqgmQrxlwuR22/TtKt9Kh03Hf8AYRtx4
HgkbScqlnBHHcVgcAlkpTAQE5wA3d+w9LKpUNvYwUP+xuuEkV3SceAmwf0JMhaTB
+Jw7XcuJC+3xatJUMJ5RGKs2W1AcridWJupuaEFRtrOId1bEOtxBwl7vhAMAHUiw
JVFUcnn45cvX6dial+vWQrnnc1UzSxSdDyWzS9EAGbkQ1GmQV3CH/EdwCZCiLYHm
n0faUz46rJ7OHyPv2zNwlaucqpyT6GtAu1agnY/xLGZYt0HzxZBKyN0obKJM9Aj/
yT1x67/9xBA4z+1lhxWTNocHF5TTcSOq5QARt/7+JaWlRMJOh2xi5DLYCYoejDzP
dGHPF9BqCHtZHPjhpbtmKg/4BXpsWmKngSS4ONS7WMbj81K64yyNyth3IWzzdI8e
GDSt6mk0wFvf8etBSSe2w0r3wqkkqDWArLguLrzc2R+NeqEAnLk=
=IRo1
-----END PGP SIGNATURE-----

--bsg5mfzz7mx7lthw--
