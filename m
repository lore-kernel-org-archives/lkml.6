Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933340AbeBVQj3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:39:29 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:33399 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933164AbeBVQj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:39:27 -0500
Date: Thu, 22 Feb 2018 16:31:56 +0000
From: James Hogan <james.hogan@mips.com>
To: Graham Whaley <graham.whaley@gmail.com>
CC: Guenter Roeck <linux@roeck-us.net>, <linux-metag@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/13] metag: Remove arch/metag/
Message-ID: <20180222163156.GR29460@jhogan-linux.mipstec.com>
References: <20180221233825.10024-1-jhogan@kernel.org>
 <20180221233825.10024-2-jhogan@kernel.org>
 <ea057277-fc48-3961-681d-385023741cdb@roeck-us.net>
 <20180222072459.GA9891@saruman>
 <CAF9eJumRb0voffQXqWg5goO8=1KNpivrefLtLCUUh_4k6g7+JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hEarWVD7htqb1VxP"
Content-Disposition: inline
In-Reply-To: <CAF9eJumRb0voffQXqWg5goO8=1KNpivrefLtLCUUh_4k6g7+JQ@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1519317499-298554-21113-4677-2
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190307
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--hEarWVD7htqb1VxP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 04:19:31PM +0000, Graham Whaley wrote:
> >> >
> >> > So lets call it a day and drop the Meta architecture port from the
> >> > kernel. RIP Meta.
>=20
> Oh, and James, I meant to ask/note - I guess that just leaves parisc
> using STACK_GROWSUP... shame we could not ditch that as well then eh?

and just blackfin with the horrible underscore symbol prefix :P

Cheers
James

--hEarWVD7htqb1VxP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqO8HYACgkQbAtpk944
dnp2hg//bXoRP/0vRSK8srMvpz6hvn1lpnAsb00LuWlD0rFHaNpcAlQ/0z6edpgx
q6bzwuL1OZlojqXBJub8pAYbmo+pU1qvso1hNc3L0jyk2rNeVoiD11Jn1tG5PKYb
f7VEx6jil7wrHdEVHMA3EqSEjYbuZRErj8t3FXNHjfVzl3JlDr3heoh8oN+kFTMe
KHJq+i58/RLjW0AE2pEPC+Yx8YreoUWNLPg4nIJcAWus6p9p3BBCu8zPuCDBJ6uc
cCdcNTUpDGqCGf63KoN9qhb0dx8I6QctktTHqZbf+Y4klc4x/OIUP9Li2S4Uc6kR
zSpj/F6nwoXbscunkQTPZomTBW+ZNXlDqnZAU9K92SNFJpio+Km49J3RN0LpLB0p
s2ETa3nmVcqg38DFQhpiF1sAJdOr027EMRJ7nbHO3+EitE+iHxd7GLz5Ao44DMh2
DqvHm+rPvu1FoV9CcumsrfQ169H7oeh7G2DvW+pl82Czebh3TAW2G/4lL/UrtAb+
rZ10UnK6wTBElJfzJ9VEwQePi3+WFcm+Z69rQ/RZ2b64jccpk2Ex5zNcqBUv3lj1
G8hJ4pvfZaOkiH7xc0jmsFDWbiQ5YIfThTD7T5YgiIzD9dedS9ls9PrlzfIaM4Z+
/jstYv3R1kFkYMh2NfcMzd0TsyozNzAu1COc0Tt9Vkeg2B5dlog=
=i/xw
-----END PGP SIGNATURE-----

--hEarWVD7htqb1VxP--
