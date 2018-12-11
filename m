Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F713C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338792081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544538501;
	bh=6aXJrcMpRlRT+9JvV7pJjE0NWDf6ITjoZLOQYLAgM0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RcOgy3no1yclevMKebYtTGVG/xoJkuB4qgRs+UjysIPMjYGA45NqZ0SNYPPukEya3
	 srOsODAE35Jjt5+2U3QIpy58qIBePQkkn8W8Yr2X9nSTKF2bLCmaFr4coEWfQ1sE+3
	 VlbHl/IAgo3eV520iH/VBBnbKnxrOB4Kv5KWb3oo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338792081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeLKO2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:28:19 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53230 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeLKO2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eJMg1EdD5ghc/VANBZV0ZjbAZFefCTFm/2NK5Hw1XcU=; b=ffReUY6pjkygnqPQvL8rFED+o
        nl12WAiklZ6FbGRr2jb/3D6PlUn/OxLRwMM5woTCVdSHSHSXdz8xino3XpkUCNTGF8ygXPfeWfaYS
        6tSSMbykuknw0n/MrR3r0FE5WEdwtERSGZ1c30FSSU1WE67cCd5wrsc7z5TyG96MKvL20=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWj1G-00017K-3c; Tue, 11 Dec 2018 14:28:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C888A112540E; Tue, 11 Dec 2018 14:28:17 +0000 (GMT)
Date:   Tue, 11 Dec 2018 14:28:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: lpspi: enable runtime pm for lpspi
Message-ID: <20181211142817.GH6686@sirena.org.uk>
References: <20181204061904.28567-1-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tcC6YSqBgqqkz7Sb"
Content-Disposition: inline
In-Reply-To: <20181204061904.28567-1-xiaoning.wang@nxp.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tcC6YSqBgqqkz7Sb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 06:19:48AM +0000, Clark Wang wrote:
> 	From: Han Xu <han.xu@nxp.com>
>=20
> 	Enable the runtime power management for lpspi module.
>=20
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Reviewed-by: Frank Li <frank.li@nxp.com>
> ---

There's no signed-off-by from you here?  These are required, please see
submitting-patches.rst.

--tcC6YSqBgqqkz7Sb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPyYEACgkQJNaLcl1U
h9A9Uwf/aUuyT1NOiWcTUqBmy7bH6x49cZHklJMQKrGTKmN83W4CdGSTprqBjzf6
RczLCUfy+L8uTXtl7M7ZOu8tyBZf59G5amhjI5QDhtmhoTMqjz2iLLIEyFdC8ylp
jPrp+anLGApxfMLAmNzcTdlf2I+1ONvf6TDYC4TZWH++MOW562Sa9vN2bOx22thf
ps/awOEY0M2oAzK/y+SILaliLLr+ilJooqF6iDOstXNAFN9ZL2KxZTgH/a7clHzo
9isM6zV3rDdB2wn3s2e4TKb5g9dQSCNDv93TgyQJ6bL/Su2qFRa8gGXS5oBEvWbu
BjH9gg366MsrybCXyV7kXIfCgqpj+A==
=4naq
-----END PGP SIGNATURE-----

--tcC6YSqBgqqkz7Sb--
