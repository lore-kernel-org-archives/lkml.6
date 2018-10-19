Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00D3ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6948421479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="xO/NPDN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6948421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJSUIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:08:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54192 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeJSUIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qwqC5CfpDWmcoA89HysqBrOnlZpBTsRCijrtk8dw7ZM=; b=xO/NPDN3BFxE0GqVeLMp1Y9C2
        Gg5mfwADVT5kANr7k2cae0JwJkKKEiDGcJvBVv6yp12GBjkvywQWRSH79BYtQ7cSNaDz0WjcpKdMj
        9VyyHWv3/Cu/w5kp0n7fvtbOtz9hPcwr+OPvps4joJBXwAP8h4H0h2aJRsMclHHOpjT28=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDTTn-0008Rv-1R; Fri, 19 Oct 2018 12:02:11 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AACEF1122548; Fri, 19 Oct 2018 13:02:10 +0100 (BST)
Date:   Fri, 19 Oct 2018 13:02:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Ben Whitten <ben.whitten@gmail.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] regmap: Add regmap_noinc_write API
Message-ID: <20181019120210.GF5895@sirena.org.uk>
References: <1539941631-4421-1-git-send-email-ben.whitten@lairdtech.com>
 <20181019115652.GD5895@sirena.org.uk>
 <6dc0a6f0-7bb9-4ad0-73ef-f3527da6894e@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
Content-Disposition: inline
In-Reply-To: <6dc0a6f0-7bb9-4ad0-73ef-f3527da6894e@suse.de>
X-Cookie: Obey all traffic laws.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l+goss899txtYvYf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2018 at 01:59:07PM +0200, Andreas F=E4rber wrote:
> Am 19.10.18 um 13:56 schrieb Mark Brown:

> >   regmap: Add regmap_noinc_write API (2018-10-19 12:51:19 +0100)

> You two forgot my Reviewed-by... oh well.

Ah, sorry - I tend to trust people to carry these things forward :(

--l+goss899txtYvYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvJx8EACgkQJNaLcl1U
h9CpaQf/cd+hxS5GWDaeSZyhkY5cBhWwnLl8Caz8gyfIJqN6KZMyZndm/pam3zsr
fRKZXmrTvxtleI0w/aNL5rMonySC65L7xmM475828hTQda1H2eKF03mLAnILRTP6
rf1Y5cfMIO7rL7WP5naJ+UUwuRwc9dim7/Mvb/f2GBRcAZz8xGntYlyn8+oPm/XW
TXv5oCEiPRJ/Zpvp6vywL4CyUJxzS3O9vofeZwcXeSDrgaHEns4jMA+i8m3ZyPcG
4zMtPWAEmfdJqSC50VmnlJQ4iV/yOZNazQJpd9jUTU5hT+ujg8a59Yeec7kCKDII
0xFsf/YTMaEtV6G9s1DVw35yaOSBmg==
=+Zz7
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--
