Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1ACC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C13A20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="N3escDGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C13A20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934189AbeFRLQV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:16:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56138 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932762AbeFRLQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6zBiVaaY1ysWTa0Cy8mM8IYCJ4wH7kKzsq3Os+GP32Y=; b=N3escDGxACoxQVhHo44poHIiq
        CP1+Of+FaK/YlBurI7rqMiywpXTIflJM4pG5Py6gvnZ3UAUyjcl3jt54nmghUTvenCQ84ElAINi5+
        eN5wJJG+HT2dTCUbm5kfzc3hDCS5RuHF5vpqffoT4YUEDr4baaYb2c/UWFCy8DcPeiXZc=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUs8G-0007ul-Hv; Mon, 18 Jun 2018 11:15:36 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUs8G-00066t-25; Mon, 18 Jun 2018 12:15:36 +0100
Date:   Mon, 18 Jun 2018 12:15:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        kernel@stlinux.com, linux-kernel@vger.kernel.org,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com
Subject: Re: [PATCH v2 0/1] ASoC: stm32: sai: add iec958 controls support
Message-ID: <20180618111536.GB6928@sirena.org.uk>
References: <1528730039-15757-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <1528730039-15757-1-git-send-email-olivier.moysan@st.com>
X-Cookie: May be too intense for some viewers.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 05:13:58PM +0200, Olivier Moysan wrote:
> Changes v2:
> - Remove iec958 helpers and implement iec958 controls in sai driver=20
>=20
> Olivier Moysan (1):
>   ASoC: stm32: sai: add iec958 controls support

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsnlFcACgkQJNaLcl1U
h9COmgf+NZeQhx8mEwgNi61ycoyHKgoTRSLM/VDnAu3vrL186K5ShnXF6INDoZVv
CbgkTlKnRC354vn+fNMWR0bAuwRznhyDNObMlprS6RRk2O2nW8Z7f0j2LTZ5pJ1M
IAIh4yhBFIMYSsYO156zJL0LNlQyw4CPepH28RA8eJDhFcE4SLl10O5yCyTnkvmi
MW/C+J3KrSk2gjGS2JuGQ7aB2rzZuMp8JcqpXgkIx94RjwijANhQtI8MlnEaenV2
HmjkxHbP8bcyKVuOqLvQvIUEImv0+L3gPOv6Vu5TkytIOIDPBcI3V55RXyQoXdT7
tTxtAC+EO+4ovA2r/3MhUC0uEV113Q==
=2A+u
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
