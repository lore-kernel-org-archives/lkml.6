Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50483C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0672021501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="qeAMZOgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0672021501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbeHBLnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:43:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37394 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbeHBLnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Xr0aOvXN84Kpsez+8eAtnZVAPRQLjVF0zKFxBqh+Has=; b=qeAMZOgmTpkbYb+3WYDcyznY3
        HeWOzlOdMlDXZHDrSdI4n24kelSESZmjChvqczWJhSAxLeBsdz+ue1jgNd/ux9mmtnLThzllQxARG
        4LCUofJ7SsbrFm9eIhBYYCWG/mkLp9YikN7WgVnU/LEALdCu2N+SJIw8R8nokJdJ9s4fg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1flAHb-0001pE-Ti; Thu, 02 Aug 2018 09:52:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6E5951124241; Thu,  2 Aug 2018 10:52:35 +0100 (BST)
Date:   Thu, 2 Aug 2018 10:52:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, vkoul@kernel.org
Subject: Re: Applied "ASoC: wcd9335: add CLASS-H Controller support" to the
 asoc tree
Message-ID: <20180802095235.GB9117@sirena.org.uk>
References: <20180801112000.DC6B51124241@debutante.sirena.org.uk>
 <d7c2e466-9f60-9347-bc62-7ed0dc3df91b@linaro.org>
 <20180802063130.GJ4662@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <20180802063130.GJ4662@dell>
X-Cookie: BARBARA STANWYCK makes me nervous!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 02, 2018 at 07:31:30AM +0100, Lee Jones wrote:
> On Wed, 01 Aug 2018, Srinivas Kandagatla wrote:

> > Without the "[PATCH v2 02/10] mfd: wcd9335: add support to wcd9335 core" It
> > would break the build.

> This is not a run-time dependency.

> Without 02/10 there is no build. :)

I reverted both patches after Srini's mail anyway (I didn't go and check
for the MFD dependency, probably should've done).

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlti1GIACgkQJNaLcl1U
h9Bj6gf8CW3GQP6wh/uI0bsTgcrN3VIWuUsOzAmi9uwXXvvKpht9jBEQEvnHeW6F
4RHbLEYW6Ftf/QA4Gq9aSQkeZwtpnq7NNfDBmiNiNjt6ZQ3NDoDnJh7eJPl45rRG
oUMpqESO8grhP3Xvdn2D79zMUQbjmzxJpKmf32AxLpp+CV2HGWL07VofsmkmljoA
7AkOOHRAV5cupYkC+pKAkYZTAZsCj0TeVGDtfCO6ytZ/eGfyKPK4n0eIa+KEJUP4
4bT0GWP8bQIV5Was00DTRRaYdAIETVrTFU60Ukv+4lxw43yGhk47inx+ZT+Cw6XE
YBqxdCFtO/8ClZIK+5TLmiBdpR+kIg==
=GgCo
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
