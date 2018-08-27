Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C89C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E7F2083C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E7F2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeH0Nuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:50:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60848 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeH0Nuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:50:50 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 383D6808E4; Mon, 27 Aug 2018 12:04:49 +0200 (CEST)
Date:   Mon, 27 Aug 2018 12:04:48 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org,
        jacek.anaszewski@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V5 4/8] backlight: qcom-wled: Rename PM8941* to WLED3
Message-ID: <20180827100448.GF31905@amd>
References: <1535106467-17843-1-git-send-email-kgunda@codeaurora.org>
 <1535106467-17843-5-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="m1UC1K4AOz1Ywdkx"
Content-Disposition: inline
In-Reply-To: <1535106467-17843-5-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m1UC1K4AOz1Ywdkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-08-24 15:57:43, Kiran Gunda wrote:
> Rename the PM8941* references as WLED3 to make the driver
> generic and have WLED support for other PMICs. Also rename
> "i_boost_limit" and "i_limit" variables to "boost_i_limit"
> and "string_i_limit" respectively to resemble the corresponding
> register names.

Acked-by: Pavel Machek <pavel@ucw.cz>

> -MODULE_DESCRIPTION("pm8941 wled driver");
> +MODULE_DESCRIPTION("Qualcomm WLED driver");

"... supporting pm8941, xxx devices" ?

>  MODULE_LICENSE("GPL v2");

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--m1UC1K4AOz1Ywdkx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluDzMAACgkQMOfwapXb+vIxDwCfSZHys4+U14pB3RnG3eNhcldU
BM4Anj4olAVu0Y51Le9DlFhi+s6FAJOG
=jfYa
-----END PGP SIGNATURE-----

--m1UC1K4AOz1Ywdkx--
