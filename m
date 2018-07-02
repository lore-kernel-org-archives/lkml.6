Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48303C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D852548E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hmFVbvWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D852548E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbeGBQNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:13:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58582 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbeGBQNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AUX0mMzck7DD8EWxUZJU7Ccgy2J0C4DmKWDcL4F2xDE=; b=hmFVbvWXuyMIOLtZBJPBbLAMW
        Gpsr9wxLGNNBMwCLfXvi0AulMb+lDbfFsa8LurTHQCNkV6OSa3qp5FKU/JRPYLypgZ1ZUhIDIGtZI
        7AP2UbHIYwM88byqSyNTMaOl1jAysZwUq7uA+t+iT8Zwl9TcfDfw4WmotkOUxpa6lQcOE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fa1Rj-0004gY-KL; Mon, 02 Jul 2018 16:12:59 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D1013440073; Mon,  2 Jul 2018 17:12:58 +0100 (BST)
Date:   Mon, 2 Jul 2018 17:12:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        Michael =?iso-8859-1?Q?R=F6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Steve deRosier <derosier@gmail.com>, linux-spi@vger.kernel.org
Subject: Re: [RFC net-next 15/15] net: lora: Add Semtech SX1301
Message-ID: <20180702161258.GA18744@sirena.org.uk>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20180701110804.32415-16-afaerber@suse.de>
X-Cookie: Eloquence is logic on fire.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 01, 2018 at 01:08:04PM +0200, Andreas F=E4rber wrote:

> +static void sx1301_radio_spi_set_cs(struct spi_device *spi, bool enable)
> +{
> +	int ret;
> +
> +	dev_dbg(&spi->dev, "setting SPI CS to %s\n", enable ? "1" : "0");
> +
> +	if (enable)
> +		return;
> +
> +	ret =3D sx1301_radio_set_cs(spi->controller, enable);
> +	if (ret)
> +		dev_warn(&spi->dev, "failed to write CS (%d)\n", ret);
> +}

So we never disable chip select?

> +	if (tx_buf) {
> +		ret =3D sx1301_write(ssx->parent, ssx->regs + REG_RADIO_X_ADDR, tx_buf=
 ? tx_buf[0] : 0);

This looks confused.  We're in an if (tx_buf) block but there's a use of
the ternery operator that appears to be checking if we have a tx_buf?

> +		if (ret) {
> +			dev_err(&spi->dev, "SPI radio address write failed\n");
> +			return ret;
> +		}
> +
> +		ret =3D sx1301_write(ssx->parent, ssx->regs + REG_RADIO_X_DATA, (tx_bu=
f && xfr->len >=3D 2) ? tx_buf[1] : 0);
> +		if (ret) {
> +			dev_err(&spi->dev, "SPI radio data write failed\n");
> +			return ret;
> +		}

This looks awfully like you're coming in at the wrong abstraction layer
and the hardware actually implements a register abstraction rather than
a SPI one so you should be using regmap as the abstraction.

> +	if (rx_buf) {
> +		ret =3D sx1301_read(ssx->parent, ssx->regs + REG_RADIO_X_DATA_READBACK=
, &rx_buf[xfr->len - 1]);
> +		if (ret) {
> +			dev_err(&spi->dev, "SPI radio data read failed\n");
> +			return ret;
> +		}
> +	}

For a read we never set an address?

> +static void sx1301_radio_setup(struct spi_controller *ctrl)
> +{
> +	ctrl->mode_bits =3D SPI_CS_HIGH | SPI_NO_CS;

This controller has no chip select but we provided a set_cs operation?

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls6TwcACgkQJNaLcl1U
h9CtNQf/ZkgI4m6ipAehhMLl5FnfWF06bpi2CDPHl+6Cz0LgN9Qnfs0oqOGo4Zb/
Y6/6bRwMLButsPy07H9JjgbDdDbqGvXamBcDEr2QUpituYS2FBgGCJKxS09beCw0
sYsYVbTKu92JQbymL8/Ps8vU2l8GsUTvg1gZfLwiJq7Crs9x18j0HQSW6QOuPVLI
eFhv2kXtoi30yP+HUc2eRYtQEf0eoY/V46h57YqdqeJQDbHILKDLq1Fstfd/8gLR
BQLiCdKDRKPuc4qCMC7lrSQFmTTMFdoF9HxC9R+afZCrT/TUWLkAhDCz+b8OwMlD
GrQ/DQFX0ki2DD7Eb/HMqIk4+gmYWg==
=dmQR
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
