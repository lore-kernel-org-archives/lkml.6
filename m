Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFD0C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9747523C1C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9747523C1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965871AbeF0SZD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:25:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50036 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964840AbeF0SZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:25:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 897E820798; Wed, 27 Jun 2018 20:25:00 +0200 (CEST)
Received: from localhost (unknown [88.128.82.6])
        by mail.bootlin.com (Postfix) with ESMTPSA id 48400203B4;
        Wed, 27 Jun 2018 20:25:00 +0200 (CEST)
Date:   Wed, 27 Jun 2018 20:25:00 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, paul.kocialkowski@bootlin.com
Subject: Re: [PATCH] drm/sun4i: Implement zpos for DE2
Message-ID: <20180627182500.eanqagmcfmsgzos2@flea>
References: <20180627164514.4777-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibmq7egszrckfcfj"
Content-Disposition: inline
In-Reply-To: <20180627164514.4777-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibmq7egszrckfcfj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed, Jun 27, 2018 at 06:45:14PM +0200, Jernej Skrabec wrote:
> Initial implementation of DE2 planes only supported fixed zpos.
>=20
> Expand implementation with configurable zpos property.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Thanks for that work. I guess you should expand a bit on the exact
setup you're doing here.

Are the pipes working the same way on the DE2 than on DE1, ie does the
pipe blending applies before the alpha blending, and therefore you
need to make sure that there's not two planes with alpha going to the
same pipe?

Also, you seem to use the pipe and channels indifferently now, why is
that?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ibmq7egszrckfcfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsz1mYACgkQ0rTAlCFN
r3Qo/A//RP//9oWoTcxBZr78KtR+A57GeBFu8tBVLM4Uskz0ZX5X3ZCeoEX3GteG
+TQRKMNiwdceDfZWumE7g/cRB+vF3C19uGONmMwVKZoWzJnMGu4LwSId/OzeGttS
tRQU1hoD7AWqnPJln1Kr9ZkjUC72R4qlp5tpTeBO2fzOq1HjAXRxwYAX0evxcwwL
w0tzFo/twITTtET7ZAJY1GRN18nvT17gEEfMnYyDo8byTfPUr0tr36tjv1W2EnKq
W++sKQozceK3rsTbBysta393V/DKXaaJCbtp9ox0r8aYWTmrXfHj7QbG1JywJAPr
N+2cHTZYz8A0XKtDCir4+HBPe3daaRDEQmRGLgZsV790FvEmuSRZLpiHqYS912Aa
n6fsYthi2dwZEwxAFbtefD8sJAaH4hI57GlpjJv1qH3wYHjm9h4b0zk0J4WpYy8V
wOnQT7XuMuL1zAWWa+b/hnD1nKfZDz9ZQPeF4FwoRdTcy1Hg+ZX0gupXEUXLTlZD
MrafWpqpYwiCcUNWf4haHd5GkB42oW7DSgZ66Q10A/VPqR9Khzk1IZI9JkRsRU+A
9H2ZezZeMs2lSrGlTfZSWxKVWFpTzox06gfAqk4MzlDp/KMeiFDJBw7CxCSXzaLd
fWSY46brQGg3eow9Bpkiik5lXEHQyKqMTP9U/wbrcQUidiz3XzQ=
=y0tS
-----END PGP SIGNATURE-----

--ibmq7egszrckfcfj--
