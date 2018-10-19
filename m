Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD13ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854D521479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="jxQzSS+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854D521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeJST4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:56:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34314 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeJST4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 15:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T6p3ScLAe1S4fQqF1dBZ9aBFTF76lhkFkRc+OI9lmaU=; b=jxQzSS+tSS5a0LxulXkHxVrnS
        9MvG5fgjXOGmIaaJYQ3pRm7lUPlJ67fy/SAdREqZz9hGC1YCZdG+DGG/dEsxkcq+8k9lSlesyKNHT
        oBpDOSnlFPRcbbmM1MJ+POnqTI0C+uzPBW3gv80q/IJf4ffHAw7+E7klKdQKeHFmslFc4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDTIG-0008Qo-0q; Fri, 19 Oct 2018 11:50:16 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A0F5F1122548; Fri, 19 Oct 2018 12:50:15 +0100 (BST)
Date:   Fri, 19 Oct 2018 12:50:15 +0100
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
Message-ID: <20181019115015.GC5895@sirena.org.uk>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-5-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <1539853324-29051-5-git-send-email-p.paillet@st.com>
X-Cookie: Obey all traffic laws.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 18, 2018 at 09:02:12AM +0000, Pascal PAILLET-LME wrote:

> +	for (i = 0; i < ARRAY_SIZE(stpmic1_regulator_cfgs); i++) {
> +		/* Parse DT & find regulators to register */
> +		init_data = stpmic1_regulators_matches[i].init_data;
> +		if (init_data)
> +			init_data->regulator_init = &stpmic1_regulator_parse_dt;
> +
> +		rdev = stpmic1_regulator_register(pdev, i, init_data, regul);
> +		if (IS_ERR(rdev))
> +			return PTR_ERR(rdev);

This looks mostly good, the only big thing is this - the default is to
just unconditionally register all the regulators that exist rather than
only those that are configured on that particular platform.  This is a
bit simpler and means that all the readback of the configuration for the
unconfigured regulators is available for diagnostics.  Is there a reason
not to do that?

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvJxPYACgkQJNaLcl1U
h9AVFwf9HuCK1nKd89bM5cuVWMEtrJN5wwS0dwfV9NJNvZ8H5h6NdUcTYb8JASZo
c2MckaIg5ZWdFkVtQseoT85lrBAtbROJWGrSks44FXy+fmQM6SBosll+LKRavA2b
1VPuCiyqBHPTUz6+dVUeAQRidxERF+dZdfK2FrJGaw7G96WKeHfg7zQXy4cRNJJ0
kcfl9qNCYjF7I4FKDqugM0gKnEARpRPThYY0agxvSnJvjsR9HAcEKDNh2BBIrDQG
acGQE+u8/nDkD6a0Wo8NgQ+V2GsJeSjMgBVUgl+gUFaoEcogr8t0wuAlnG+kvxtX
/pYld58dINQUYBa8+hAqgvDZK9V+iQ==
=W0oL
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
