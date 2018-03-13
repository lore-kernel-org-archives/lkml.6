Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932575AbeCMUJ0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:09:26 -0400
Received: from ozlabs.org ([103.22.144.67]:52539 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751997AbeCMUJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:09:25 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 14 Mar 2018 07:08:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Kees Cook <keescook@chromium.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: Tree for Mar 13
Message-ID: <20180314070707.2d3c1807@canb.auug.org.au>
In-Reply-To: <CAMM=eLdZ6adSV6Q0JLkRi9k=7g5o4SEAyGfOm0P_nqw71Jbing@mail.gmail.com>
References: <20180313183326.0e93f359@canb.auug.org.au>
        <CAMM=eLdZ6adSV6Q0JLkRi9k=7g5o4SEAyGfOm0P_nqw71Jbing@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vP9o.KcDVRvvpOiZdHzSAhD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vP9o.KcDVRvvpOiZdHzSAhD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Tue, 13 Mar 2018 11:57:40 -0400 Mike Snitzer <snitzer@redhat.com> wrote:
>
> I had to revert the following commits to get this kernel to build
> (otherwise I got macro expansion errors, using RHEL7
> gcc-4.8.5-28.el7.x86_64):

Yeah, I reported that earlier (216 of my 244 builds failed - gcc 4.6.3)

> beb7eb2 kernelh-skip-single-eval-logic-on-literals-in-min-max-v3
> 19ff7e5 kernelh-skip-single-eval-logic-on-literals-in-min-max-v2
> c7c133f kernel.h: skip single-eval logic on literals in min()/max()
>=20
> (it wasn't until I reverted commit c7c133f that the kernel build worked)

I will revert those from linux-next today unless someone sends a fix.

--=20
Cheers,
Stephen Rothwell

--Sig_/vP9o.KcDVRvvpOiZdHzSAhD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqoL84ACgkQAVBC80lX
0GxZkwf/boqkV4EvJb9dYtrjCj7A6h4qnngIYqL1d7DdrPFXd1GqjBjiFfE6OIQ6
IZ4pFGWteIDAOASMA6ggHgysxFaRlCRdo9+/jPSBa2vs+I3qcVDyUUZdISjyY4TA
Hf73qp40p9rwTXLKkhjtp/3SMug9hWooyrAAkyICV8dMLT8nxYoHAyAbOKxIvFXx
1f8hGH3SwFPUicfZXetIfRbl0ZfYUUnh/t+FpnIF+6Oqm+bxaTPgmYVONpNRi42G
+ZtCRAjfe6K6MPBbUXNZSpQmvZPsYdgF8Q2n3JaBDD3p3o6mAEoR7cz/fOcPjmVK
eiH/IH58iCXh3jZ8nClgiNROzqQHFA==
=AMIk
-----END PGP SIGNATURE-----

--Sig_/vP9o.KcDVRvvpOiZdHzSAhD--
