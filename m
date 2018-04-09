Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbeDIKXD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:23:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39730 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbeDIKXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:23:01 -0400
Date: Mon, 9 Apr 2018 11:22:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: jacopo mondi <jacopo@jmondi.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        a.hajda@samsung.com, airlied@linux.ie, vladimir_zapolskiy@mentor.com,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: display: bridge: Document
 THC63LVD1024 LVDS decoder
Message-ID: <20180409102244.GB11532@sirena.org.uk>
References: <1523018517-24121-1-git-send-email-jacopo+renesas@jmondi.org>
 <1664336.M7KDjLhzuK@avalon>
 <20180406142558.GP20945@w540>
 <2441543.5xTHaLXzZ0@avalon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <2441543.5xTHaLXzZ0@avalon>
X-Cookie: Professional sample - not for sale.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 06, 2018 at 06:40:14PM +0300, Laurent Pinchart wrote:
> On Friday, 6 April 2018 17:25:58 EEST jacopo mondi wrote:

> > Same on the mandatory/optional VCC supply thing. Let's try to make
> > next version the final one. If the optional property with the dummy
> > regulator doesn't satisfy you and it is preferred to have a fixed-regul=
ator
> > anyhow in DT I'll do in next version, othewise let's try not to change
> > it again. I'll just remark here that in the current Eagle design vcc is
> > connected to a power rail with no regulator at all :)

> I don't like the dummy regulator much, as it generates a dev_warn(), whic=
h=20
> makes me believe that it's a hack rather than a proper solution. You migh=
t=20
> want to ask Mark Brown for his opinion.

The DT should describe the physical supplies the device needs, if that's
a fixed regulator with no software control then the DT should have a
fixed regulator with no software control.

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrLPvQACgkQJNaLcl1U
h9Aqvwf/ciDfXmVqKQSvxMtmLhQMHUGmfRiXwnrhL+GeughyU+/cdRY39m4DlJ/r
l6SO9pxgy35Nafx9kK9N+SaJytNy/WI7qMqvEtO7Ekl0ySaCxVHDSz9EPIyV0C3r
+HJ8ZpLzBvg8Vxprv38qSt8rbwzuejiIsaz7wamIEwmY0QH650COYddR34+29EGq
hfwfseobZuIrHIBJ6o/bLV5js0xHiY68cXVAhSNWZK2RA935yVnD4mjWGakkvydu
7G55zw9GVulr11UYjP7XDamnkRVqS7WsHt9B0vge0oIXqyAXhWWhsx14GxsJyhpI
TNMbXD8PGAMasYAQ3cd+l0MgbD0dhQ==
=OXuF
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
