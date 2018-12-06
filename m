Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A03C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18F320700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544127724;
	bh=/Hn5KxjwARcGbB/nnEdrtWfuNGvG/zPEesXNNkRT5Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DfG6Jnyvmz8sqoo1Jiiv2qBP5yWOKAyIFX/e99bXsFKfMQKANb7bSNNB7WqL8rcPZ
	 wJ2p4fY+tdSlsMM25wW14NSyNBa+Tezvg4qlfCXgATSCD1NWlvQJ0Dgjk3YTGiUbsi
	 LnmU+sBJ5UK/0lJY0zXI8TofUCyKRM0RkbbX6f2w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18F320700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbeLFUWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:22:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58058 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeLFUWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/Hn5KxjwARcGbB/nnEdrtWfuNGvG/zPEesXNNkRT5Pc=; b=Z4U5ORpS7lwO95H3w9/onUr0W
        a2NXVhvOPtd566a8hv2OyTRQOS2M69RGo55hzjkHOrjT78IWhnJtYEnixCeO6/FB9+La5w0hLrTcS
        4wOwzeAPSmJZPLBc4/Oc/NF0vUKX1pwa9qW+UGMPpAeh3NWFXfT5yGVy3+hV74qXfT9yM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gV09k-0001fG-Ox; Thu, 06 Dec 2018 20:21:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3F23311252F7; Thu,  6 Dec 2018 20:21:56 +0000 (GMT)
Date:   Thu, 6 Dec 2018 20:21:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v2 2/5] ASoC: qcom: sdm845: Create and setup jack in init
 callback
Message-ID: <20181206202156.GD3084@sirena.org.uk>
References: <20181128090037.257359-1-cychiang@chromium.org>
 <20181128090037.257359-2-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Content-Disposition: inline
In-Reply-To: <20181128090037.257359-2-cychiang@chromium.org>
X-Cookie: You will be successful in love.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 05:00:34PM +0800, Cheng-Yi Chiang wrote:
> Add a callback for init ops on dai_link to create and setup jack.
>=20
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>

This looks like you're forwarding a patch from Rohit but shows you as
the author?

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwJhOMACgkQJNaLcl1U
h9B3HwgAgSUfesUl1mC2hmvQH9U14XEb+AXI4vTU5SCG2o4BlUuhZn2I0TceIrk0
DA5NkQENbBiMd97ne+fxf1igJGMFjt9puf5deEVjAwqeOh07uZ4DkNbzHLlM/J6j
gCzvW0eByY9cPa1+IZM6oe0tEwS48yutSbm220pS5Bp9r+6Zs4JcXoo5BZw/MGSn
x+aarS+ZUId2dmg48kziOckCjFFFbuaEmuK19gZHa0qquC2b6984eZW986VoSqSU
JedNPeXRhI3S5bEgXg0N+KtBWDmmF3TRg2s+mKlVHepUHDe9dSAXyVlTXzoD+ZCn
SsZsRZiDrd0akM7xZZfbRyfz3KIn9g==
=tXqd
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
