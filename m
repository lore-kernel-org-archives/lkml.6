Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BE8C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8FF207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="b/PoCYs/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8FF207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbeJXVpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:45:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35662 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbeJXVpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+R2GM/n6AC7ZWCzpcBgSAmYpzdD+yIroTkjiLWoRVdM=; b=b/PoCYs/0MGxLEd98n5ARtCbr
        XqLrE5nJSzt4EF6s5DSQiWIZpvQUMx6wdP7pS1j52vLk1TxHxdZzbPyjKYkWqslTQBM/48AyNX2JP
        8fhwhxND6WvpZ2/AOOrg3nce2+BgaknELGkbOVDhh+MN+/bxu9WqxyJPYP/8CcmT2W2wY=;
Received: from [185.7.230.213] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gFJ2D-0001Cb-SV; Wed, 24 Oct 2018 13:17:17 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7BED7440078; Wed, 24 Oct 2018 15:17:16 +0200 (CEST)
Date:   Wed, 24 Oct 2018 14:17:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>
Subject: Re: [PATCH v4 4/8] regulator: stpmic1: add stpmic1 regulator driver
Message-ID: <20181024131716.GQ2103@sirena.org.uk>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-5-git-send-email-p.paillet@st.com>
 <20181019115015.GC5895@sirena.org.uk>
 <5BD06B96.3080809@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yFH6hwN92mUA4HK5"
Content-Disposition: inline
In-Reply-To: <5BD06B96.3080809@st.com>
X-Cookie: Piece of cake!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yFH6hwN92mUA4HK5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 24, 2018 at 12:54:46PM +0000, Pascal PAILLET-LME wrote:

> I'm sorry, I'm not sure to understand. Would you prefer to not register=
=20
> regulators that
> are not described in the device-tree ?

No, I'm saying register all regulators regardless of if they are in the
device tree - you shouldn't be looking at the init data at all here,
just let the framework match them using of_match.

--yFH6hwN92mUA4HK5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvQcNgACgkQJNaLcl1U
h9CvFQf8Czl2zAXmxAqiGUYNP76+JwWwgghhHVahho872+7g8JBFyzQdqgCk0s0L
js7GKFtIuTp5nX5zI+RciHNZK2rYjqCJ+WMFm0eLrdSXVjBWcFLh/FlnIGDNDYly
gnTcEk3DJQX/fo21bBUAysMBY/e0lYMZZuTIwsYle3I3XIrQFQUfb+EWBdLcV6jJ
2Z4x0bPBSSHIJUVtOaKexxR2WjqP5hBU8IjgfFuzpTG8JTH/OSp2M4MxzSbRBBP5
KCN1SqIWOI1vMUgsx/wagQ9agW9v23CIKy0+k+7zejMbrokDJx2XgPODUbXr6EXp
zHXVPpbuRtuAiVJD3XoKwpKEiqVCSw==
=sJkh
-----END PGP SIGNATURE-----

--yFH6hwN92mUA4HK5--
