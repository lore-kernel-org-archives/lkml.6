Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756146AbeEIFSm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 01:18:42 -0400
Received: from ozlabs.org ([203.11.71.1]:55051 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752931AbeEIFSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 01:18:41 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 9 May 2018 15:18:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nipun Gupta <nipun.gupta@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-intel tree
Message-ID: <20180509151838.57e4ee92@canb.auug.org.au>
In-Reply-To: <20180509050855.GA18469@lst.de>
References: <20180508110716.53dfef41@canb.auug.org.au>
        <20180509150255.38a5b1cc@canb.auug.org.au>
        <20180509050855.GA18469@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XRnlTC/evD+l.WOoYq0IUaw"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XRnlTC/evD+l.WOoYq0IUaw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Wed, 9 May 2018 07:08:55 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> FYI, because the dma_configure change touch so much code and the author
> wants to base more work on it it actually is in a guranteed stable
> branch with just those patches:
>=20
>     git://git.infradead.org/users/hch/dma-mapping.git dma-configure
>=20
> Gitweb:
>=20
>     http://git.infradead.org/users/hch/dma-mapping.git/shortlog/refs/head=
s/dma-configure
>  =20
> Feel free to pull this into the drm tree.

Thanks for that.

--=20
Cheers,
Stephen Rothwell

--Sig_/XRnlTC/evD+l.WOoYq0IUaw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlryhK4ACgkQAVBC80lX
0GyZ8AgAlAMkgL3YTcT00SEp9PVOcRJHhqkdIlaAkJZ6Pv0ukwg6Ot6wn7CeIVPE
3QItx8SOpt6sBWB0g1ZPMbp0+OJxA5BObRZyATSGlc7ZXf6bSgPy6jCh3cZBesYX
UGlDczeqTFFY2X5l6M+PrmXQhXBQ2eYNstEsQMDyTKPRdiy18VKUX2Cu6Kuqir2A
zc3AslKRf1OoizcJVCz4Bhpig2CGzKmUljaTroa/VpYw5tOsGnXZr9JgpY1r6DJ1
6MeADa3kC2DxasTYUp7NETpe79K0IHDbbn0VqxVZNuIWEBLTSzc4mFRrFhvh9mbz
FPE7Hg3L+JJ7Rq+0oMd56BJpT4pSuw==
=wEKk
-----END PGP SIGNATURE-----

--Sig_/XRnlTC/evD+l.WOoYq0IUaw--
