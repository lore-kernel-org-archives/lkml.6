Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeECHPy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 03:15:54 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59611 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeECHPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 03:15:52 -0400
X-Originating-IP: 2.224.242.101
Date: Thu, 3 May 2018 09:15:39 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: ysato@users.sourceforge.jp, dalias@libc.org,
        thomas.petazzoni@free-electrons.com, robin.murphy@arm.com,
        geert@linux-m68k.org, sergei.shtylyov@cogentembedded.com,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sh: mm: Fix unprotected access to struct device
Message-ID: <20180503071539.GA19612@w540>
References: <1524044555-20610-1-git-send-email-jacopo+renesas@jmondi.org>
 <20180502074600.GC27261@w540>
 <20180502123909.GA9546@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20180502123909.GA9546@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Christoph,

On Wed, May 02, 2018 at 05:39:09AM -0700, Christoph Hellwig wrote:
> On Wed, May 02, 2018 at 09:46:31AM +0200, jacopo mondi wrote:
> > Hi again Christoph,
> >
> >     The gentle ping actually applies to this version of the patch.
> >
> > Sorry for the confusion.
>
> I'd expect this to go in through the sh tree, but if the sh maintainers
> are fine with it I can take it through the dma-mapping tree.

Oh, that's fine then. I'll let Rich comment if he plans to send a pull
requets for v4.17 fixes or not.

Thanks
   j


--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJa6rcaAAoJEHI0Bo8WoVY89iYP/jPTuCaXIzhScnXmAedpdgFB
8VP2yJmji6BIIOpF0jaICjW3yByUgLi/pRFkiF66RA6IC9nIVRmBfe5xSr73YLJZ
PdxvlSCbRUa3V0q0GXS2FI/fkzRsApOe6XayYd59TPqko5elTHw31cDEPEk7tiTW
OcsTdLC7w36UX9Nfjy+v2ck9aOupwLXMAP+FAeY7/jS7ULKwiXWSlD6rsuXOemAb
USDoKD8lFqj7Q+bOzE56EcA1n2qHFOoP1+e1VePk/RPOvK1pxrVbk/YDkqAVAQw9
Yu027S/sahZEADx+5ZetQMsIXfMoZO621yQ1hYJiQVBlbUshpuIx36zOEje0p9Wi
8jsTpAhRGAzd8jd+dE9BZ8qk8HIPr0j8jZokRrkCkdg0tnh3LsdSCCHN8lP5O2ap
qsAqKdPJyNrRfpNCSDXbt/vTJPNZ/Y23gdKE4/GKsZoijyHCmpgjUfEGwRawrL+N
W4aEeW58+D/Bmw81yazNys7elEfOfaplKdmOrYP9zwVbIWilj36WlGmV6oSjNltp
+itagpj/7bvnCtpR6P4aIZLPihdYGnhUgf2qFcCqpqJCm0b3DB/XFbvtq8ESoTYu
kZM17sPUXQG55BVl5L9z+o6VXTXtP8BJNvZIYXnJ2QRorhxTA6PD0sSI8SRQTYMu
/BBst4PDHy8BDoiVfiVG
=Pt0o
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
