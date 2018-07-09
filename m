Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9859FC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FD120875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Oymo4NNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FD120875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933459AbeGIQdm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:33:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43144 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932806AbeGIQdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zpEaw3dxPM5z3jZDr4hQUuqcvDYhUNXGFa/ZpJKKEK0=; b=Oymo4NNsbfcAGzmQ01ttZGtxA
        0KDbn8maIjFIs+mB0Bxxbwr//faLhFjG2hkovID8nhiz41TVTTvtZV53KqtWvrGUejJqAMju/Mdu4
        yiZKRSOaOIMNejcPbbXognar/y8gaZti2U0FSv/epP6p21NO4jUE3g8wuw7uY8Zid/tzU=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcZ6N-0003qk-9U; Mon, 09 Jul 2018 16:33:27 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcZ6M-0005Mu-OV; Mon, 09 Jul 2018 17:33:26 +0100
Date:   Mon, 9 Jul 2018 17:33:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rohit kumar <rohitkr@codeaurora.org>, lgirdwood@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card support
Message-ID: <20180709163326.GI16082@sirena.org.uk>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
 <20180709111437.GB16082@sirena.org.uk>
 <b5a3f0e2-d420-603d-f9a0-f93bdbd2619f@linaro.org>
 <20180709124117.GG16082@sirena.org.uk>
 <887331ff-8892-66a7-20bc-0fce447c792f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gJNQRAHI5jiYqw2y"
Content-Disposition: inline
In-Reply-To: <887331ff-8892-66a7-20bc-0fce447c792f@linaro.org>
X-Cookie: Falling rock.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gJNQRAHI5jiYqw2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 09, 2018 at 03:02:11PM +0100, Srinivas Kandagatla wrote:
> On 09/07/18 13:41, Mark Brown wrote:
> > > AFAIU, The issue with that mechanism or EPROBEDEFER is that it works only

> > This is not the case, the card will be unbound at the ASoC level when
> > any of the components are removed and then probed again when they
> > reappear.

> I did try this and It works only for first time! May be am missing
> something!

> snd_soc_component_del_unlocked() unregisters the sound card totally. so for
> the second time (After DSP stop) there is no registered sound card in
> place.. Am not sure how this is supposed to work?

> The reason I think it works for the first time is because of EPROBEDEFER
> from the machine driver.

Ugh, right - we ripped out that code because there's no sensible use
case for it so now we don't keep the cards on a list.  The expectation
is that if someone is going around removing bits of the card they can
probably figure out that they should be removing the card first.

In any case the place to implement this is in the core, there's nothing
special about your cards here.  Either the core should be using the
component framework or the card list should be resurrected and we open
code it.  This isn't something that's unique to your device.

--gJNQRAHI5jiYqw2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltDjlUACgkQJNaLcl1U
h9Dzuwf/d8/yNOtgkhwg3Bv3BDHETSOvAfCUMJtd6SdcTKImYMto5yWnVT74gOte
VNG18sOnmCo5DVWhEZigXVlOPVXiueXfgOUWJvcO5Rokb1u/XuueXsNQKnlRRwkr
unW0xlN3DKpYR+eOVHYvZR5P3WWrMiFS58yjT8QtOTtV4F8P6z7mfRUfIqpiDj5B
YWva+v+2U8ZqhM/hiU6wmh28jXLKfUUH2j2uLMxH0nO/LZBZQ++C4WVhwQYf6oIq
Pxv+CkXvOWAYvpZApXIVuRH4BcsgyERQMgBcV2SOyRdpiz9HX4CgN6nQcJfRbkKG
HhUFLQ9DeN8m+NfuPDe4Yvd3uskATg==
=8mIg
-----END PGP SIGNATURE-----

--gJNQRAHI5jiYqw2y--
