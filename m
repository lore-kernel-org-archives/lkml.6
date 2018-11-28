Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DADC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D232208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="UovBpyjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D232208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeK1UtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:49:12 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53392 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbeK1UtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hWfMHo45DQRfVlSFMhnQMp9AJhhoGyuXf1/M4ja9m3U=; b=UovBpyjWpVuOdDvrvFq4ts9HI
        yXiUYcuD01u/JOqup5V7l1/4ocrh5Go2aouzLlnV6Um3PwBD28IIh7FR8+i1LoA0+6T32uiLMs0LB
        GXjaf6rlLmpyd0zpfgA8lNnC0Joxs1iBb6bg0koDJF8xEUoQVXJdWAuM53EKeLA0J29Jo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRwRt-0004gg-Ru; Wed, 28 Nov 2018 09:48:01 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8C9491125055; Wed, 28 Nov 2018 09:48:01 +0000 (GMT)
Date:   Wed, 28 Nov 2018 09:48:01 +0000
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
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
Subject: Re: [PATCH v6 3/8] dt-bindings: regulator: document stpmic1 pmic
 regulators
Message-ID: <20181128094801.GF6828@sirena.org.uk>
References: <1543337529-22301-1-git-send-email-p.paillet@st.com>
 <1543337529-22301-4-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
Content-Disposition: inline
In-Reply-To: <1543337529-22301-4-git-send-email-p.paillet@st.com>
X-Cookie: I had pancake makeup for brunch!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 27, 2018 at 04:52:15PM +0000, Pascal PAILLET-LME wrote:
> The STPMIC1 regulators supply power to the application processor as well as
> to the external system peripherals such as DDR, Flash memories and system
> devices.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv+ZFAACgkQJNaLcl1U
h9AA3wf+PMfJhuWzSDo4Gyt+6hi/sZYBOjjmRyNUvr4h4+MD5GD+hKM/khHZHOAX
5DNTnPbq9QxpSz0diLf0ccI2gai1kxHGFeOn3rz6M7VTPPBM06h2KHDdNUQUOyFq
QRCbUmCBT1BvgRXorwBiVQvc7KyanV9MkXaNgleXpb5wMCilOIWREX00Ldo6pZEA
LZzRtxDzz+0HC0M8kADW56NfMKpATi4yW4qAejc/fnkkYAmpE4Jkt7tf2YzFgdRp
f2GNjyVVwMqYnvOcDNeY7rajJQJFTaRahTdUn8LAtsR8tEicx0WAzexFgx/iNjDn
TNPYztrJuVKThCXbbDQEOvlf8Q2EXg==
=rEEf
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--
