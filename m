Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D636C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AEB24053
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Tcqj3bzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AEB24053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeGEQyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:54:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37140 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753919AbeGEQyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YQ00uoLgzZnTT365Jsi7MUk5ib9mZCqivq1upeaqcGs=; b=Tcqj3bzpWvL5EAO60Oy7EJsg2
        sjlu4U9FSGpjF0RVZHIAltw+7OLmc/8v16QLhWmsUeAA5YrMv66h6zjuN5qezy6F6c+29/XEBKlvh
        Jhfih0IAGjn/UiLtpGDxerfFeBNAcBkkbAmGjbF+byngwvabt9DD8IklzSG7EOiVz+6Uc=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb7W6-00010Q-RD; Thu, 05 Jul 2018 16:54:02 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb7W6-000813-DE; Thu, 05 Jul 2018 17:54:02 +0100
Date:   Thu, 5 Jul 2018 17:54:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH 1/3] driver core: Add device_link_remove function
Message-ID: <20180705165402.GE6227@sirena.org.uk>
References: <1530800748-7300-1-git-send-email-p.paillet@st.com>
 <1530800748-7300-2-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Uwl7UQhJk99r8jnw"
Content-Disposition: inline
In-Reply-To: <1530800748-7300-2-git-send-email-p.paillet@st.com>
X-Cookie: Chess tonight.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Uwl7UQhJk99r8jnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 02:25:56PM +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
>=20
> Device_link_remove uses the same arguments than device_link_add. The Goal
> is to avoid storing the link pointer.

Reviwed-by: Mark Brown <broonie@kernel.org>

--Uwl7UQhJk99r8jnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls+TSkACgkQJNaLcl1U
h9DGpwf/chljmT25rhU+ExrcrLuCCjMNPgGyT8uRk8+9vcY0YtUdpJ7fLX1gXwEK
R2whNMlCo0q+F5OK0lNuRwVqa++XD+qIBeFP4IKVkmRrFYLAadP8+NWY/WCyCxUG
gEUjgM/GxV+EsDLVUuqvz98rU9xuY69K/iaMfglRT0U5z1hNE2Oz8Bd/q3qCZAae
AMCAPg893EHAcJPpl+1baJuGE0bRQXzrmjTooAUeZe52Z/262fszTxuwZx62JN51
V2HqnX6bkJi025hQVVun+J/QWfErW9E0bNJ4eV3tA0tOh5+FVWERpIP077PtupKN
fhJqTyVBcrPtMy1uiGbM9C5+WBt7LA==
=A8E9
-----END PGP SIGNATURE-----

--Uwl7UQhJk99r8jnw--
