Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD68CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B4720870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B4720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeIJQhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:37:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35946 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeIJQhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:37:03 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 827EC208AF; Mon, 10 Sep 2018 13:43:22 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5064B2079D;
        Mon, 10 Sep 2018 13:43:12 +0200 (CEST)
Date:   Mon, 10 Sep 2018 13:43:11 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH RESEND] drivers: soc: Allow building the sunxi driver
 without ARCH_SUNXI
Message-ID: <20180910114311.6fw3iwend3js7mcf@flea>
References: <20180909190439.20425-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mulrknomt5awd4ni"
Content-Disposition: inline
In-Reply-To: <20180909190439.20425-1-contact@paulk.fr>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mulrknomt5awd4ni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 09, 2018 at 09:04:39PM +0200, Paul Kocialkowski wrote:
> This makes it possible to build the sunxi SRAM driver without building
> for the sunxi architecture. This allows selecting the driver when
> building the kernel in testing environments.
>=20
> In particular, this is necessary for testing of the Cedrus driver, that
> selects the sunxi SRAM driver.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mulrknomt5awd4ni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluWWM4ACgkQ0rTAlCFN
r3R/MA/+Mm6LNj2t5iEQ+j2KBeIhsvnNjSKRNK74T/Ls95hfcFbIup6Zhar0zlgz
Zw/aLZP2B4yOc0AllpynuAtIAytA3L1NOocGrcPQlXZcb0JPViYo6Y0GhaSjoRZh
fEzQcTPudq5j3xD9AHs0aPAtJbhOrTmFVl7LD4T5cgl/BfPW3KKFRIboMLRN/Lxb
UbyMFWHgCkNSVLQkB7m6a+zk9fPk6iN+JinqBSNMuDsXP9Quo4f0meTO76nOXq6O
ljnc9lpkY7KhsFX+1SUAkIJqDbL+hlIAXU8NAcnMKl+m8pgxEoYVNcEQ1ujHZIU8
vgQuMRQ4nbCvGuM8i8puVqbufs5Nu3vZEPwiOzINxDHZ/rezq6D/+cswXzpA2yut
YV4eQCNlSY7E5UjYOmqabBidXRh+VSknIBz2B2y0+N5e5MYIeqyZaxd+yFTMdDk4
N0z2JP4LrT1b1p5FndFd25SBBVmy4pPv/1n4vk8Mul8RiZ0J80P7dTj9vkyuyjmF
k/3f8KsvKvC+TOoSJkHaQfKHZR3Ga/zl8IDZPeW5zKytqtgX+eJIewYPN7Rjiljy
LEfjdJS8+XKmlu1k7smdWMTG+iEX+0l49wZSDiO7jFvPnSyWtslPZJ+f/L0g7p+M
dd0rRM1hQtkkTvIw2g6pedCt9MhFU5znQyjr+rT1S5iBryRKfBw=
=b4Q4
-----END PGP SIGNATURE-----

--mulrknomt5awd4ni--
