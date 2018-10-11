Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D6DC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B6E20644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B6E20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJLEkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:40:32 -0400
Received: from sauhun.de ([88.99.104.3]:41710 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbeJLEkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:40:32 -0400
Received: from localhost (p54B3377B.dip0.t-ipconnect.de [84.179.55.123])
        by pokefinder.org (Postfix) with ESMTPSA id 4AC512E3577;
        Thu, 11 Oct 2018 23:11:27 +0200 (CEST)
Date:   Thu, 11 Oct 2018 23:11:26 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 3/3] i2c: i2c-qcom-geni: Simplify irq handler
Message-ID: <20181011211126.r7sxqvrxce22wdk5@katana>
References: <20180924235235.182649-1-swboyd@chromium.org>
 <20180924235235.182649-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gw4hxvqsow7do7fv"
Content-Disposition: inline
In-Reply-To: <20180924235235.182649-3-swboyd@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gw4hxvqsow7do7fv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 04:52:35PM -0700, Stephen Boyd wrote:
> We don't need to use goto here, we can just collapse the if statement
> and goto chain into multiple branches and then combine some duplicate
> completion calls into one big if statement. Let's do it to clean up code
> some more.
>=20
> Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Cc: Sagar Dharia <sdharia@codeaurora.org>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Applied to for-next, thanks!


--gw4hxvqsow7do7fv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu/vH4ACgkQFA3kzBSg
KbYdcg/9EmvZmbD3Pll1WJOOnuCOWr1DMUsz3YGx6HbchQySbJvNtY7+CB8U3xHT
RzLhjeMpSty7FfCM1WxV2TeKQMJNytYIuQfq/mGQVbJvcCQ1T7VCuAfYGyQutUIL
Y5ZhJGbNEMZ0pzv7f/qEG656wyyOtTRB+/UrzQtwKG2U+YLFm0l3r76Se2uUqPmg
h/+brH4Wlr7hYmAwwHBeVQt+gjFdGxS3zCjSPeyPmgD0Ab577dMh/pLN+3LjU4XS
dNnXvoG158udEzF+ELtq32mTmdVuo08KcvTeF9oY5uSVlhS0nAQSlGtF4vSRr9jg
vlKI451sUtIR0VDMrbD+A1Dqd5hR2GBR5tn7W6gqqSvZ7B50EhcMw7qDf/27KpmW
ZUNI2N9PhMMPSRphcu2ert45bxruPiA1q7+4IyUovqZbj33Xul94BjEJW0j0ZYnB
gjaO167U5P0lkrGUBE4t/tHHOUSVqt1G99Y+gd3FRg+jh9iqU0bfjF+WzBT0lUTS
bh2tb6EoJjYDmmXIl0zR0SZnBpoGHBrRHq3/pgIhZPBvksNkV5ODTwO7XO5ulWkt
9b+hV/HQ2x1m0TbN/c1RO0LiT3ZJxb8tNucMWsVizznDb5YaKecKsQ7Yax9p7NAa
dreRUpu07L9xlCeY8oduVhRdWDpvscNMzJ4IDbeg6wkGbkGkAb4=
=rDgc
-----END PGP SIGNATURE-----

--gw4hxvqsow7do7fv--
