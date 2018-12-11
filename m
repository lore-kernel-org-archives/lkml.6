Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC3C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBFF20855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544546841;
	bh=m1H4LsR9P96rDdiaaJZaHH+v9Rn/w1+E+NbTZTtFieI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IU7IOT1q2yd0v+k5Gg83/fiIka1GlkJ2kSDvlp9BZ3Cy8Tsi0YKMhfQ9Stv5cJmvt
	 sA+xGE71P4I2qVEkLqGGitozRL5UrJvT8jcznjMGUR7V9MN3ZmeVyYUqAutRduRuG8
	 h5lmVVPac7jg1ZkOPv/fwVdWWf9HEDrWKmcggr3U=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BBFF20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeLKQrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:47:20 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60430 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeLKQrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xqiz+wkFzBYV7aW60asqBnJ9KnKUJwPszxanHWrGxeY=; b=m2A+jHn1sFFHKLdIKuazg5BTX
        oRntLbzTEhwG9b33OHcpp5wC0J8DmM1yQOAoxcKo+6h4QaYG3urs83jcv1NsmT0GRAeq0qzUG+IbT
        5XHq7cpmzWnH2n5j7ApXIN3xvQtIR3OtrxnO5qtRq/yNfIz9Os2epEwRdjd40sGHmJA70=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWlBb-0001Gg-0Y; Tue, 11 Dec 2018 16:47:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 76B69112540E; Tue, 11 Dec 2018 16:47:06 +0000 (GMT)
Date:   Tue, 11 Dec 2018 16:47:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andrei.Stefanescu@microchip.com
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, Cristian.Birsan@microchip.com,
        Nicolas.Ferre@microchip.com, Claudiu.Beznea@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH v3 3/3] regulator: mcp16502: add regulator driver
 for MCP16502
Message-ID: <20181211164706.GL6686@sirena.org.uk>
References: <1544522876-15967-1-git-send-email-andrei.stefanescu@microchip.com>
 <1544522876-15967-4-git-send-email-andrei.stefanescu@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="umrsQkkrw7viUWFs"
Content-Disposition: inline
In-Reply-To: <1544522876-15967-4-git-send-email-andrei.stefanescu@microchip.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--umrsQkkrw7viUWFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 11, 2018 at 10:09:15AM +0000, Andrei.Stefanescu@microchip.com wrote:
> This patch adds a regulator driver for the MCP16502 PMIC.
> This drivers supports basic operations through the
> regulator interface such as:

Overall this looks really good, just a couple of comments:

> +++ b/drivers/regulator/mcp16502.c
> @@ -0,0 +1,555 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * MCP16502 PMIC driver

SPDX headers need to be C++ comments - please make the entire comment
block a C++ one so it looks more intentional.

> +#ifdef CONFIG_SUSPEND
> +static int mcp16502_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct mcp16502 *mcp = i2c_get_clientdata(client);
> +
> +	mcp16502_gpio_set_mode(mcp, MCP16502_OPMODE_LPM);
> +
> +	return 0;
> +}

This puts the device into low power mode when the suspend function gets
called but this might not be safe - devices using the regulator may not
be suspended yet so could still need full regulation.  Normally a GPIO
triggered transition like this would be being done by hardware as part
of the process of suspending the SoC.  Is there some reason to do this
manually?

--umrsQkkrw7viUWFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwP6gkACgkQJNaLcl1U
h9BHwwf/cHsTUWUp5ToG+Kb4Fuv/H6ZxHsx3rArRbP6RrZs8AcV8P59bDdcVWgjQ
Jvrzl5wA1njl0bXYYCyNXWAsApqj5396NAHrZJhzpjYDTZu8rLQnqpJoyHsc6nUJ
UptK/vhhmZEH78iiEqBIUcQY/JzYxz4cC3iVl24+O3l30AvbrHiXeMALUGr1fJ80
RutTjPkvA67Gq1ogrfhy8IALDzFDGM7bX+Xe4jha//+23lf1f8HRTCXf3dMydP0A
Lk3z/8C4Dz2p4c7GZZMzwhjKrsp7AVGIH29SX0BAvM9cp6EnTv0B2l1xLQv3oXV3
OAviYfR1XwagJG5wcHyko6KGnNSjtQ==
=9bae
-----END PGP SIGNATURE-----

--umrsQkkrw7viUWFs--
