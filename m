Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981EFC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A38A214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A38A214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeHVJxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 05:53:40 -0400
Received: from sauhun.de ([88.99.104.3]:48122 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbeHVJxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 05:53:40 -0400
Received: from localhost (p54B3399D.dip0.t-ipconnect.de [84.179.57.157])
        by pokefinder.org (Postfix) with ESMTPSA id 90D982DB8F7;
        Wed, 22 Aug 2018 08:30:10 +0200 (CEST)
Date:   Wed, 22 Aug 2018 08:30:05 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/11] can: rcar: use SPDX identifier for Renesas drivers
Message-ID: <20180822063005.535lytz7hl32rsha@katana>
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
 <20180821220233.9202-6-wsa+renesas@sang-engineering.com>
 <CAOMZO5AkVNiYMGdED9erL=YMaKcmtS5BzZxw2gO1KLXEaPnD7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l3tkizk2h44slbvj"
Content-Disposition: inline
In-Reply-To: <CAOMZO5AkVNiYMGdED9erL=YMaKcmtS5BzZxw2gO1KLXEaPnD7A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l3tkizk2h44slbvj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +// SPDX-License-Identifier: GPL-2.0-or-later
>=20
> According to Documentation/process/license-rules.rst the format should
> be like this instead:
>=20
> // SPDX-License-Identifier: GPL-2.0+

According to https://spdx.org/licenses/ it should be what I did above.


--l3tkizk2h44slbvj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlt9AugACgkQFA3kzBSg
KbbVsxAAilL4O89Og1iC6sJx89b+euWyoRGCkeNio0iM+paRSXSf2OgwmpyFBsnc
9NPxv6WoNOoTNUmtadLpJtSBomJ0eI1LRgj3PLHc0YIlq6KdASDq6tZmd5i3n/cT
G32o40GMBAVQxam/qG7lHOi2gTFFrIB08nKnXFpXbGmUxNgU7B3wu+z7uQyx3gnx
Hjsb2LpYwjQ8OzNE9GLvJ+xp5amXG+EvJkOFJ/aWKy2Da9NLyxz0Tz8FRaLMzaCh
4Eb9E6IVCTdw/fSUBqMKuISd6EHGfQyTq73G3rd0ZJV2+gqD4zmwtW+MGu594NaA
jaUi81043F/d0cx5EISVXbPtq/K0hmGHTFaeogFYTfWpDXPljQdCHWXNDCGSOFI/
ss1P2tQWQCK3pDnlJZQj8jqvSxF1AURx2YUYFaX/VxTm+doEnAWP02Q6y3E5bLpI
pL2hwdZEPgRMK+w5rQe+Q//puXJHCl1KcdvYiDAVJwRq6P/KUed+CzwRmGB89TzW
nt7AhJdYyPrFPRePCFrcAfTTA8CFrpmuKv0miyvBtj4+bwnrX46nKqFFmKWDsCW7
ioH8ujmLft/qyNrsXdFsWM+r57ohP2tD9eN5teF0znLuhxrjWda3dXAvOSnfQSI/
Pe/pVBeBmOBt1HX2DAtS1ns100uT3IzbpDuBXl5OGwhYW8KYjDg=
=jUPf
-----END PGP SIGNATURE-----

--l3tkizk2h44slbvj--
