Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45858C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6E82083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6E82083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJOTRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:17:04 -0400
Received: from sauhun.de ([88.99.104.3]:46242 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbeJOTRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:17:04 -0400
Received: from localhost (p54B33719.dip0.t-ipconnect.de [84.179.55.25])
        by pokefinder.org (Postfix) with ESMTPSA id E3EF22CF683;
        Mon, 15 Oct 2018 13:32:10 +0200 (CEST)
Date:   Mon, 15 Oct 2018 13:32:10 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mmc: tmio: move MFD variant reset to a platform
 hook
Message-ID: <20181015113210.bmrn5jxfhh43yl5v@ninjato>
References: <1539143492-32605-1-git-send-email-yamada.masahiro@socionext.com>
 <1539143492-32605-2-git-send-email-yamada.masahiro@socionext.com>
 <20181014222757.GB3260@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3tih2gcnk2ua3tyl"
Content-Disposition: inline
In-Reply-To: <20181014222757.GB3260@kunai>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3tih2gcnk2ua3tyl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 12:27:58AM +0200, Wolfram Sang wrote:
> On Wed, Oct 10, 2018 at 12:51:31PM +0900, Masahiro Yamada wrote:
> > CTL_RESET_SDIO register is specific to the TMIO MFD (tmio_mmc.c).
> >=20
> > Add a new hook host->reset() for performing a platform-specific
> > reset sequence, and move CTL_RESET_SDIO over there.
> >=20
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>=20
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Tested on R-Car H3 ES1.0 and ES2.0, M3N, and H2. No regressions. I
pulled the SD card out during transfer to ensure the reset function will
surely be called.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--3tih2gcnk2ua3tyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvEerYACgkQFA3kzBSg
KbYc9RAApdABe3wiKFrfOU4fkWeHcMNIInga/R+oYrKZJS1zEWwGN+swrNlEhPOk
iQ6FR3VC+HWJG6ExLehDUKyQSl5YFeBKNWN9+T4jwZAZ6uQsrEBMjesjxWhuh6GJ
xSFS875l3CezsDruRS57wHLI0G5VBIvJZBMg/pWa0BwZ5tkOiEwB3Y7+ZXzCB/Dx
4aTURpq/TfotoF9XlLpR0kaQiR9WEbtrQk8GAJgD6lfnAJfOMDr+h605ojG/oeej
ouv6m/1uOm7QpM5i3+vh7QCC8BkALl5nH+EiLJ6BuJwzSpcPnd4/rk17bOEwwwAz
ivEcosBYHzFqV7nVS4TYYwhAKhJXQENxcU7Hirwxrrt2ktZVsKkrD9AraWd96Pde
mq+AE3USSbLVjHERA6kCccMBW6wvoxUMyfW59qjpBGWmZEqkFfojkCNT+2EwD9ke
5UWFj3/H8xiv66YfX6sTfPHWEIYgcq5ML8u2gonkiN7A6/qkY2DZCNyQyxh29ACo
Vd6zvoKo07RzRfLMYZiFsaaUs1ctzPgMqnsLIor3QCfJ5E6tEo6pNCjN1Dq/AxuU
H07+8pHKlYdmp/6sztqRTPmUXPSiqmg4a8C9wk3V8AuZQXAMYAyTCOjydExZAfSQ
1A9UWN4IWjinaBx0EDfrU1iWVo0FoNkWhdusPHnfyz1FshQrbF4=
=2CYy
-----END PGP SIGNATURE-----

--3tih2gcnk2ua3tyl--
