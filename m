Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737B1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1374E2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ZEcljvGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1374E2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeGRLYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:24:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46966 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeGRLYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=97zSI/ch0f36c1MvNCpTFL53sDh+aZb/JOEjafY8CMs=; b=ZEcljvGpC0CvkTeh1+YkOzNmo
        HSvt66MeMNcA2cyEjGKFIerC/He7n6EPybggTFpgO7qwPm0A4MOJqFFP6Dc9k+3sWIjVO5Ib+VfIV
        qwFGvVVFRLJSyRABw5qizsP+kTUHmNxsQbAgl/c5djb48X1J58qVCrrvb2R+z9l8Eqhfs=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffjyK-0003Rf-F7; Wed, 18 Jul 2018 10:46:16 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffjyK-00038X-0c; Wed, 18 Jul 2018 11:46:16 +0100
Date:   Wed, 18 Jul 2018 11:46:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Kurtz <djkurtz@chromium.org>
Cc:     Dylan Reid <dgreid@chromium.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ASoC: AMD: Add an always on fixed 1.8V regulator for
 da7219 VDDIO
Message-ID: <20180718104615.GC5700@sirena.org.uk>
References: <20180718004909.213735-1-djkurtz@chromium.org>
 <20180718004909.213735-3-djkurtz@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
In-Reply-To: <20180718004909.213735-3-djkurtz@chromium.org>
X-Cookie: Remember the... the... uhh.....
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 17, 2018 at 06:49:09PM -0600, Daniel Kurtz wrote:
> From: Akshu Agrawal <akshu.agrawal@amd.com>
>=20
> DA7219's VDDIO for our platform need to be configured for 1.8V.
> Hence we register a fixed 1.8V voltage regulator in the machine driver.
>=20
> Change-Id: I65fd93e1dd37c3e0d38265b4b1492ea53b93afd4

Again, please don't include noise like this in upstream submissions.

> +++ b/sound/soc/amd/Kconfig
> @@ -8,6 +8,7 @@ config SND_SOC_AMD_CZ_DA7219MX98357_MACH
>  	select SND_SOC_DA7219
>  	select SND_SOC_MAX98357A
>  	select SND_SOC_ADAU7002
> +	select REGULATOR
>  	depends on SND_SOC_AMD_ACP && I2C

This seems inappropriate, I'd expect a dependency and if it were to stay
a select it's also not selecting all the bits required to make this do
something useful. =20

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltPGncACgkQJNaLcl1U
h9Ax3wf+OAx7UIiqmrElA100Ap6YDd6dACXNEzEP00mPEvtwj5TWnHpw2556Ty01
9j8kG8q+QMRZg10mcsyKCWcykd7QGGmw4ukfVLBVdeGfCLrACke+Zs7ibfy3wPYp
9RBUzz5zPpTiOWiNGHjIGRtXLlvbvsZ04Q3FGzNuwEsawofbQM9vFiPTWC86VxuG
Zy6nAbqYxr3Uy3PCnc5UpuEjm1szw5z6X1MxGxYySCpolsGs/PThR9hBnA8l3qnX
tmqPE724lwcnC6rmV5lo/NF/qCBmVLVEzK2ZwxKqtMG5bN7PnD2uktz5SK8DFOo6
spMl0f7cU6O64mgRLcReACzmaq//+g==
=79H6
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
