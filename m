Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932563AbeE3XsS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 19:48:18 -0400
Received: from ozlabs.org ([203.11.71.1]:44537 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932408AbeE3XsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 19:48:17 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 31 May 2018 09:48:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Charlemagne Lasse <charlemagnelasse@gmail.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: checkpatch.pl: Perl regression in "improve patch recognition"
Message-ID: <20180531094813.7bb6ef84@canb.auug.org.au>
In-Reply-To: <c04eb59fdc916202875cd01952d944d876569196.camel@perches.com>
References: <CAFGhKbzv9mTOv-cttiyDLNSx8Sc-QiHCVfrAtsa+PcGGOW2Wog@mail.gmail.com>
        <c04eb59fdc916202875cd01952d944d876569196.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vPo1pzsKwyfG+oBMwosXr++"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vPo1pzsKwyfG+oBMwosXr++
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 30 May 2018 09:49:12 -0700 Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2018-05-30 at 18:25 +0200, Charlemagne Lasse wrote:
> > Since the commit 9dd0c31c6cc0 ("checkpatch: improve patch
> > recognition"), the checkpatch.pl in linux-next is only printing a lot
> > of error messages when started (with and without arguments): =20
>=20
> https://lkml.org/lkml/2018/5/29/932

I have added that patch to linux-next for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/vPo1pzsKwyfG+oBMwosXr++
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsPOD0ACgkQAVBC80lX
0GxF4gf8D6+l87zK1MKaUw2cgNshH1N/RtJNGsK2lm+VCh7WMceiDurKnGCNv22z
eVduINcpr85F0y1aVUDrl/LBEqxUhgKzk7NqRFq/T0dxYW3BdfB5pbNuX4lKo4Iz
RqzOxwHVTk+9Nlenc/kOPwdzn4psLEdjBucuIlhHaTbFzhUmYE6EVqtNjB228n00
088KTSfU4jSMm8bcnyXSTE+c1XzXdbNGOprcK5pFPsus8jAeTSQkNFOyYYT0aTf5
0+uWYdReEJzeThfxi4hGG57RIPYi+bjExU4T+FSyPn3//WBWBNvmVe91dCMuOdPr
ZGmJRDzwxs7kDRfZiP17zr8/xLNjpw==
=iZU2
-----END PGP SIGNATURE-----

--Sig_/vPo1pzsKwyfG+oBMwosXr++--
