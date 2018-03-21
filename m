Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753968AbeCUWWR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 18:22:17 -0400
Received: from ozlabs.org ([103.22.144.67]:48163 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753744AbeCUWWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 18:22:13 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 22 Mar 2018 09:21:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@intel.com>
Subject: Re: linux-next: manual merge of the ftrace tree with the jc_docs
 tree
Message-ID: <20180322092108.0d821abc@canb.auug.org.au>
In-Reply-To: <1521665752.31081.10.camel@tzanussi-mobl.amr.corp.intel.com>
References: <20180321153127.23737f6e@canb.auug.org.au>
 <20180321153715.3a571e5b@canb.auug.org.au>
 <20180321091554.2b38ee57@gandalf.local.home>
 <1521665752.31081.10.camel@tzanussi-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jukMgl9Tr8iGmeWA19hTRO5"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jukMgl9Tr8iGmeWA19hTRO5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tom,

On Wed, 21 Mar 2018 15:55:52 -0500 Tom Zanussi <tom.zanussi@linux.intel.com=
> wrote:
>
> Yeah, linux-next has changes to Documentation/trace/* that converts
> those files to .rst, which linux-trace/frace/core doesn't have.
>=20
> I've rebased the inter-event patches to linux-next/next-20180320 to
> reflect those changes, which affect 9 of the files in the patchset.  The
> updated patchset is here:
>=20
> https://github.com/tzanussi/linux-trace-inter-event.git tzanussi/next-201=
80320-inter-event-v10                                              =20
> https://github.com/tzanussi/linux-trace-inter-event/tree/tzanussi/next-20=
180320-inter-event-v10
>=20
> I can repost the whole thing as v10, or whatever makes sense here.

Thanks, I assume that they apply on top of the jc_docs tree as well
(git://git.lwn.net/linux.git#docs-next).  If so, then I can use them as
merge resolutions, or Steve can rebase his tree (minus your old
patches) on top of the (hopefully unchanging) jc_docs tree and then he
could apply your patches there.

--=20
Cheers,
Stephen Rothwell

--Sig_/jukMgl9Tr8iGmeWA19hTRO5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqy2tQACgkQAVBC80lX
0GwUpwf9FLZBeLWijBIpDrFJxrpwmgOwLHcRWbL2y3tjl/oudJ0z8RQrm2JLBdP2
4yRubYErBOWW9C9qzJrncNmiGzy2dz29HgJ9QPlvQdk/30robC6iex7Y4oT1aYd/
BiqY9ZKG9IKEeKhNgo2JFboo16jIFp6juP7YWKOofL/i/cckfuQbMBx8jzB9Hfz4
CRiWSPR5czra7J6WtUninx1eUH6RZp2m6m9su4/mfpvxrCofygieigxBgTW24M5V
RNbJA0fyzLYe7Aw/rBDct9OKTa7QSA17BKhhyS/g69x4M53WULLrhaJtJRyaleMD
USAs+uP0wybMcpufAZIQGHztSfhQ3g==
=Yo4m
-----END PGP SIGNATURE-----

--Sig_/jukMgl9Tr8iGmeWA19hTRO5--
