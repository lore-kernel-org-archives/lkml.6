Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B24C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44342077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44342077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeIGPO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:14:29 -0400
Received: from sauhun.de ([88.99.104.3]:52788 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbeIGPO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:14:29 -0400
Received: from localhost (p54B3324C.dip0.t-ipconnect.de [84.179.50.76])
        by pokefinder.org (Postfix) with ESMTPSA id 595DD2C27DA;
        Fri,  7 Sep 2018 12:34:08 +0200 (CEST)
Date:   Fri, 7 Sep 2018 12:34:07 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        linux-i2c@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Heiko Schocher <hs@denx.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        u-boot@lists.denx.de, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] i2c: xiic: Record xilinx i2c with Zynq fragment
Message-ID: <20180907103407.GA2310@kunai>
References: <a36257084b0816bd84bb1caacdcde586b7fcb007.1536300108.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <a36257084b0816bd84bb1caacdcde586b7fcb007.1536300108.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2018 at 08:02:05AM +0200, Michal Simek wrote:
> Include xilinx soft i2c controller to Zynq fragment to make clear who is
> responsible for it.
>=20
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Cool, thanks!

> ---
>=20
> Normally we are handling all these drivers via one fragment to make sure
> that there is only one central contact. Another reason is that people are
> changing and their responsibility is moving time to time.

This is fine with me, but what about sorting the entries? I don't care
much because it is "your" entry, yet I thought I mention it. Let me know
if I should apply this as-is nonetheless.

>=20
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ad052aeac39..d870cb57c887 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2311,6 +2311,7 @@ F:	drivers/clocksource/cadence_ttc_timer.c
>  F:	drivers/i2c/busses/i2c-cadence.c
>  F:	drivers/mmc/host/sdhci-of-arasan.c
>  F:	drivers/edac/synopsys_edac.c
> +F:	drivers/i2c/busses/i2c-xiic.c
> =20
>  ARM64 PORT (AARCH64 ARCHITECTURE)
>  M:	Catalin Marinas <catalin.marinas@arm.com>
> --=20
> 1.9.1
>=20

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluSVBsACgkQFA3kzBSg
KbbEug//buRTxmtHceupLcIT66UIG6brSA1TTPw70N4k1xCG+KA7jWZQLyGDkMeR
1ugM2doAtD2gMt3BJmqJ5S1K/RuYB5ACQhMt7FRUjtuvIggBkoqwRXUdX209/TE9
3Kxn8Kv8sgbWRKTFVOts8UdJqjxG82zzc6yp3WLfoG5i/X8ZR7ZqAvQGgnvmi/Tl
CyznZs9SiODOI8iN+Pcjb+uKfiy0l49RXm9Uv5ABOL3OSkGx6I80PsnrKaMx8cmU
a9h3Df9jsr+G0qUsZnmT43kgfBFN3V8KJaE4XcreMh5jLcjozmr+xDnmwouyISWg
Z0Wa1TMnokieIqo6IMLLVdUyLRZ3uOtDdu0BqKk9Rl4d+UB0c42ek3fvz0krciDG
pj8FLKdPFVWZnH25GmufCw/7NmYFkNYhx0CY35m2f+91ZFZyjmwbzxn45Q6Ge03x
TwkvkWvVLNlxoK+lS1jxArwKQx/vdX+/91Scwjypa5sZA+VzGfCQ3H9+ZUYBp3Ph
usiFgryGZBCu79GWmzkNIhsq//hHnlEIQIOQwbYTYuq4NW9VXW2zVqgQZZdhUWGG
qmvJheYEbLqVMQTrOVJ6yVb5UvCZ67a6JI+EfxCdeqbYO1gTQ7m+yiYVl73sPHyn
rtzGhJTA3iNeXvLvxd771gShUShMryMpMdKWfCgfuVvgaDHmP8U=
=IS0r
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
