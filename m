Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBC2C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487A22070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546885688;
	bh=Iy7T6/W+OoI8X1kyh6ZOZUpGef+ELy1lNX0roo8CUkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oWxLzsb3oRcRmz2W7Af5BekoLJTw+cChKGnxlpH7uvEm+MFPN4WDJLVAdEQFgI0fX
	 S91bc0QQ3WKtK43Beo+tQPhp69gI374qUnukpDM0IktlZo5vCMgAxCabw7ErFU6QIV
	 TIjMYPNksqqBTjYy2FCODtvHaYbK74EZVIE1MaQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfAGS2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:28:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46476 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfAGS2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Iy7T6/W+OoI8X1kyh6ZOZUpGef+ELy1lNX0roo8CUkc=; b=r9iMxzZzUkILFeBYlzjyPIZXk
        pPKEBuSKJ9d2yg/h3qfW8nlCtvSnmYvCCd5s6Q0oL0fsWonInB/vdZLxlCwzPqwP0pbmiYd9B83VR
        TdyXlO55XEXab7JyHyxa0PPTWoL/5yOQhAQzvo7z7L9rhIct8pYTXJg5gNTlJ7X1TAVLo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ggZd0-0007gb-1N; Mon, 07 Jan 2019 18:27:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8C5271127491; Mon,  7 Jan 2019 18:27:57 +0000 (GMT)
Date:   Mon, 7 Jan 2019 18:27:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     plai@codeaurora.org, bgoswami@codeaurora.org,
        asishb@codeaurora.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org, Ajit Pandey <ajitp@codeaurora.org>
Subject: Re: [PATCH 2/2] ASoC: qcom: defer probe if platform dai is not
 registered
Message-ID: <20190107182757.GS9570@sirena.org.uk>
References: <1545642133-16120-1-git-send-email-rohitkr@codeaurora.org>
 <1545642133-16120-3-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jesV4P1FjH8FXPjZ"
Content-Disposition: inline
In-Reply-To: <1545642133-16120-3-git-send-email-rohitkr@codeaurora.org>
X-Cookie: NOBODY EXPECTS THE SPANISH INQUISITION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jesV4P1FjH8FXPjZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 24, 2018 at 02:32:13PM +0530, Rohit kumar wrote:
> From: Ajit Pandey <ajitp@codeaurora.org>
>=20
> Platform DAI component probe is not called if it is not
> present in component list during sound card registration.
> Check if component is registered for platform dai before
> soundcard registration.

Why do we need to do this in the driver, I'd expect this to be something
that we need to do for everything not just this driver so I'd expect it
to be handled in the core?

--jesV4P1FjH8FXPjZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzmiwACgkQJNaLcl1U
h9DQjgf/T0oyN1/MUYlbj/WHJfg5qzDHvFO7pSuwm6jRnkfHq10cSqBiiymFlZeT
ffXyclWvM/TyYKu83AwbKY12XR6E/FYmX7A/xtx4f9hHl4RGkNjZqeEOkwWHFWPU
Da967A58RYhtT+Da+ygBiC4ElQnlXxLMlbOBXWXkO1h8UXHcesl8herw1AwS1RmA
Mtb6OINAR9+azH4wWfRGuwFLNqEbDiMDL8q+ad2q5WHe6KE6t7bLLGelj23BXo1C
UeEmino9DKG0XbNJgkPTWfEBGg/sahv9fqqNGxzgMUl6GhhVuHHBsnqMyxb12XPG
DHVN3hfmzcXom5VwIPGix8MDev14zQ==
=DveR
-----END PGP SIGNATURE-----

--jesV4P1FjH8FXPjZ--
