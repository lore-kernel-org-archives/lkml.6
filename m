Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029A7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BA32173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546874208;
	bh=FTopHKsyZZq5J+eQYns/K/VkSfZf7jXsYa9LpcFike4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hkKfr6iLszye8/QBgLzAkZulPE/KaB5Oe3QuXcefIHEMHUTbvgARPiPWX3f32i7A1
	 /8GzQDRl+HbdQ/ykGgGQwHNrsyWFPXMPBiK+cIFRatYnXVmd9vsH9Nw7YKhZ4rv2A1
	 GC3nleqTSVtAD52qZNASbAo/MJXldMQfbJ7qNAd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbfAGPQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:16:47 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35886 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfAGPQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PeIU4C8XE0tjq1MONnh5+yetWgruaOvFtOH5rxScz7A=; b=CfsS4kuweTasuQhz4rmXaQ94h
        2GWwptQ7TggkndBZtTDx5ufQFQ6e3YeTKOY85rbqkvwXz87BXBF8d6iMsxw+RJmr+w0ecaTYk68fL
        apI2ER37P4FfkrWCWT6oXZaIokIiIX6o4HkpPTPWDl4UtEhrCaYM5kyeEXK1bgckKv0hE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ggWdx-0007Nq-Bc; Mon, 07 Jan 2019 15:16:45 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EB31E1127491; Mon,  7 Jan 2019 15:16:44 +0000 (GMT)
Date:   Mon, 7 Jan 2019 15:16:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] spi: lpspi: enable runtime pm for lpspi
Message-ID: <20190107151644.GF9570@sirena.org.uk>
References: <20190107074639.6336-1-xiaoning.wang@nxp.com>
 <20190107074639.6336-3-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Content-Disposition: inline
In-Reply-To: <20190107074639.6336-3-xiaoning.wang@nxp.com>
X-Cookie: NOBODY EXPECTS THE SPANISH INQUISITION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:47:36AM +0000, Clark Wang wrote:
> 	From: Han Xu <han.xu@nxp.com>
>=20
> 	Enable the runtime power management for lpspi module.
>=20
> Do some adaptation work from kernel 4.9 to 4.14.
>=20

Looks like the changelog here is a bit corrupted (extra indents on the
first two lines).  Otherwise this looks fine.

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzbVwACgkQJNaLcl1U
h9BgiQf/TxYC4kzpAN+XNk0wXcUXulbeQs2Unm4UOD7dtAV+MNcPq/48MaJsatB8
mMnCNSauEqNlpsnElVDbhxclS/MSdck0kygy3QMjPFJF6tHaignlQyn9FqlaJ3js
LkgA9Tan/M3+crCTOzhLwfBkUq3hZEPbC4XE+4cfuT+YER/UFZAX/7CREXo878JX
5ZpSO0ThCQBhTh90hBtdh1SKNifWSHuBoIPDJ2C5RvdYAQcOtOzPPOM6Zna7jMOK
oE1ism5D/KMZg+rhIYv7HvBUJGzHQ6LEEe3PAeNUtL9qVnkJVMx+LkO5RFiTOIzn
ixSYla4IBrpluRNyioXlbhIFg38YTQ==
=7hYB
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--
