Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453F3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B04A20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B04A20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeICRCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:02:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33473 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbeICRCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:02:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5F12E20799; Mon,  3 Sep 2018 14:42:30 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 34D26203DC;
        Mon,  3 Sep 2018 14:42:30 +0200 (CEST)
Date:   Mon, 3 Sep 2018 14:42:29 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     axboe@kernel.dk, hdegoede@redhat.com, mark.rutland@arm.com,
        robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 0/9] ata: ahci_platform: support allwinner R40 AHCI
Message-ID: <20180903124229.rchurusvt4rv5ln7@flea>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jp5yip7xlqswgcn3"
Content-Disposition: inline
In-Reply-To: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jp5yip7xlqswgcn3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 12:01:52PM +0200, Corentin Labbe wrote:
> This patchset add support for allwinner R40 AHCI controller.
>=20
> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
> by this serie, so no regression should come with it.
>=20
> Patchs 1-7 should go via the ata tree
> Patchs 8,9 should go via the sunxi tree
>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--jp5yip7xlqswgcn3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluNLDQACgkQ0rTAlCFN
r3S6IhAAgqTqBW00xd2l6IiwGwOw2n7Mnsv7+y5q1pAzzDaW2tL4c4fdRBwHPKGr
AnmDVHGN31R1yWNRdQ0Nn5a9Q2ArZCjpDQMhlsVQ3Di4cpRjANtHHEYyD6nnVttu
s9DAbL451/jDnEbCsACRejjvpRdOmNZWk7tJhxwLIGMJM/0VvhmMCmOoxEEKzQ3q
3EXgXV+t2N8fX5J8ueVWjnGbpoXP/9vqXoUkVNo7XTDwfGDWaVQYXaf6YCGsW4oX
NsTs5fENP78tGuzir3Tdmkpp565xQFmOoJMmjilSOD8R+ontkXus9GtLuTPdpc2u
ZzerY4/OkJ4IZmzmnTXZ0ez3AFAQSlndl1GNQAbrG/IO0kusVYPrC6ZXbwMP77Xz
NqGKaMYitpQ0MRVARA2X94Wyv/UWIavCHpVUYcGgsBNWqGpi1CPmyw+gHgWSGnoL
YP8qYBPr5aE90FZ9jZx3xlqsiwCrEG7Ib5q5DiJoy9mfNrjriTogQJ85U79kWBeQ
jYa7BmnXWIy7PJskZpDieujN7gHyk+XKxnr0mu2NbTJIREF6GrpoNYc10s2uuL70
TfKEUAjjpMN+jDRZmIpXgDcGj8pwHa/szsDYlk6Jz1CGYzBLYZKLGDT87cgBv629
VdqRxpPK3NEQi5BS0h7wwQjevgw+NyIqkiRnQGp4SLgLR9UR/Hk=
=em8q
-----END PGP SIGNATURE-----

--jp5yip7xlqswgcn3--
