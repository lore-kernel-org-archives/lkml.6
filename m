Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1ACC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC73620883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC73620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeGLHnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:43:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51649 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbeGLHnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:43:41 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 294682074F; Thu, 12 Jul 2018 09:35:21 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id ECAFF20618;
        Thu, 12 Jul 2018 09:35:10 +0200 (CEST)
Date:   Thu, 12 Jul 2018 09:35:10 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, airlied@linux.ie,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3] drm/sun4i: mixer: Read id from DT
Message-ID: <20180712073510.ssl43bjgv5n5mrwb@flea>
References: <20180711112706.30222-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="magllo6lzj3ubyto"
Content-Disposition: inline
In-Reply-To: <20180711112706.30222-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--magllo6lzj3ubyto
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2018 at 01:27:06PM +0200, Jernej Skrabec wrote:
> Currently, TCON supports 2 ways to match TCON with engine (mixer in this
> case). Old way is to just traverse of graph backwards and compare node
> pointer. New way is to match TCON and engine by their respective ids.
> All SoCs with DE2 enabled till now used the old way, which means mixer
> id was never used and thus never implemented.
>=20
> However, for R40, only the new way will be used. To prepare for that,
> implement mixer id fetching from DT.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--magllo6lzj3ubyto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltHBK0ACgkQ0rTAlCFN
r3QIvQ/9GJy/6VbdEIB5G8cBwr6VymXtqLu80RIQyzDApCSG/QTIGFrZ+1HKzyTx
uKIDFJQ1KMkAB5+sM7VjZyKTxpSC2mYZ9gZlpebKlJ12/QAG0lZ8DCNCMhdVmcxN
sdLAzdti4LXGpEm2prUq9yprrADgwYa9dO1zAAXBKHvLk92tZBeNh46m8PZKo8TI
7JOKJbK/CNi0f9yQX3vx97aGDb42xkk1uAwi5wuLNt/1wELcxTrXaEK5kZAKCWE3
6skWeKqBGGFcFwDRpO1Zx28hlTNn3UEBklKw7DdtH1rmI3dt0YyNqXjkOgCRESlu
g6llN29eEZyaLRI65FdPWSjWU/hhMoUceJ8b09B/8Tcifd2cu5yovyQFTc0p73hC
0UQCBOyqwwBSGNp6XTyCwv08IxOMKo4qM8UXjEpDKx03jp7sXxNK8sEeY/NhUk7y
cqJuHNdmPabdWTbwsa1Rq6gWP6r6mtyff12ZtMn2uwG33WvZfI4M2c7KU+fjaXOe
+NiEWju/QbaOmGKWY3ccpKKITdMgSduVKKaEsPLFIpEA27OVxRGcKo5J4p06PVkA
AefXN+8G0V++lD0gImAwxndeocYmyHwJgb0AEysP5XsrD3XRSw1vNbnOgQt5Jiwq
TDFLL8oIvJhM6raFzKXsfpRXKYdWDPfuR2lAg3KHfLQuhnIBTNI=
=k35h
-----END PGP SIGNATURE-----

--magllo6lzj3ubyto--
