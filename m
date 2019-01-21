Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C943C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33762089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548093252;
	bh=eOMvu0knnvPv0f9IvTGNYKgLheXop2KNtO/DGvAWrzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h18/Q8DxF8BusK+hmfotdR4gZFfo1cGDSQldLx8pFjfYW1e07qEY688zoZRCjSM5e
	 NiP2XSssznPE4jBnT5GWOcknDgZWcz+Wje+6IEKatFegFh/2JCQs9IDXu4nPUlFIMI
	 o1t0wEbIne+xbnfrv/NB+vSl4PVoXuXjoJREt1D8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfAURyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:54:11 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33230 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfAURyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b0YdZEjNcEJcf0vvt15V/8G7iQ/I4lH7BQ5pPuVFCwc=; b=Hv8N+ybOpnPbhHPOEhngLh0ak
        sSihL9TrIznkb2uw/qwyvw5Y3eBPJIt8OiXbc0G0ypfzw0vtn7BQrj2SKv+7kOIkZAWA0VI9/923h
        7fWVf4oRZRYaftK1dV6crcAlWbYyUS8wbNbQmrM1s2qeSohjGxwD1+xbML1OEVAsdGGpo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gldlq-0004un-Ew; Mon, 21 Jan 2019 17:54:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CF42D1127D00; Mon, 21 Jan 2019 17:54:01 +0000 (GMT)
Date:   Mon, 21 Jan 2019 17:54:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>,
        tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v4 2/2] ASoC: cros_ec_codec: Add codec driver for Cros EC
Message-ID: <20190121175401.GE12679@sirena.org.uk>
References: <20190119113332.249720-1-cychiang@chromium.org>
 <20190119113332.249720-2-cychiang@chromium.org>
 <CAFv8NwKctsH5cKUQxgfQNg3V2Y=-o5LFZC0b+jwLC=_nNumbig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Content-Disposition: inline
In-Reply-To: <CAFv8NwKctsH5cKUQxgfQNg3V2Y=-o5LFZC0b+jwLC=_nNumbig@mail.gmail.com>
X-Cookie: Body by Nautilus, Brain by Mattel.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 19, 2019 at 07:39:19PM +0800, Cheng-yi Chiang wrote:
> Hi Mark,
>=20
> Sorry, I forgot to mention that the patch for EC command definition
> has been already merged in upstream, but not in Mark's for-next tree
> yet.
>=20
> c1f3375be60c mfd: cros_ec: Add commands to control codec
>=20
> This is needed.

Right, I can't really apply these without that in my tree.  Lee did say
he might send a signed tag for it but I don't think he did that yet.  :(

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxGBzkACgkQJNaLcl1U
h9BkBQf8CJRuj7HS3nyjj55S+Kz9PWSkYvzubXXVTxF0oWuL1mqOR08qLOjFnfYz
A0SltdTdhiQqhR1UJ/1K3ToRkUn6brv2mPVpR57tibkzuj6D4x84AxUMb5CnDt8E
j7la7Xir1epVNF+gh5OVMJJAeBUsnDgiyewmUUWYQBxiQbsHxVr5fn8dX8M0uzP8
nvXiGwaIUn/bOVwDJ0tp2iGZzOVHRbi2Z9eOsUDpnqrCJsdOOOWaTQOnCWTt3XJM
1yQp56Z2pPnn3vSpWPDjGLT7RKFBxEm9YnHUyiDZihGrUhRx1QKFVwmcunuNXBjD
KntIAJgPDDirprGX2YVvYdCkj1Hu/Q==
=aWoR
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--
