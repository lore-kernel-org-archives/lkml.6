Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172C2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27102084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="r+TMvPmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27102084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeLEOTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:19:13 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54492 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbeLEOTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EaP3p1Odho+E0EW8WYUJ1imSQixhkH6l2lEKmDeMCmQ=; b=r+TMvPmEqjve4EW0OkDBKKLgA
        thGzFJmD85lLpxGd60EO948NbGZadmwxLGX8zLYO06iOjwWcRN3NW3taOb23d+ewEdVaQvT52pEyt
        3AGY4E1cq6mZKVw2ZEi+DSlcU0IGUO/5/9GJygXBwErTox83xMOEv/dQ2fG9SGiJ0Ndec=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gUY19-0003t8-7T; Wed, 05 Dec 2018 14:19:11 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E06BF112533F; Wed,  5 Dec 2018 14:19:10 +0000 (GMT)
Date:   Wed, 5 Dec 2018 14:19:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 0/1] regmap-irq: support chips with separate mask bits
 for irq edges
Message-ID: <20181205141910.GE6205@sirena.org.uk>
References: <20181204181550.29122-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Content-Disposition: inline
In-Reply-To: <20181204181550.29122-1-brgl@bgdev.pl>
X-Cookie: Real Users never use the Help key.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 07:15:49PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> I'm working on an MFD driver (and its accompanying drivers in various
> subsystems) for a simple low-power PMIC which exposes a single GPIO
> line. It has a couple of interrupts all bunched together in two

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwH3l4ACgkQJNaLcl1U
h9A+lQf/cTxaBNpdkdI3ttRMTyAZTs/HaIR3h+vnkHr/QTrpHKhghSySPbBCvgkI
DXq37y65rrOXYUVVf188v+uRJeYY/RNdcstTwcXwVNt5gM2cOy28E1ESQIhPw3pX
y0308wfAV+M+qEZiShS95lecwiHkIDA51KpqpYwQLaS3m2w0YR9aoKG3yZjzGOHM
/k9nrc90Baa7x3aLxVkbWZYNFWYWat9mYwcLa+Y1Kp0PLbNJi32RS/9jtcRAgNmB
qBXYUxKX1iS1/l9yOPEecZQiQORiRX1zMWQsn3pMqbkO1Dw5g2EgzGFxRPRmox/s
IpeUMLBVNYXlNvtgamTmDSFgFy4Xfg==
=L9kV
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--
