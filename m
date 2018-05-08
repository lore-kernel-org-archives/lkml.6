Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753685AbeEHAVL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 20:21:11 -0400
Received: from ozlabs.org ([203.11.71.1]:35153 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753660AbeEHAVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 20:21:09 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 8 May 2018 10:21:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: Re: linux-next: build warning after merge of the netfilter-next
 tree
Message-ID: <20180508102101.768d5c52@canb.auug.org.au>
In-Reply-To: <20180507105519.1d34f19e@canb.auug.org.au>
References: <20180507105519.1d34f19e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DRyahoiRLh3pKKmFXe7CPkb"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DRyahoiRLh3pKKmFXe7CPkb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 7 May 2018 10:55:19 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the netfilter-next tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>=20
> ./usr/include/linux/netfilter/nf_osf.h:25: found __[us]{8,16,32,64} type =
without #include <linux/types.h>
>=20
> Introduced by commit
>=20
>   bfb15f2a95cb ("netfilter: extract Passive OS fingerprint infrastructure=
 from xt_osf")

This warning now occurs after the merge of the net-next tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/DRyahoiRLh3pKKmFXe7CPkb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrw7W0ACgkQAVBC80lX
0Gx8WwgAoQEm9540+l+yDdKza3hAvDXzRRnaA5Ie/W9ttfsz2xjbBgrV3nax1pZq
tfi5UmrnoBicN9bpCCQ8AWFXQhqim5KhePVU3LfCCyHSwcOlJbOSnda6aAQxVrhN
3LdEWFbLdQilRpJb7+FbacLmLTbU3y6vbwMe13pemB+m/F9lLH+sLdXBjW7ADWv5
/ZDI3TJ40ynmjBGOfjJHTuQaKktZDNuDQXOMcoOz110jK4LU1y1LSV743iB3CnCD
DZD1h8+bqaCCELhhtFsY13p5ESjRPixh2wd+QIIlJ66emH3nWr7sDYKohFd/f2h6
2y3EXvPS03/Rj4K+SsAlte2/liiEpg==
=t49L
-----END PGP SIGNATURE-----

--Sig_/DRyahoiRLh3pKKmFXe7CPkb--
