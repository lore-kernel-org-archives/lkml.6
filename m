Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE46AC4151A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BBD214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548774790;
	bh=vEHT+0rikjtLXsx1UO3ta+tTTLIVyGSKxbMBMeNr0Qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QEdNiMW6q1cCjPPHXoiaYfO3Ox+jnxUQU5mWnXsQlUC+7vox7S8pX0cpfk6APdZlQ
	 XMlCFa5OE7IlzgMislPzD7Bu6WzRmvL/yuMaSf59AQPai1Asicy5eMxZ6QLNbOZN92
	 agXlpk62FUItLiVhXfS24fMY+N8PktD8YFWqp4pI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfA2PNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:13:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41366 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfA2PNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2ab61Ucv4TZdNzr2qrI1pTdorm/SpkcZzp3RVh0U87E=; b=BW8nSzLbVYx6KvzV+hRkSlMWx
        yvvFAddCNAFVbdV54BkCgatacjJkCT+tb3nBh3oCRfp83qTbgSpvk7tcKFKVfx7DoRW5ckNsQLNZ3
        YC4LaIyN32D6+67c2CdPnmK9yr7EbE2lqVB0XhQUGO/Now2YmScelurKmjCSbdUPdBV7g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goV4L-0000F6-7n; Tue, 29 Jan 2019 15:12:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 978111127D50; Tue, 29 Jan 2019 15:12:56 +0000 (GMT)
Date:   Tue, 29 Jan 2019 15:12:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     robh@kernel.org, arnd@arndb.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        benjamin.gaignard@linaro.org, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC v2 2/7] domainsctrl: Introduce domains controller framework
Message-ID: <20190129151256.GD10524@sirena.org.uk>
References: <20190128142313.17036-1-benjamin.gaignard@st.com>
 <20190128142313.17036-3-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Content-Disposition: inline
In-Reply-To: <20190128142313.17036-3-benjamin.gaignard@st.com>
X-Cookie: What foods these morsels be!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 28, 2019 at 03:23:08PM +0100, Benjamin Gaignard wrote:
> The goal of this framework is to offer an interface for the
> hardware blocks controlling bus accesses rights.

Reviwed-by: Mark Brown <broonie@kernel.org>

> +static int __init domainsctrl_init(void)
> +{
> +	pr_info("initialized bus domain controller subsystem\n");
> +	return 0;
> +}

Not sure if this print is really helpful?  But that's very minor.

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxQbXcACgkQJNaLcl1U
h9BhlAgAgtnMG3VwPygyUGhKoxtF8lC8VpQc0oSSGDZjdS8oehhCkd76c6Cw1dLJ
3xHiKpAMDIAloKGN/HyhWpAyHWS0nMXy+/8HyQyWtYD2/FvbkMPRZC8AXoIv82rj
6Z2c+LW55y9jeogvOFbnvkAwbijIvnAtMBeZF89Xap0wDJqFWL9v4PLs+ckoTBwf
o1DVmxdVzLtGo1QEuhOD6JsX8EV+Hr9e0MHXbzSfMVnuiaZ38GMWNTZxCAn6NvW1
SDI3T41Key1APDYGEJqLaXYCmlFq64IGyRtxbFZAJ2ZlkStKtnGLW7y+fzcQSiZf
hMAKI7jtujN3AG3pC6WVDVqhOvqPLQ==
=VPVA
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--
