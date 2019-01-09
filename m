Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0E0C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8904020661
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547059779;
	bh=VMBXxHQtIn2rIyl7ckaX9SE9gtbIaHhcAOyg8NP+D8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MKV2asWE6pYCvKlrC5fTSn3Xyk2HelVH9I1T9JLSz+lKavbL3jzQjKRoUpQG2iLw2
	 VhKObaEbuw1umLxpCXl6JDCsrrDcAZLTFR/i8cTcnpI0xDVDIwF82hCv0YVOXnhVFp
	 PrE7AxOs9TRZMMSNZga9WnsbRYpy/tEVAYhLcPJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfAISti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:49:38 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33878 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfAISti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VMBXxHQtIn2rIyl7ckaX9SE9gtbIaHhcAOyg8NP+D8Q=; b=DM3P26aJJVS2KzaDNza1SrCSG
        7ncG4FjDkULJs/3Qmmxjfb7rP3OKkX5eUBtIWyPZT3CjgSli8u02OdsnUpJNggypYD1XLiA54TlqF
        asByfV3xZrT5Nh5Oyl3+mMJJLZmOaY253H3pkc2bi5ZYrs4PPw7Vggt2h3KLKXMivk/vU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghIuy-0000kX-4A; Wed, 09 Jan 2019 18:49:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B071B1127528; Wed,  9 Jan 2019 18:49:31 +0000 (GMT)
Date:   Wed, 9 Jan 2019 18:49:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Code Kipper <codekipper@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [PATCH v3 1/9] ASoC: sun4i-i2s: Adjust regmap
 settings
Message-ID: <20190109184931.GK10405@sirena.org.uk>
References: <20181221152110.17982-1-codekipper@gmail.com>
 <20181221152110.17982-2-codekipper@gmail.com>
 <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com>
 <DB7PR03MB46813005FFDFC8609F67F111ACB90@DB7PR03MB4681.eurprd03.prod.outlook.com>
 <CAGb2v66q9NfgRGW=o-m2vYKyP=AJT9rx2A32iiwdGKuiGxWjYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AYsPlKobQGgtCvjI"
Content-Disposition: inline
In-Reply-To: <CAGb2v66q9NfgRGW=o-m2vYKyP=AJT9rx2A32iiwdGKuiGxWjYw@mail.gmail.com>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AYsPlKobQGgtCvjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 23, 2018 at 11:16:31AM +0800, Chen-Yu Tsai wrote:

> This sounds like the flush is happening after DMA transfers and/or I2S
> operations have started, disrupting the order of the audio samples. I
> think that might be the case since the regcache is synced sequentially,
> and the FIFO control register is after the enable bits. That would imply
> that the device is taken out of runtime suspend after the .start_capture
> or .start_playback callbacks. Not sure if that's the case, but that would
> mean the bus clocks are still off at this point, and bypassing the cache
> and updating the bits is basically moot.

I would expect that the device needs to be resumed from suspend before
we start actually trying to transfer audio - there is stuff in the ASoC
core which is supposed to have appropriate gets but it's possible
something is going wrong there.

> I think there's something else happening here, but we need to figure it
> out instead of papering over it with something that "just works" but
> we don't know why it works.

I agree.

--AYsPlKobQGgtCvjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2QjoACgkQJNaLcl1U
h9CYkQf+LxpY1u9lPMC6ld9Jxf0JNyammIoqScIdns2JZ8ZH4M6rpKWUsUyETdVg
14bCT1yi7D5ZH9Ekcw/6yXB0FBQX0rqP2W9X7PODZTgWEVBwF6wrp9jIe5YlYsM5
47wuQFzRquRKmhaBwvuwdOM0+l2T8cRd7ZnOVmVNDJxb3oD8/0fR3LKCd8e8sQ9v
vqJTljjBtGlvwwWbWLeMLkXbvlesGpc7heRgrdHFXgxf46BMpN0rZuUWZU/5XwF6
zqSDZaXBPAgm1CFJ06FQdo8VeAmXT+mD0X0tJgZKG2FxJBAKEp5Ss9+sgSCMsbVr
Qo/rQCkOQYPKtuPsNLeHCFJEaBNy0g==
=m/5F
-----END PGP SIGNATURE-----

--AYsPlKobQGgtCvjI--
