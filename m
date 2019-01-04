Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDEDC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E5E2070C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546604884;
	bh=HcecHQmVa9XQpPPchZR/g61QBmHw27CsH/0YAqgFpG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I9FMsYgAin/6ZZLckgo7pdtogSA7kPxOMcL8GPRqBrz/pz31HLpPxk9AsAdmXeYxG
	 TdWSf1HapS2+PR/gpYY3dD7qO6cc3jg1St4mtmrf7ypLsoCEQriFKmKX6PfrDj1uOk
	 7Ao/1FZIppg7fZbUGlYkPvOkBsbNyy2mblMSYuao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfADM2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:28:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37740 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfADM2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a6qtDrjVRZPyAcL57ZD/hfGmnpsimYiEPD+h3W77BaA=; b=Hls29L05OnmNnxZSgecSsmkcN
        XneYuX4GUtB5w+BUkzHHQTY7PzVXud1OD6uJDQbJANe0SB2apiaqjQv6/3v+KoRPmlqIFh2TOrArU
        CaZqBuq08EJUDmxMh3WPbrKtsYYCyWdmGTcfzjC9S2L2EoygNB420ALgmRdXrwSFVyHCw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gfOZi-0001Il-Gs; Fri, 04 Jan 2019 12:27:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E7B4F1127096; Fri,  4 Jan 2019 12:27:41 +0000 (GMT)
Date:   Fri, 4 Jan 2019 12:27:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc:     "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: AMD: Add delay before starting to capture
Message-ID: <20190104122741.GA4140@sirena.org.uk>
References: <1546510559-17798-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <1546510559-17798-1-git-send-email-akshu.agrawal@amd.com>
X-Cookie: An idle mind is worth two in the bush.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 03, 2019 at 10:18:13AM +0000, Agrawal, Akshu wrote:
> On capture through dmic we observe a glitch at the start of record.
> This is because we start capturing even before dmic is ready to send
> out data. The glitch seen last for ~20msec.
>=20

> +	/*
> +	 * On some platforms, it takes ~20 msec for PDM DMICs and ADAU7002
> +	 * to settle and start producing proper audio data.
> +	 */
> +	msleep(ADAU7002_DELAY_MS);

If the delay is required for external components to start up the delay
should be going in the drivers for those components rather than in the
driver for the CPU side, that way other systems using those components
get the benefit and non-affected boards don't pay the cost.  There's
already some support for this in the DMIC driver at least.

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwvUT0ACgkQJNaLcl1U
h9DpZgf+IJjt3vPexs0YNutFifnYllPmQgc3jjLPJ2c7qVzdft2hyBlM+4Gz0Wrt
qG+DXIj6n50m+bhzp2QC2cjMTeZIUqzdmkmx1dqeuShTvulOx7TpSz5DIJIQkuWo
3u7SGlUmBnUhEsjxMfG8N3grGU89h/dRjtuvqgBUhmgm/+9fRqw5YTRel1TPY0cj
d4li0Jnlhn9KyiWZQxd7MKMMjB0PTpvXTbRT5lZrdACGdtcFlA3dUeV4MDQM/MzY
WVaOjtYhFVbpeFYChqPorMBEtuWFjbQiudZeXEgPmTvVbSx330OeH8zlDdpFx8eB
+dDYYpVvBVgIvCfUzwcjNrpFysIXqA==
=VZTZ
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
