Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C178DECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711F420779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="KUvw38y4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711F420779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388979AbeGWSEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:04:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33030 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388716AbeGWSEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HSXZ0nPIwUyg0AtdJivGwzdaTh1EOQHJrgSojgMeeIk=; b=KUvw38y4UylqdZhBtBO23L++w
        kPaZppXM/bayz5Z9nWG1ONF6EhyqqbFz1o1F+UmMqyqzpb2tARjDGLJX1x6Ui9jiiEi4AkpPKg5jK
        f2senkYpKPTunRnP5IOhJ6KO9dtLaGMOqXc+Vk5Jll50s8AsM6mII4QCTLze9W3zlv+34=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fheDd-0004N9-Mz; Mon, 23 Jul 2018 17:01:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5F016112387B; Mon, 23 Jul 2018 18:01:57 +0100 (BST)
Date:   Mon, 23 Jul 2018 18:01:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     girdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] Add sw2_sw4 voltage table to cpcap regulator.
Message-ID: <20180723170157.GD13981@sirena.org.uk>
References: <d38d3fea-dc7d-09fe-651e-386b36befde1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <d38d3fea-dc7d-09fe-651e-386b36befde1@gmail.com>
X-Cookie: If in doubt, mumble.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 20, 2018 at 08:43:49PM -0400, Peter Geis wrote:
> SW2 and SW4 use a shared table to provide voltage to the cpu core and
> devices on Tegra hardware.
> Added this table to the cpcap regulator driver as the first step to
> supporting this device on Tegra.

This fails to apply with:

Applying: Add sw2_sw4 voltage table to cpcap regulator.
=2Egit/rebase-apply/patch:37: trailing whitespace.
                                               1437500, 1450000,=20
error: corrupt patch at line 38
Patch failed at 0001 Add sw2_sw4 voltage table to cpcap regulator.

Please check and resend.

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltWCgQACgkQJNaLcl1U
h9BSZAf/VsYB49dLAymFOD6wBNVBN9ssFWiy0GyRwDNUU2glcNSCkNQg9VbFuvbf
pL+yDsbFq43X3zygSc43IwkEgaQV1A23ZeFy3gdpcFFNQ84ja3pbC8Nc2l8dE4Ef
2tl4FXQlcqrdPXDE28j0TiYrCetaQbTgQ7uOJTvn1sQzBeC1JATeBAL+J71NNcHp
5Izudv3e30wcQilO3meT4xXmyGgl/nquNOo/7cDBPz08BFbAMDiCHoEhn4wbplUg
LN2feNkQ9ruXhw0MbxC70VBTDZxalr/gaAip2jzq+2+R/oAuILhJI/UFDfc2NY6+
5f086XLj0RZayut2OboYf9Pn+dkQhw==
=j3zD
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
