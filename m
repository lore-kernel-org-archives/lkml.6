Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09E6C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E082085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="iTw680NP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E082085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeJKVaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:30:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42390 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbeJKVaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ITY0VBBx+UmjNYjEr82AVdYD2etvHDjOdOvRUCOnu+I=; b=iTw680NPXcHe4TZ783NbJmrX2
        60eAgq6JxiKsna0otHMza+qSidI+LOKT2UbSO/A695lrUnHFzSpiwqwPKuyk5CUfjYKj3rSZPqKYV
        nTEkIel5BspLVMlFPvNldFdq33t9pXPT0h3uKrZCmrQE95ZUhE0/7o6jA3WoETjHtZntg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gAbYk-0001ie-QZ; Thu, 11 Oct 2018 14:03:26 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6A3E811223ED; Thu, 11 Oct 2018 15:03:26 +0100 (BST)
Date:   Thu, 11 Oct 2018 15:03:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ryan Case <ryandcase@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Trent Piepho <tpiepho@impinj.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Girish Mahadevan <girishm@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI)
 documentation
Message-ID: <20181011140326.GD25351@sirena.org.uk>
References: <20181002013142.209751-1-ryandcase@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
In-Reply-To: <20181002013142.209751-1-ryandcase@chromium.org>
X-Cookie: Use at own risk.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 01, 2018 at 06:31:41PM -0700, Ryan Case wrote:
> From: Girish Mahadevan <girishm@codeaurora.org>
>=20
> Bindings for Qualcomm Quad SPI used on SoCs such as sdm845.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu/WC0ACgkQJNaLcl1U
h9AQDAf/asGDMITdhuub89ozUv4SieeIlSiOEahee2IehmSJH2cR/mWpMHH0TF6Z
ZSoTWpBiCDro6aZ8djGInltrUdc/NbA7RJSIYwWnTwxvrCUEVpGEMsrt3D2vPuFy
EYbLB8ktQnbhgOKQJBq7fQ2/Z0ih/IM1EYTTj9kgLUhW/c+3jSOSusHashDihg6r
+e4ItEFrByxAQEfRAWbiew+ylkqYJOhUBl3KCryKciu1bcKBdQ37BSY8XaSe3Sc9
RMtUuKjE/IKHKFXtKtvWgD+sskA4UARP8ZSnTSIX5vPQKzd5lP7xOaKxCcqO7GFm
6tjCBf6vhySDwO4DmDMUr4olw8ywkA==
=7uB7
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
