Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0981C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9657E222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394036AbfBNQvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:51:38 -0500
Received: from sauhun.de ([88.99.104.3]:54072 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731118AbfBNQvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:51:38 -0500
Received: from localhost (unknown [83.221.228.209])
        by pokefinder.org (Postfix) with ESMTPSA id 0C4472C2817;
        Thu, 14 Feb 2019 17:51:35 +0100 (CET)
Date:   Thu, 14 Feb 2019 17:51:32 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        peda@axentia.se, digetx@gmail.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V19 1/7] i2c: tegra: sort all the include headers
 alphabetically
Message-ID: <20190214165131.asr7fedtozy2oi76@ninjato>
References: <1549998408-9137-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kf63lw5a3hbketpm"
Content-Disposition: inline
In-Reply-To: <1549998408-9137-1-git-send-email-skomatineni@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kf63lw5a3hbketpm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 11:06:42AM -0800, Sowjanya Komatineni wrote:
> This patch sorts all the include headers alphabetically for the
> I2C Tegra driver.
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Whole series applied to for-next, thanks!


--kf63lw5a3hbketpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxlnJMACgkQFA3kzBSg
KbbNVhAAtNxtze5yLEP8pWB/CAzhCigH1gpEkBW3jZZZxV4Gpy9VVZK41BnaHSe0
VDbftVtuVZSIhHMSLt+qlEvJ9D0sS1ydsxf9JTJ3TAgmV10g7wcuLXr3+vuV78Lz
6UQsgPDuHZz7qs2KALKaAG/bCfpPMEsSlLQr01WHUo8OX1+SW2sgKZTZJoI8n9nc
sYjCMuCVFoPK0OnX3EosceWhbATIA22gAd48cH2NLnwGsc/zWIMeJoAOtHbMx7U1
bqby4dNtJINaSV36j9t1h9ytwZdQ7/iNzj9e7za6uTTdQ39Ogym+oiKqyClEGtbz
n5UtyNvawnwzR/LkQG9lSzturQTwQ9FmXCrTaApYXCykHO5IJa0927p1qvlnpl0V
mAnMrII5EEGret1HnYYAAq/ClUz0ee+/txASOFpwk0ivzGHv5rvspwYnsRGbe4Ct
gb1qu18okD7erlWlWn3jfRi7x+SR4udAd/fLYagvX51G9L5T9AVlSWuTPM2yP36d
cicxA5kRF5AYCGUlYDfRtTTZ4idbIPUzmhxwAtvyJKo/cW9Gsqr23tgM0DDDQsYJ
YkRRjxRQa5G9fgnTuUIZZtj0ZbFKpOFytJpEmzOanJcUIgw2SOevbOhl2ZYMxI6j
gVJCION769hnQGBx6gf3FtwymuyN49PrJ8AypI2SCrSEFM2mm7U=
=2a3g
-----END PGP SIGNATURE-----

--kf63lw5a3hbketpm--
