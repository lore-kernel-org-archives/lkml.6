Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483FEC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1903820811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1903820811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbeLKUFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:05:25 -0500
Received: from sauhun.de ([88.99.104.3]:45348 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeLKUFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:05:25 -0500
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
        by pokefinder.org (Postfix) with ESMTPSA id 871354C0E8F;
        Tue, 11 Dec 2018 21:05:23 +0100 (CET)
Date:   Tue, 11 Dec 2018 21:05:23 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
Cc:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 1/3] i2c-axxia: dedicated function to set client addr
Message-ID: <20181211200522.ckfyo3uhv6f6kjdn@ninjato>
References: <cover.1544453688.git.krzysztof.adamski@nokia.com>
 <120bc3dbc7fad29807ff9f7c74575a66e6da15a6.1544453688.git.krzysztof.adamski@nokia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7ttcironrq3vt57y"
Content-Disposition: inline
In-Reply-To: <120bc3dbc7fad29807ff9f7c74575a66e6da15a6.1544453688.git.krzysztof.adamski@nokia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ttcironrq3vt57y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 03:00:52PM +0000, Adamski, Krzysztof (Nokia - PL/Wr=
oclaw) wrote:
> This patch moves configuration of hardware registers used for setting
> i2c client address to separate function. It is preparatory change for
> next commit.
>=20
> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>

Applied to for-next, thanks!


--7ttcironrq3vt57y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQGIIACgkQFA3kzBSg
KbYq6A//Sr3+jIT+p/2/Ix/BN0y8eelGwSLZXrLUnCgPWkPwGLChH65KD8POy8y7
SS5DNLKH/MtooOW5XKLlZwkbrSD7WtCw1sS/5MWHEkQU8Op4rH97NgaFxn9xwGmz
fY2wZyu3rNTtMIezMScRzHTIAmPR31IHmNwCegzPtMrzhpFyW+kDU7eVDbp4Ux3A
BP9rJGeG0lvTHmzgDkWO2ESzlzKDWGNy24zTs9bgPcx9VOpEdAT7TF3WibT6VlKW
JyH1nlXfcQLfyd/t5zb/lzcCORxPVqu27NiX1SKcNllY5BvgeYfaLFvnwXQGpxYG
nC+xEduAgWXXlP6rRcA4L0yV6e8AbrrXzDaRly5uxPIq+y+yGZTZB4n5TRwCJsRf
uaKHV5HhYYAELv6uD/5EuSH/GGgnqhl0qj2x3xRXX2rb1PEh5VY622Yflw5PAQgY
UdZ/3ws9wjobDbTY9zqr3GVJAw7NlmQEN6MovduNphxxUh/gtj6yfDGbRI9z9wZV
vaBRPRIalXuApW2QXf89WmG98LmiKWDqy3usVNBVGLGDyiVuumO8+puRWPtiK9z8
FC79Wscei24+TuPRokmqexGnlVPVFwtF2tRpIUtOo8hKurUa3HDdxbuiaqfpugbL
Ma2R+vOze1ZQz4+apMAkd4MAxU4L+xmRB7tBZLq1kt7Z7zY1HyA=
=JZ0g
-----END PGP SIGNATURE-----

--7ttcironrq3vt57y--
