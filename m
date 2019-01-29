Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C2BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD30F214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548774862;
	bh=Kxe6B1ZPPpK71Dtzz77SOfIh1bqQtnCe+lYOVpujU4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D8wtaajEJsWTqK4eOgVUZ9B2802yYwvxSERdoz+mVrxDPf5+mWSeLOx7f3YFfFMK9
	 fstxdTIa6VB5C5as/sHpju6byFHEEZJw2RojGKHPFqGym98h4JGVyc8T1G207rjUJl
	 al2TGjVCZCkvTkf7sW77WeiMmNBbDCJ0gDTaj7U0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfA2POV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:14:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43370 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfA2POV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Kxe6B1ZPPpK71Dtzz77SOfIh1bqQtnCe+lYOVpujU4Q=; b=LUrQPK8YBqfjFaCnJhRCmlY0V
        3sdLZPltOS9OshuAmYBBEUgXWO3bXnARopu/5Aed4jbhEmGl38ZePM1wZfz/AMRe7yXEY9ttzIVuw
        EuI8trLdZC+7xCBtr9COdgwDH+8nX/dg1seJskZassCv6JQxql4QBP/SDyvMJjuGffDbY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goV5Y-0000FJ-Rx; Tue, 29 Jan 2019 15:14:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5F6C91127D50; Tue, 29 Jan 2019 15:14:12 +0000 (GMT)
Date:   Tue, 29 Jan 2019 15:14:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     robh@kernel.org, arnd@arndb.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        benjamin.gaignard@linaro.org, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC v2 3/7] base: Add calls to domains controller
Message-ID: <20190129151412.GE10524@sirena.org.uk>
References: <20190128142313.17036-1-benjamin.gaignard@st.com>
 <20190128142313.17036-4-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline
In-Reply-To: <20190128142313.17036-4-benjamin.gaignard@st.com>
X-Cookie: What foods these morsels be!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 28, 2019 at 03:23:09PM +0100, Benjamin Gaignard wrote:
> To avoid modifying all the drivers call domainsctrl_set_default_config
> before probe to apply the configuration define in device node (if any).

Reviwed-by: Mark Brown <broonie@kernel.org>

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxQbcMACgkQJNaLcl1U
h9Cl8wf+JpsNxX1JRVEl2fJvIehYJu5fP2mrjIUJhnGmIvGCBw4Nw6NQ0irTqQhI
nOuxPifbFvi041T5us1no16XSaIgdcT9wMI9pKw3B9rFH2oDhUXaE3/+1D12feHg
ywFA7juUqVw29kLsY8Njy8o71K4sn3rdIoirQnobfRBXazVJc6AI7NcJYt93E30a
tBXHC0QI+Zod3dohU95E5TH5krm3nMDm10k59Gg65Nkfm5HNHvZMVNjbv7fBPruF
gFmFK7YFc1pTmrgE8kz03xWABPCfFKSAldjIgPGoKCcy/DOdFzQxT2OszgsdOKxv
HUdieELD3Rjsroyq6uk70KwpXSNZGA==
=YpV9
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--
