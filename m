Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeDZEyX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 00:54:23 -0400
Received: from ozlabs.org ([203.11.71.1]:56933 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750760AbeDZEyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 00:54:21 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 26 Apr 2018 14:52:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Evan Green <evgreen@chromium.org>
Cc: agross@codeaurora.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>, groeck@chromium.org
Subject: Re: linux-next: build failure after merge of the qcom tree
Message-ID: <20180426145255.0141300e@canb.auug.org.au>
In-Reply-To: <CAE=gft6e6wo1nj+Rw5=f+UXxhx3Hof7Nt=E9+-OAzvvv8Gct1g@mail.gmail.com>
References: <20180426084041.5cf81918@canb.auug.org.au>
        <CAE=gft6e6wo1nj+Rw5=f+UXxhx3Hof7Nt=E9+-OAzvvv8Gct1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SOXE.hkvNdgGH/L+LqXa.X."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SOXE.hkvNdgGH/L+LqXa.X.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Evan,

On Thu, 26 Apr 2018 03:39:25 +0000 Evan Green <evgreen@chromium.org> wrote:
>
> Guenter and I had a fix for compile test here, which had failures that
> looked similar:
>=20
> https://lkml.org/lkml/2018/4/18/752

That looks like it could very well be the problem/solution.

> I was hoping to verify myself whether or not this fixed allmodconfig, but
> my machine at home is not so fast, and I must be missing something, either
> in the configuration or the tree. Which tree exactly are you building?

I was attempting to compile my partial linux-next for today after
merging the qcom tree.  So once I release linux-next, it will be commit
a72d0aa48d2e ("Merge remote-tracking branch 'omap/for-next'") plus a
merge of the qcom tree
(git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git#for-next
- which today meant commit c78d6951a806 ("Merge branch 'soc-for-4.18'
into all-for-4.18")).

I suspect that just Linus' tree merged with the qcom tree would have
been enough to cause the failure.

--=20
Cheers,
Stephen Rothwell

--Sig_/SOXE.hkvNdgGH/L+LqXa.X.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrhWycACgkQAVBC80lX
0GyXTwf9G4O54ZmKheXsNx6bOBbYRi2EVAVoCg1rAn8+iD58jh4u4QhT4not62+r
g+jtNyeiXbjF+JGDw4jBgesgpE+6R9SOE0/UjM0TK7w2KHPCt73cIHKN3dqGyqXb
vYf/TpvAEdnuJogyuSBgjb2c8wEAlXGwX15t3JDt/Fk78vbEGc23p+Q4v7kO4eyd
E97m4KxeUsUAADGS9xHe823UJoICTfGVoFGKNUxNkG2xZFZuXPnQhrFrekVSSGUz
s9755rahN+OUcKMCknSFGd3ypgEwuRj3EiBKK+E4CBPINCmkdfTzKw6PWI0b9O6f
L1PzK8vLS0UXYrSDGcOWS72UX5MLeg==
=k6im
-----END PGP SIGNATURE-----

--Sig_/SOXE.hkvNdgGH/L+LqXa.X.--
