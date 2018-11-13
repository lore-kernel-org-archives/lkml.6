Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A4BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C50620818
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="EcjWOQvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C50620818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbeKNFlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:41:10 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43640 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNFlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WeR6j32w1x0x8U5w4643vwH8IqBXzhw+rltaKKBYBPE=; b=EcjWOQvW35391pYpZ0qIkjNXh
        r7P64VKz7eVTFgVCmWWFRV1ohF/JpKEVXtIGo/FxmAjjWt0bdLxsnRPCSQKO61xGUpiBXEPSM5Q8u
        BxZlrAlmO8bkxJQtocBV4/GHDzUweRwiFEV4zei1cCNCrjQydSvEDqY2O03syGYs3L5bI=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMeYy-0002Uh-Fg; Tue, 13 Nov 2018 19:41:28 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 5F136440078; Tue, 13 Nov 2018 19:41:22 +0000 (GMT)
Date:   Tue, 13 Nov 2018 11:41:22 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Alexander.Deucher@amd.com, Vishnuvardhanrao.Ravulapati@amd.com,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Sanju R Mehta <sanju.mehta@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 04/11] ASoC: amd: add ACP3x PCM platform driver
Message-ID: <20181113194122.GL2089@sirena.org.uk>
References: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1542000903-19020-5-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gmhhrsDozM2n+uz5"
Content-Disposition: inline
In-Reply-To: <1542000903-19020-5-git-send-email-Vijendar.Mukunda@amd.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gmhhrsDozM2n+uz5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 12, 2018 at 11:04:55AM +0530, Vijendar Mukunda wrote:

> +static struct snd_pcm_ops acp3x_dma_ops = {
> +	.open = NULL,
> +	.close = NULL,
> +	.ioctl = NULL,
> +	.hw_params = NULL,
> +	.hw_free = NULL,
> +	.pointer = NULL,
> +	.mmap = NULL,
> +};
> +
> +struct snd_soc_dai_ops acp3x_dai_i2s_ops = {
> +	.hw_params = NULL,
> +	.trigger   = NULL,
> +	.set_fmt = NULL,
> +};

Having these empty ops sets is really surprising - I see they do get
added later on, but there's no sign that this will happen here and
assigning NULL explicitly is generally bad.  It'd be better to just
leave these empty here so they don't look like a bug when doing review.

--gmhhrsDozM2n+uz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrKN4ACgkQJNaLcl1U
h9Dhnwf/TTWRh5Jg+uDQ7fBuAKdvKhqWhYGLO3MFidokeN7ewqDQC65WTGHr08yd
rhHtg5hHdU2ffxbyZECzXFM0GKNmSWGHjmRTPIUIu8qAGWivUuTd0D3372JMIZeq
jD5Qs6scAC1ei8o4ijrgN9CzMuPaGroL2LKk1Gk1gm9Z+GidiwWEhnVBhcCgXpSk
z6h4dmCgWjXUdZAxg+U0eS8dehWVASbEUggyzMJk77kr9HCYM0oYUWSILZ1Ab8cY
hFTsFWuEKMSSGGRvnMn2BwcyBiY2fyi+ilmTJSHkOKPu9QM3DOzWTEiMKa+AjMpz
W7C3KvHyiTo9RZgbrBPG60rAuGGDxQ==
=pVFt
-----END PGP SIGNATURE-----

--gmhhrsDozM2n+uz5--
