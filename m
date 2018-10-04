Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F51C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D582084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D582084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeJECcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:32:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50962 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbeJECcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:32:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 54EE7207F3; Thu,  4 Oct 2018 21:37:27 +0200 (CEST)
Received: from localhost (LFbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.bootlin.com (Postfix) with ESMTPSA id 27F2F206A7;
        Thu,  4 Oct 2018 21:37:27 +0200 (CEST)
Date:   Thu, 4 Oct 2018 21:37:27 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the arm-soc tree
Message-ID: <20181004193727.qci3puitpxml26m5@flea>
References: <20181003072140.7c18d772@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ip7sy5d7luuc7gsk"
Content-Disposition: inline
In-Reply-To: <20181003072140.7c18d772@canb.auug.org.au>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ip7sy5d7luuc7gsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Wed, Oct 03, 2018 at 07:21:40AM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Commits
>=20
>   6eeb4180d4b9 ("ARM: dts: sunxi: h3-h5: Add Bananapi M2+ v1.2 device tre=
es")
>   80c21c8c8b8d ("arm64: dts: allwinner: h5: Add device tree for Bananapi =
M2 Plus H5")
>   aa8fee415f46 ("ARM: dts: sun8i: h3: Split out non-SoC-specific parts of=
 Bananapi M2 Plus")
>   db9fd9d13e30 ("ARM: dts: sun8i: h3: bpi-m2-plus: Fix address for extern=
al RGMII Ethernet PHY")
>   6c700289a3e8 ("ARM: dts: sun8i: h3-h5: ir register size should be the w=
hole memory block")
>=20
> are missing a Signed-off-by from their committer.

I just sent a new PR with the SoB this time (and I just learnt that
git rebase rewrites the committer...)

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ip7sy5d7luuc7gsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlu2a/YACgkQ0rTAlCFN
r3QSjw//YOXotRZpSpj9K1oCDqe2GxKumPai06ik3zbDbA58SHeB3zCAiFQufcC/
vhAqaaOJYu/1/nF7v/pa9eTlfDCKPDpGHo3RT2wrmFYffwH94icRL6BZF16aBqPs
qWQa4CdsdEEXcHTg7oKW5aFPdIIbfXVkkqzXHo3xkW/K+Dc1+gW9S4p3jG6Mkn2r
G8/UPaFLNUGrXRYcGgD0vTXx0BbVYcTqnKW3m/AbmVNnO2j9H2+IaOpCgSthaxK2
o4SW4r/So+cqfsS1U5df9eLpx5DR4D5p8JSxZNvlAqxeUr3eEoxiddM7iUPXsXEf
rlHvuHH48UaO5pPNkGKBFrH7SSI+skAo6hFX7vouQLiFUBVkTW+DrLEtr7rzDCQv
2DP4f/xXXSH0qUTQ1jtJ6dsoiiqfLPeu9q2iBQIw0hoZtbMfX83gkiKfGWvWwc8O
3CPLV/rStO7bELzwTZ8BNMQkSqCEBAPK86exzw/yh+CigPpReg0rbTujRd05sTb8
4tMTbjcZkxXTEanXBwRKTfe8X5hPpK+4j+oT5No9u3vhYivrYiw/TOiz8pHOtGzj
EXV0mF9ukwJ4Jj2Zy+wduw8ZTnIUBTF/RViHPyfJTzPHMtYWw0Ccr3oMgI/YOb4M
sCHv0huAYJdDl1Jn9VK989f+mkcO3cN0PEKV2MTrduApRdWnjWk=
=UvdW
-----END PGP SIGNATURE-----

--ip7sy5d7luuc7gsk--
