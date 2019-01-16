Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B057C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2994620675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547659826;
	bh=HVXK5pX6jfwzGFegE5CjD6E5XZeyLc0GJv6qpY+9q+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FQIcyNTvyc4S9MGN5S8dAhewnGnqbvKfwm2qQiEUeZpnO1E2GQnvuvopAlMrSI37Z
	 851ZGp7zDYRjXTV3Csa4YZEOck8+7K0FxVNOrr4ze95yFI5udJhQR/7zP8t2wsynAL
	 6LJ72Whhy9AlxqSjuuhv4tlRbaGQvTHYe9/AUkMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfAPRaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:30:24 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50500 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfAPRaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HVXK5pX6jfwzGFegE5CjD6E5XZeyLc0GJv6qpY+9q+Y=; b=prppcnTlG8dH9T0zqyeH9bGE+
        lhaFQUdZn/AkHOzYENTMwtfEsZ1U+m6Z6w5pTh6alIT1ZXzTnqfFfX/s35/vgN1AGnurMsgjelVSD
        6CzZGNt92xpv7PXJXmVumZAZbqik5cvmwz6zdqEsZWJsvPmfaIDE0L1fGAvdJM2f+E8e0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjp19-000266-5P; Wed, 16 Jan 2019 17:30:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5E6481126FFD; Wed, 16 Jan 2019 17:30:18 +0000 (GMT)
Date:   Wed, 16 Jan 2019 17:30:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     robh@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        loic.pallardy@st.com, benjamin.gaignard@linaro.org
Subject: Re: [RFC 1/7] devicetree: bindings: Document domains controller
 bindings
Message-ID: <20190116173018.GD7186@sirena.org.uk>
References: <20190114144202.27315-1-benjamin.gaignard@st.com>
 <20190114144202.27315-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
In-Reply-To: <20190114144202.27315-2-benjamin.gaignard@st.com>
X-Cookie: Help a swallow land at Capistrano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 14, 2019 at 03:41:56PM +0100, Benjamin Gaignard wrote:

> +Common Domains Controller bindings properties
> +
> +Domains Controller framework defines common bindings properties to describe
> +the configurations to be applied for each device.

I suspect this is going to need a few more words about what a Domains
Controller is.

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw/aikACgkQJNaLcl1U
h9DAlwf9GIk6jp2btSb+YYZXsv2dTL5t24Z/wDnqreIA1Dxymv/Qd46FtTOF8WIk
s4khV0+j60zmYiDMBmEDx7358kVv9lRo5ZzspLBLwkIKKDCbhl5VxfhDwo5qpukw
DrJse22kDheT3jTyu7W2CfIT7DR/I5UkLl3CDGuiRTSKOxYh81g9C3SjfEH8ZzMo
oBlf3hf3XMvyu00XFlRKG/MafuF0WsvzTanzSl0+N0PmRw6HfZ2Q2c37ud3+axMW
+P+hM/+mK2HjlXl6vW4jR74MDWJwfPL8yCCT7tWqvBuCA1guISm/H9KOrmIWsJln
wPNTS1yehT+rlOLZNPYV83Xo7P0OuA==
=6+jP
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
