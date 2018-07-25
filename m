Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DDCC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFB420833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="BRoSbmQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFB420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbeGYRh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:37:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58410 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbeGYRh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KynVh9tgaRQz6dfjYE4CpaWTnCUN4wnzc69m/8amncQ=; b=BRoSbmQ1PykSI3TAch7wQWwDU
        8MYx3IdBlKg17DLhzSYtyMF9TMNTJY35oS9CB2QgVxv3Pr+jxRCa4Mn/SR9K9N5m7ZSpFjq/F1DuY
        oNZDBQeFm3dlStLQakdSlnZzTigU+WGfdf1BpkpLLAAMPDGoH/dAtPM5f3CFiPi9LCwhU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fiMau-0006kK-4v; Wed, 25 Jul 2018 16:24:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C30931123B08; Wed, 25 Jul 2018 17:24:55 +0100 (BST)
Date:   Wed, 25 Jul 2018 17:24:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 12/12] ASoC: apq8096: Add support to Analog audio via
 WCD9335 slim
Message-ID: <20180725162455.GC6315@sirena.org.uk>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
 <20180723155410.9494-13-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <20180723155410.9494-13-srinivas.kandagatla@linaro.org>
X-Cookie: You may be recognized soon.  Hide.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 23, 2018 at 04:54:10PM +0100, Srinivas Kandagatla wrote:
> This patch adds support Analog audio via WCD9335 Codec connected via SLIMBus.
> Tested it on DB820c.

This looks good as do the other patches I didn't explicitly comment on.

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltYpFcACgkQJNaLcl1U
h9AYRQf+MlUMS9lvwVmMrSYMa3FS+HFCLO01K7ckUMy9KOIoYIzpEnhXlK7NN2dH
aIjGIBNJcYBrKlzQTg859xt9XX2LE+lnxwVPIF7lPz/czeIPsYkCdg28GtzEDF0q
RGK1yc6yBoNjIOpQtpu7KSdGlz08Ve3YcfOqZvT3CLyvHqwol8ath8MJuBKOsIu5
susi5HEu9xeLH4/MSviqja5VDmaqQGIMes7mlJPa99GrjWWNCbrabv1MVc3JGwzF
4qgv+xS8wjnQxvXRY6hWQGBOK0wMRHaECdLVS2aZZ1Qjrp86TGFSvsHnIWcK83Kh
gcaNIBmlVZxTmUgObR4oCrXErF8I8w==
=uYAY
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
