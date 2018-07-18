Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368D8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77182075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ukLghFje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77182075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbeGRMrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:47:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45148 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeGRMrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LatI17vz4TK4WwvGKzJoJD77t5X/722u/cju52lS4eA=; b=ukLghFjeroZjOmkPBp0u+Tajg
        NXXdQWz97AUcqyEupog+SxpYMIydsFqi1b2+0wHC7nK5QTxVSRjhDYWkyaWFEBT9/bep8EIPmeSls
        vMcD3Rpv296I5mWUBU7uxuYSMb5nVJmDiwGv3U9pJhfdfOjkOfrem7TmcnOzKByjNnf1s=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflH3-0003Tj-Gw; Wed, 18 Jul 2018 12:09:41 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflH2-0006Ko-VO; Wed, 18 Jul 2018 13:09:40 +0100
Date:   Wed, 18 Jul 2018 13:09:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        fabio.estevam@nxp.com, Anson.Huang@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: pfuze100: add optional disable
 switch-regulators binding
Message-ID: <20180718120940.GJ5700@sirena.org.uk>
References: <20180713125002.24331-1-m.felsch@pengutronix.de>
 <20180713125002.24331-2-m.felsch@pengutronix.de>
 <20180713150314.GD16228@sirena.org.uk>
 <20180716072516.bvsp54yoeqp3ih6s@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cDtQGJ/EJIRf/Cpq"
Content-Disposition: inline
In-Reply-To: <20180716072516.bvsp54yoeqp3ih6s@pengutronix.de>
X-Cookie: Remember the... the... uhh.....
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cDtQGJ/EJIRf/Cpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 16, 2018 at 09:25:16AM +0200, Marco Felsch wrote:

> You're right, it sounds better. So the new binding will be
> fsl,pfuze-support-disable-sw. Are there any other comments about the
> implementation?

Not AFAIR.

--cDtQGJ/EJIRf/Cpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltPLgQACgkQJNaLcl1U
h9CNGAf+KyZTRIbtIEJpwP6fpCPerRwJg+kb+qUhwJrfZAl1u1WNNyH0V0wiBxkX
40DJWlE6BHQ2NFa8myq2UY79lfaVaCRiKBI66mBe6dcRThiBnJemhuaDurdlb72Z
rgSQHyBqSjpIX9rv086giYGvPohpBl/Q4jptGcU5RwGszgH3gq5ZCcLphAGDKQht
XRK35Bi/dRHVxd5+QaLLhgNhf6ZI73zblN+5ZAD9TPtP1hDhcGERun9ivvcwzq4+
8UQl5cj0b9/ALsnUe77NLV/jy9Sq1H6TjbH64IFHyLXJFJJkDhdfO31N2turugX8
NX2q/58oPXtg1/Ak0s51nkipaLUyeA==
=7bBP
-----END PGP SIGNATURE-----

--cDtQGJ/EJIRf/Cpq--
