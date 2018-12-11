Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B486C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE382084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE382084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbeLKUjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:39:21 -0500
Received: from sauhun.de ([88.99.104.3]:45666 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbeLKUjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:39:21 -0500
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
        by pokefinder.org (Postfix) with ESMTPSA id 35D034C0E8F;
        Tue, 11 Dec 2018 21:39:20 +0100 (CET)
Date:   Tue, 11 Dec 2018 21:39:19 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Subject: Re: [PATCH] MAINTAINERS: add entry for i2c-axxia driver
Message-ID: <20181211203919.lqzmg7cokmiybgmf@ninjato>
References: <20181211091733.GA28051@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="weswamagsnraa3y3"
Content-Disposition: inline
In-Reply-To: <20181211091733.GA28051@localhost.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--weswamagsnraa3y3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 09:17:52AM +0000, Adamski, Krzysztof (Nokia - PL/Wr=
oclaw) wrote:
> Create separate entry for i2c-axxia and set myself as maintainer.
>=20
> Even though I don't work for Intel/LSI who is the manufacturer of this
> IP, I do have access to some documentation and the actual hardware using
> this driver and I'm familiar with the code.
>=20
> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>

Applied to for-current, thanks!


--weswamagsnraa3y3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQIHcACgkQFA3kzBSg
KbYLAg/+L1vmdAHwihZ7gnFaQcNaVhhVOLWdF4sT5zPfZiObbwJYYvQeBWijCXkf
UgB2l6DJszAilVHapGT39Mz7VB0EjyaF9R1P2t0T+QRBergZi9v7FBq4jEY+2UYq
FLP8J/LIqj5y7l+S+JmqDbgXau9bG1dFb+w7jLJ9foVP3rrpPhFhVt2H2R9TKjtA
LRwWRy6Ov0ySFz8mupbLGFesflGxz5saTgUi8EW2rAUI9plUM0Vb63BnW2vUH1YI
jp44r61w4co+kcey6GJDp2Dhkacj55252VQNkTRyHMCsZFYUg68rrq2geOyBCpnm
kKkTbCaXoHrRb6iFCOtmI+91pYsAFY0TvUIPT8vMB73S26CT24nrAJAGmAKZiMX8
XQU83vYFAwQxRyVYGBiI+uJYA3QGg+msaGV2nliacgt7862JpzFTDvMB9W/lYFON
HpEkCAOgNomQVCJKSYIPTCfLVc9ogt0T4ipa1ktlKK1CTxhUrQ6rIpnJmhyT9GRY
5UCrotFR6JuU3V8QcRYIXtrQoAvbjEK3JKyUSUUvT60HQoq5hSyY8NmHIxLbFWjv
H14oi23jO8SLF4nQKew5vmuLgO1X6iVqbPwWGkr8VfIU4mDLWEzbpZ5BVOcUEtrn
XJDwNj5jCd4pn9tbyGqKahPYQ30KPJjHKw1yMUr4Vjlx6lqFsO0=
=bZum
-----END PGP SIGNATURE-----

--weswamagsnraa3y3--
