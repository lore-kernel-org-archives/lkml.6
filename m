Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932163AbeDWQ5N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:57:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57198 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932085AbeDWQ5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:57:07 -0400
Date: Mon, 23 Apr 2018 17:57:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] regulator: bd9571mwv: Add support for DDR backup
 mode
Message-ID: <20180423165702.GM19834@sirena.org.uk>
References: <1524057484-25350-1-git-send-email-geert+renesas@glider.be>
 <20180420074914.vl4rer5zdeldfzb3@dell>
 <CAMuHMdWeROfJNvUtfooN8gqA+nTRXhVLvQFpc-xiqUbG9XgcmA@mail.gmail.com>
 <20180420085826.4omlf2rrwuno3mtj@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SEFvVLxbW/dEDtN8"
Content-Disposition: inline
In-Reply-To: <20180420085826.4omlf2rrwuno3mtj@dell>
X-Cookie: I think, therefore I am... I think.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SEFvVLxbW/dEDtN8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2018 at 09:58:26AM +0100, Lee Jones wrote:
> On Fri, 20 Apr 2018, Geert Uytterhoeven wrote:

> > Alternative, as you've already supplied (some form of) your Ack for the firs
> > 3 patches, they can go in through Mark? All of it is enhancing the
> > regulator part.

> Yes, that's fine too:

> Acked-by: Lee Jones <lee.jones@linaro.org>

I've applied them, let me know if you need a pull request.

--SEFvVLxbW/dEDtN8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlreEF0ACgkQJNaLcl1U
h9Cmbwf+PK1gWYHB1N11I6mVp6+02nsMl918pmBAB+MYSp0mMP9W8Ql963VL2ePO
+XgeEe+IjNdlv1BGUZSf/rMTYxSG52deDs4EL4h525xxDtJaBRSSATvicv67ncFo
garmhMAGkkeCaUWQ3JzLyWTWt3nUrSuA+FDqq9DNQomnN+H8NPHeipTDRbiW9o4L
J2QgG0I19SdrV9p15TvmMyRq5cRAJ3aDYe67c1/lP9QmvcAoGXklJxGQ8hfj+Jzw
YNOaN27/DqMya/o+/di6aKa2Y88R0g7GWAtftz0Eexl9TGe4v4KedH/EbEsLTQHb
vYN/EFy4WtImnNWD+B3HNamExDo4zQ==
=DFY0
-----END PGP SIGNATURE-----

--SEFvVLxbW/dEDtN8--
