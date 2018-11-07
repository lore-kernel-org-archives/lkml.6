Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B85C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5CE20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Is2+Gynf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5CE20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbeKHBpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:45:52 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50984 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730846AbeKHBpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gYX2rROAor4sUgf0I6ThTNv+3rK4eyDCJG/SWNQ1UbE=; b=Is2+GynfutLQ9Q/7LFyfkQ0qL
        d1SzGAhYLprYE8AUCXZMl4qROob1S+QwVtwbJg5mGtNW9ud2AlvCVAZeisCFpkfui6WG7/fZBgwN/
        MO5xmSzPyUFQzvYmSTLNGc3juyxL9MHv8gfawWYQ/3SjxSU+J2DKZHQY5eDjYbYFCawNY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKQTW-0006hj-Dz; Wed, 07 Nov 2018 16:14:38 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F18D71124E14; Wed,  7 Nov 2018 16:14:37 +0000 (GMT)
Date:   Wed, 7 Nov 2018 16:14:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Rohit Kumar <rohitkr@codeaurora.org>, Takashi Iwai <tiwai@suse.de>,
        olivier.moysan@st.com, rohkumar@qti.qualcomm.com,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        lgirdwood@gmail.com, plai@codeaurora.org,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        srinivas.kandagatla@linaro.org
Subject: Re: [alsa-devel] [PATCH] ASoC: core: Invoke pcm_new() for all
 DAI-link
Message-ID: <20181107161437.GC6809@sirena.org.uk>
References: <1541075929-29323-1-git-send-email-rohitkr@codeaurora.org>
 <s5htvl0exil.wl-tiwai@suse.de>
 <48c78f67-8178-2d07-e35d-2e4eca51ccbc@codeaurora.org>
 <791d4587-4db3-3ffa-331a-f79d0993ca8c@st.com>
 <3616f01f-6a00-6eb1-0bdd-f161b7ce15e6@codeaurora.org>
 <4f22e4e5-84f0-1560-1ba7-5e77d44fd312@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <4f22e4e5-84f0-1560-1ba7-5e77d44fd312@st.com>
X-Cookie: PURGE COMPLETE.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 06, 2018 at 04:41:23PM +0100, Arnaud Pouliquen wrote:

> I would say force device to 0 if no_pcm (need probably to create the
> control in hdmi_of_xlate_dai_id instead of hdmi_codec_pcm_new).
> But keep in mind that solution has to work in case of multi HDMI codec
> instances, perhaps using prefix...
> Anyway, i'm not a DPCM expert so perhaps more elegant solutions exist.

Liam, any thoughts on how to handle this?  I've still not really worked
with DPCM systems!

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvjD20ACgkQJNaLcl1U
h9A8Dgf/UWITAfBn1fgkapuJtrcu/6lI5ZQuwpTlRaME25VLqX7uo5ph0ZW5U9VU
xm4bALOyi2F4zxT4uEaFDYN9AVVDYjAC19yD10ZEKVmb940q1XSL1g5elBySoLGB
qDjQGVDMa8fOuObXJ5198IbnthqOj/PcazG7zywWSWu8T9g4r9W6FQYjhaLbbQiP
NhTI75xlFgsDlpD+0APD73Cy69wRiunMrINfXJ3AYf02mG8JJCn+dsm9mExV+tPr
kwpCjCoMwNDxbE3GF5qBt90INMFOQ7O33a6hURWULb9AE2FW2Z7KDIp7+mmrBcFt
FW3ulHM249aDqVgWh6KFqwgV0iRj7A==
=RPSz
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
