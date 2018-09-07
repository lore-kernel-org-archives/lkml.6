Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A5BC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2352077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="JfjlIYED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2352077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeIGUiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:38:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60368 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbeIGUiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k71hzm+c7S6GP5CMwuAF36SUtAykVQga/+yvj45SeH0=; b=JfjlIYED2W5rip9GWimnOXDcV
        sJM/EMB6Oq+DhBLGGnufetjM0aQ+iMbKDEk3o86A+Fvtgi+k1d4M8xMv2Lf8t7AqRjvj3GzE0a+iy
        1O2LAs0mtK8F0jggjB17YuDac0B7u9x5dyjVIfEWq5Xxf83BXGLuinDLnvwms5hVFxjeY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fyJ7S-0005X6-Vq; Fri, 07 Sep 2018 15:56:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6688B1122A6D; Fri,  7 Sep 2018 16:56:26 +0100 (BST)
Date:   Fri, 7 Sep 2018 16:56:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>
Subject: Re: [PATCH V2 4/8] regulator: stpmic1: add stpmic1 regulator driver
Message-ID: <20180907155626.GI17459@sirena.org.uk>
References: <1536325173-16617-1-git-send-email-p.paillet@st.com>
 <1536325173-16617-5-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Op27XXJsWz80g3oF"
Content-Disposition: inline
In-Reply-To: <1536325173-16617-5-git-send-email-p.paillet@st.com>
X-Cookie: Do not fold, spindle or mutilate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Op27XXJsWz80g3oF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2018 at 12:59:44PM +0000, Pascal PAILLET-LME wrote:

> @@ -804,6 +804,18 @@ config REGULATOR_TI_ABB
>  	  on TI SoCs may be unstable without enabling this as it provides
>  	  device specific optimized bias to allow/optimize functionality.
> =20
> +config REGULATOR_STPMIC1

This looks good to me except the Kconfig isn't alphabetically sorted and
has a conflict.  If the series doesn't otherwise need a resend I should
be able to fix by hand, let me know.

--Op27XXJsWz80g3oF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluSn6kACgkQJNaLcl1U
h9D0Hwf+Mz7oDPoli2YWJfuvAyjir33WC91k9f7g81u4O/QJ6AJJ+Tl2yc8D9VAd
sfPk5SF3UMl3eMbsQ8/al6P7j4H0gMvkvgVt/0baJGkHd+v4X+vTWGWiO1Rlk7Wk
2PeLVMwJJ4W/ma+jNo++WQngv/SHsRddiH7zDaHgrlCCiGEnsqPX1MBg/T/lwCkF
de/8sT5o3PWmbl9Uvfow7mX9FLRLPDZFKULPRQqJNTyW/pa/VPbdwC9vHf8aYGdg
y91SSOy/u4BoiegzZNMuLnuG9jekHultXFFsmlbZdBlAM3u1vyjqLuzwTEh3EpnU
MFMZNboU65z5qOhlMMCHIOJ/6nVEkw==
=M5Mz
-----END PGP SIGNATURE-----

--Op27XXJsWz80g3oF--
