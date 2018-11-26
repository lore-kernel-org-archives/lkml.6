Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5773AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1978A20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="bzY+Q1rt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1978A20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbeK0Dwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:52:32 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37298 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbeK0Dwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eEBAfq2DQYAvAjpFc9F+YFzdfKgRBH9w1tG5ETD0XtU=; b=bzY+Q1rtfBM8Pcjl0zYIggb3M
        UegrBc2BfQU3QM08UV4TluNXGNJha7WFckTHYeShCmBXfq52jKvwajxTWB5jMLJKPEiNV8jf4GYz5
        HzOnqFPUFAXDxi+zrsUpN9n0yB8pKuM6oHIz1vHg8Kol9eGVsCLQTcRbGXZ0uC4eHzpAo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRKCZ-0005PF-Bc; Mon, 26 Nov 2018 16:57:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DB753112519F; Mon, 26 Nov 2018 16:57:38 +0000 (GMT)
Date:   Mon, 26 Nov 2018 16:57:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Priit Laes <plaes@plaes.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH 09/14] regulator: dts: add full voltage range to LDO4 on
 the Lime2
Message-ID: <20181126165738.GI9715@sirena.org.uk>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <0b1aa5b28cb5efe17c04150a181ef1fa4027bc55.1543245984.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SdaPbLtAangIkrMZ"
Content-Disposition: inline
In-Reply-To: <0b1aa5b28cb5efe17c04150a181ef1fa4027bc55.1543245984.git-series.plaes@plaes.org>
X-Cookie: Gloffing is a state of mine.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SdaPbLtAangIkrMZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2018 at 05:27:50PM +0200, Priit Laes wrote:

> In the defense of LDO3, LDO3 is the regulator that feeds port bank E,
> which has no other purpose then a CSI/TS interface, however the case
> may still be, that the connected IO may be just as well be 3.3 volts.
> The big misnomer is however, that the schematic names GPIO-2 pin4
> LDO3_2.8V, rather then VDD-CSI0 or similar.

In general you want to run regulators at the lowest voltage you can,
this tends to reduce power consumption.

> Ideally, we want to set a supply voltage for each port bank, but the
> monolithic nature of the sunxi pinctroller currently prevents this and
> as such, the board should at least configure the LDO4 with the proper
> ranges.

>  &reg_ldo4 {
> -	regulator-min-microvolt = <2800000>;
> -	regulator-max-microvolt = <2800000>;
> -	regulator-name = "vddio-csi1";
> +	regulator-always-on;
> +	regulator-min-microvolt = <1250000>;
> +	regulator-max-microvolt = <3300000>;
> +	regulator-name = "vdd-io-pg";
>  };

This is obviously broken even according to your analysis above - if you
have consumers for which 2.8V is too low allowing other consumers to set
even lower voltages is not going to help as soon as they start doing
that.

--SdaPbLtAangIkrMZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv8JgIACgkQJNaLcl1U
h9ChRgf/clrFo+5K7x0k5QWpV6PYmm8qGgoo8qB0vUwTCVr+WUf8MhjYsXuxULU7
EeUU0PVw+uepX1rpIZdPOGhfZ+j6BAYxQRiqm1T1mGtf8IlnQA+Tc1Yglf6ukLzs
11XdUj6xUXGQlqqghkJzN2UeDmkY/ldfpniY1endz7B3NNuGPuhjzmieDFp+o/NU
VnIHkDhDal5Iwg5Vb0f3iGKLlVnQFXpDtAKj/c9CBA0jHgWZmZgmiUC46da68eEz
dF10grh1qJZcWfrhPz26/b/l+epQTOEamU0H4jnfIxcsLxtsT2xYRKG7jxlQOtzZ
PW4lHjBRebLGl2z7PwEGh7oU9T/3Og==
=9htB
-----END PGP SIGNATURE-----

--SdaPbLtAangIkrMZ--
