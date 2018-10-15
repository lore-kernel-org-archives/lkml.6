Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D446C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB7D204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="RryXLG70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB7D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeJPAlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:41:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33052 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeJPAlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KKqd6PUx/B91ioDUGYSY2r+lknaGXet/5wZ5Q9ZiPng=; b=RryXLG70OWgHyXWPSRbio7aGp
        GtLCAlCUX8GrIEka79Cku9x8F4EETD9qWXgtA7mElH+vbMAyWGQ0BiGPFGta2J+7P8Jty+3eEF9Fg
        7LMW/Kpf7vwHQlirZjcKxNwbr/VMnCXuIJRo4SX0r2L/S5UF/YfcoIw4ZpBhhvM8jhtl0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gC69R-0003aV-Fw; Mon, 15 Oct 2018 16:55:29 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C6E4011224A9; Mon, 15 Oct 2018 17:55:28 +0100 (BST)
Date:   Mon, 15 Oct 2018 17:55:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        lee.jones@linaro.org, linus.walleij@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 3/5] clk: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181015165528.GD12949@sirena.org.uk>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-3-ckeepax@opensource.cirrus.com>
 <153924124658.207691.10370075148426001371@swboyd.mtv.corp.google.com>
 <20181011132602.GD1653@imbe.wolfsonmicro.main>
 <153935999691.5275.1587207165396958375@swboyd.mtv.corp.google.com>
 <20181015104905.GF1653@imbe.wolfsonmicro.main>
 <153962159992.5275.9275448716859702011@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qGV0fN9tzfkG3CxV"
Content-Disposition: inline
In-Reply-To: <153962159992.5275.9275448716859702011@swboyd.mtv.corp.google.com>
X-Cookie: Kill Ugly Radio
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 09:39:59AM -0700, Stephen Boyd wrote:

> Ok if there's going to be read/volatile regs and defaults then it makes
> sense to leave the defines in some shared header file, which is
> unfortunate for the independent merge of driver bits. Either way, I

Kconfig dependencies take care of that pretty well - if there's a
dependency on the MFD then the function driver just won't get built
until the MFD gets merged. =20

--qGV0fN9tzfkG3CxV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvExn8ACgkQJNaLcl1U
h9Cm3wgAg68zzKd/x3cvsnLK+nLQu7ZH+s4qIBqCK+IZxuyQrrt22j+bCIyr1g7X
+oydMFZWxBkys3SvNyBAl+NF61lUhSsrrrmf6qc1RWdsIYAH7O9YFwKWQB6KiJnX
rroyNjAogqw/6vlI/VaOQ7nbWz9qjnyQDAgfgcxkNKL+EeLu2viJwiyCiU6Ybi0F
GUSIWcK9m/ha8HitOmrc0OX/TMykmiKPsWS3F3XgdLI0Spv91QOwd98dK+EAjhS7
nXdtijJMvFVIxFUngCmxPLOAJhkuj2fburxVSH/rgGlRx3eRYLPYjsKn4UO9WU+Z
0ZkKYkYeqinWW970tKk/qicJ+FCEGQ==
=kjjT
-----END PGP SIGNATURE-----

--qGV0fN9tzfkG3CxV--
