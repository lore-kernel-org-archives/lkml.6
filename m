Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA029ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9ED20846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="g43GusH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9ED20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388201AbeGWL03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:26:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46172 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388021AbeGWL03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IjwUTK31Y60RUYUzSEmtCudBoq41y0iMRGY/RuDISTg=; b=g43GusH6lTvZRfzyDtOrwC2EL
        bXCzHvLwuZeGbwCRS5EMsYlfCU1DXDXNMNPkUHZWngygk+eKGc46eTnT30eGVBnCPGnDDs7YPdVKQ
        g5cBRllt78lNJbxrnw5MzIt0zFfBXWrirxsBNQUkIQAZ1qQVhbJkL1/IOcd7ojMmTdQ4U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fhY2N-0003xp-W6; Mon, 23 Jul 2018 10:25:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BB30A112387B; Mon, 23 Jul 2018 11:25:55 +0100 (BST)
Date:   Mon, 23 Jul 2018 11:25:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] Add sw2_sw4 voltage table to cpcap regulator.
Message-ID: <20180723102555.GB13981@sirena.org.uk>
References: <17c10727-cab3-4736-281a-d4ace1cdbb82@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <17c10727-cab3-4736-281a-d4ace1cdbb82@gmail.com>
X-Cookie: If in doubt, mumble.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 21, 2018 at 07:23:31AM -0400, Peter Geis wrote:
> Re-sending due to email address typo.
>=20
> SW2 and SW4 use a shared table to provide voltage to the cpu core and
> devices on Tegra hardware.
> Added this table to the cpcap regulator driver as the first step to
> supporting this device on Tegra.

I'm missing patch 2 here, what's going on?

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltVrTIACgkQJNaLcl1U
h9DhkQf/alsJh+YMHB+9qoz+MsbIQ+p8iq2xCD8FGkvxPA9Mu3B9QjaWJxflqDq5
EJPP+WN1nwIpnso6A1hWe4q2wuj3tPwiE7WOQEHowwYX3xAXQ17/P+kKUTA/9iy/
FLhalC0SqOtAw7qjt8syt9kOMqZeZ9LggAI2VX5T8VQVDzUcBTpn82W0eqlcDO6T
MpH0U4PKqsdjV6tOmrv9XZjDC4oRueJMQqdjueaDfrqjdqbIzfkP93p58kMqWCz/
FF/ZostvRGDZ5bpUUOhP4akmn6HDPbA0VJM2M9bw9sZRVSGGkCNlV5bdwsKEaGAJ
JEH+20nCypHzvvuQMma7mTwOMr89Ig==
=47xC
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
