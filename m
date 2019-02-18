Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FF3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F352085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550513913;
	bh=Ler3cSWYVJtMbj5ZpTJT/w6VFWImnmGsz04Jw/0qznM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g1SBupnV0i3sz0ZFQJcrNdxpww+8Y98VqeuNL32F/je/tZV95chxD6SN2Oe9URWBV
	 rXElY/j8VI+Kns9KCV9S1i1Hee6s07YYYT/aSYn7fLONrm3f4VXSmhhd5NMrSPFQ89
	 brMBU5jmwAoHa796Qss/8MTUYUUELocdHLSwonyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392008AbfBRSSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:18:31 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46076 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388662AbfBRSSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=L54Kx3snqK+QgiaA7F7vNxGxvWSEk0EQFg3UDMcMJUg=; b=aAyCSd5gNMXeVfgevehFgydLH
        eeoceIB/XSbbtBW7YjARJ4WZF24x/S61tpFAfM0gLk/NMVjio/bTeMRj3JwJdl4S6tdIsVc6O2+HE
        7vM6U+obopcKOK9mXH6N6+V07p8N/xhncUMs3rK9ZgrNmrks4Tc4xl0R3opeuWZmo8SDc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gvnUV-0001Qq-VU; Mon, 18 Feb 2019 18:18:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5150A1128008; Mon, 18 Feb 2019 18:18:07 +0000 (GMT)
Date:   Mon, 18 Feb 2019 18:18:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc:     "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Adam.Thomson.Opensource@diasemi.com" 
        <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: AMD: Configure master codec on all
 playback/capture cases
Message-ID: <20190218181807.GF10794@sirena.org.uk>
References: <20190215070539.22150-1-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kR3zbvD4cgoYnS/6"
Content-Disposition: inline
In-Reply-To: <20190215070539.22150-1-akshu.agrawal@amd.com>
X-Cookie: Take an astronaut to launch.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kR3zbvD4cgoYnS/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 15, 2019 at 07:06:15AM +0000, Agrawal, Akshu wrote:

> +static static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
> +				    struct snd_pcm_hw_params *params)
> +{
> +	/* da7219 Codec is clock master so setup as per the needs */
> +	if (codec_dai->driver->ops->hw_params)
> +		return codec_dai->driver->ops->hw_params(substream, params,
> +							 codec_dai);
> +	return 0;
> +}

No, this is a bad idea - you shouldn't be callings ops in drivers
outside of the framework, something is going to break on you there.
Either the drivers or the frameworks are going to get surprised by
things getting called out of sequence, for example I'd not rely on the
fact that the CODEC would be outputing a clock without active audio.
This probably means that you're going to have to extend the framework in
some way, or refactor things so that the BCLK is exported as a clock by
the CODEC and reflect the relationships via the clock API.  I need to
think a bit more but I think the clock API is going to be the the best
solution.

I also suspect that some work is needed to propagate constraints between
the various DAIs in the system.

--kR3zbvD4cgoYnS/6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxq9t4ACgkQJNaLcl1U
h9BFpgf/d/DJQCKtnkQnbzLnFB65/rVz3sTtB69+bGTGwzdpqr9iZuEr/gtbYrlW
qf/h52giMIYtcplragEM1s2N8Ap/t5sfQyPcJKBAQvYTJGcXUVKR5nGYtwkOPK5N
/eKAHfL5Ix0aBdjgR59M0quTBCDENSrAEewlJeSKuXgfuH6JRYUj3BqEr3fVvhWT
2uoimEod8420/rwtZQCHE5TnhrLBFJ+vc58Zr80tQZ0JyGcT4CkhJU7T6YR8S27R
dMQmfV6/Up0XrbmQeTGfm1LAMuzAlY1cyYYSwvZv5Qt9UhYMWFLa7KgQwqCbnd0q
hlNU57dMwHC9rn3KAziHEhZgTpnLCQ==
=LO88
-----END PGP SIGNATURE-----

--kR3zbvD4cgoYnS/6--
