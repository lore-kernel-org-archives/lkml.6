Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9018C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9263521019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548183180;
	bh=1lEAf8unMSd7hE5cVzkXyNRju/fHj7qR8yiLJiUsIDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cwUu3lHZVjWjYfjntKIlkiULorvfaViFTUMF3NulQP+JcU/cdGDGIYdZ+u98i0xT4
	 CDEuFe3DXNKdyQTQ7eQp1EqMujOtRaRfDDAIimb9EINnTzZPfzwUuVDTy0X/zkqeR3
	 QGKBp0ob9ROyWCYoyeOqbGG6qAG0c3uq44r5UWgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfAVSw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:52:59 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36128 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAVSw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xIPX3mjSlA6H0JHcH1b1RhTEiV0EKez9LY2mfnZLQqk=; b=JyyHdeuymCGolBTAvGFuw1Ab/
        VobXz+wsC0kOPEGnCPWkPAFrzFKXuSEZPYO2rosqdiZ7tq0vn9Hk8YxBmQAKFaWNoHdZQ323yGyy2
        OCwirnGUl1wW630whhuV6T8EawhwtDVuU1WywQ4JdzWvqY4fHokM1iUG3RAnN7Wk7wL14=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gm1AL-00076Q-SJ; Tue, 22 Jan 2019 18:52:53 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 44E8C1127955; Tue, 22 Jan 2019 18:52:53 +0000 (GMT)
Date:   Tue, 22 Jan 2019 18:52:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v5 4/8] ASoC: wcd9335: add basic controls
Message-ID: <20190122185253.GG7579@sirena.org.uk>
References: <20190110150616.2332-1-srinivas.kandagatla@linaro.org>
 <20190110150616.2332-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aZoGpuMECXJckB41"
Content-Disposition: inline
In-Reply-To: <20190110150616.2332-5-srinivas.kandagatla@linaro.org>
X-Cookie: Truckers welcome.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aZoGpuMECXJckB41
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 10, 2019 at 03:06:12PM +0000, Srinivas Kandagatla wrote:

> +static const char * const wcd9335_ear_pa_gain_text[] = {
> +	"G_6_DB", "G_4P5_DB", "G_3_DB", "G_1P5_DB",
> +	"G_0_DB", "G_M2P5_DB", "UNDEFINED", "G_M12_DB"
> +};

Gains should be controlled with Volume controls, not enums.  Provide
information on the levels via TLV.

> +static const char * const rx_hph_mode_mux_text[] = {
> +	"CLS_H_INVALID", "CLS_H_HIFI", "CLS_H_LP", "CLS_AB", "CLS_H_LOHIFI"
> +};

Is there a strong reason not to use more human readable strings here?

--aZoGpuMECXJckB41
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxHZoQACgkQJNaLcl1U
h9BKogf/cHTbAkrXyBIsX9olDNCF8Z6O0NaQkWFjxGL+8D6Yi8ZalJDFOLw3VNtJ
Gg8c4Z7mNOuSQzSvvZ9u+P+YnZP5Tn+iCHNoe79sz0tjQyobpB1aupFTdiUXHEJn
c2FpxhLnL3jPsNeCzp6HjR6sKR4bnEdNGFVJd1b+9uYliNk3OyDTbW2/dkBuJnak
fEOLNNtJkqgBI3vL4se45mJMr4adjK8idoZyHKyGE+a9D03uwZfNEKdZoR7VBobY
QB4fNWoTqjQ0xkygqw9xsYi7tEQhZv6UaWjpECdIOEQHeylY1VINCOZ3d+cFW8hB
Fu6yB3hzUAYk6y3TOZd3rh+OAmh6yw==
=V+s0
-----END PGP SIGNATURE-----

--aZoGpuMECXJckB41--
