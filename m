Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FBCC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E2C20685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547059866;
	bh=hKyL4CfL7YSUjp0Dl0YOxZy+BWcnp2DvLGJ9XkgMYR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AiIHED9GlFrAEyw//PUCmS4gDiM/x0wspQ7Bg8kw5HgQTnXe2WHrZ2w3kGQCTEmOM
	 ZhFW19nAmdjeXCv54QpfRM8xMhe7I4FwHdJMW+/iukVSEdzD/T4D90hTwMYJGajs8t
	 EzA7LDnusqBK36LhzXy9RNS2k0ADctcKZENDq19o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfAISvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:51:05 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36330 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfAISvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hKyL4CfL7YSUjp0Dl0YOxZy+BWcnp2DvLGJ9XkgMYR4=; b=LkkGaiVCgD13wGa0Otq7kEuJP
        yTBDaI36Go73N4kwiEPCiVI35F9fF83OEewahVfGQOJa3ckr0NKPpmzB97kfr8JbFBtkQGbThsVe9
        vbewzbS2q/LU9OMCa+TAruCFWT//eyk6dVHj7kAv83mNutYQiqgcZEDUWSXd6jL61us0M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghIwM-0000ks-Mg; Wed, 09 Jan 2019 18:50:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 542661127528; Wed,  9 Jan 2019 18:50:58 +0000 (GMT)
Date:   Wed, 9 Jan 2019 18:50:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Code Kipper <codekipper@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Subject: Re: [PATCH v3 4/9] ASoC: sun4i-i2s: Fix offset mask
Message-ID: <20190109185058.GL10405@sirena.org.uk>
References: <20181221152110.17982-1-codekipper@gmail.com>
 <20181221152110.17982-5-codekipper@gmail.com>
 <CAGb2v649OVnaYNbZKPtBYkPHkFP13y201RZPTRauNsjiGQKwjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t5C3/nrmPumNj5sH"
Content-Disposition: inline
In-Reply-To: <CAGb2v649OVnaYNbZKPtBYkPHkFP13y201RZPTRauNsjiGQKwjw@mail.gmail.com>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t5C3/nrmPumNj5sH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 22, 2018 at 12:54:48AM +0800, Chen-Yu Tsai wrote:
> On Fri, Dec 21, 2018 at 11:21 PM <codekipper@gmail.com> wrote:

> > Also add offset to RX channel select

> Commit log seems a bit lacking. You could probably explain how you
> found this, either when comparing datasheet macros, or some actual
> error manifested and you "heard" it. You could also state what the
> fixed outcome should be.

> Also please add a fixes tag.

Plus send this at the start of the series so it can be applied as a fix
and sent to Linus during the development cycle.

--t5C3/nrmPumNj5sH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2QpEACgkQJNaLcl1U
h9A/2Qf+MpKvC1sDIcOBBmk7hZNPdkcZE5wlhCQAmahqcAdv8UeXEo+DGX8UwwtV
4DI7HFayI95aRYebTz5VK/W1noETZaQMciZ8eeqELS95MInDMhauwlioR0QlN90L
re/xxB9i+h/rGYomJenLE4UblW9FQ9D92bIudL7aSW+ysnEJFvptf3e6IVYwWGBH
Oh3H2N35iCCVsO45ex6Ra2k4h5/zDqz8jqM3MrlDN0AAb5OmT76HHWfiCNPTNZyU
hty4A7sssYji0nqfs3gB6UqJwK4eAxjGak6tmh5yHu02WXh+4HQjMMpnQfvYVdX3
RUFMDvm2f2KaEaljyksXH4Wml+pKAw==
=REGU
-----END PGP SIGNATURE-----

--t5C3/nrmPumNj5sH--
