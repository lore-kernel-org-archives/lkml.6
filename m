Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8827CC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF8820843
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF8820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbeGKIdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:33:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40221 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbeGKIdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:33:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CF91720730; Wed, 11 Jul 2018 10:30:36 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9F358206F3;
        Wed, 11 Jul 2018 10:30:36 +0200 (CEST)
Date:   Wed, 11 Jul 2018 10:30:36 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, airlied@linux.ie,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 00/18] Allwinner R40 HDMI refactoring
Message-ID: <20180711083036.7attjq4hm5ay5gmn@flea>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yshce36do3zzws6q"
Content-Disposition: inline
In-Reply-To: <20180710203511.18454-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yshce36do3zzws6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2018 at 10:34:53PM +0200, Jernej Skrabec wrote:
> This series fixes several issues found in R40 HDMI patch series after
> it was applied. Conversation can be found here:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/586011.ht=
ml
>=20
> Patches are based on latest linux-next (next-20180710) and are ordered
> in such way that they don't break R40 HDMI at any time. Because of that
> I suggest that whole series goes through drm-misc to preserve that order.
>=20
> I also tested those patches on H3 to make sure it doesn't break other
> platforms. However, it would be nice to test for regressions also on
> older SoCs (with DE1).
>=20
> Best regards,
> Jernej

Applied all patches but the patch 10, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--yshce36do3zzws6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltFwCsACgkQ0rTAlCFN
r3Q4sxAAkIOSDcrUdytnfHPJ0n99IJRimkUTwMFyKEGTrYoyr6ODMxuVnO200zQ2
eudqI2vuHRhxkkDXeSq5LCyYqhI2aYEF6Efyg5k/nX6C1ySgCME2ExXSwCVfDn+u
MHBQn04IXTERwHeZT5RzBOd9Ys33YaYeDBNdzW9EL1sbAz55+wNT6Y7zxyOCeZV0
KDZpbExJY9Sc/FB7gu9XEvEuzsVpzNkaLlupqnTFHSbu8US5eRnRhqhXBFpWrJYH
I1SgzObx1/w7N5427O4QdmA4snjTQzozbWjgU0nnTeCYYAPbWS6uOk/oAGAcCY9c
B1G0s0fLp6EjyFQWj12iubS/6reDhz3Zg2Yov3/YK3SyYv83E91MFg+gg1RLm940
RcYoImg/n0JEHICYhduLKESrT2biwdAlLdUkOTXRckh2tADVByU/9q5cKcoP72KP
rGmMOICBJ3POaKiUcdk2Q8e+1Dy087d3XgbyoHke62Tfe8UUPOLOrttrCEt0J78+
vkCpF/n4stglxAQvXvlBXO3vx1WLHHuGs8R9QLAGV/9bM1cHo1doBirCaRr1i7pK
vTXLhJOarfDK9u6IVBZRY8fv1nREf+F7qBA6wdZOqqCadvtuQFJL9/NbSg8FmPQD
p5G+cfAUnKhENiHqzJy+O36sbIUqJTyejC5ZemhGyKNfLmwpxuM=
=Os8I
-----END PGP SIGNATURE-----

--yshce36do3zzws6q--
