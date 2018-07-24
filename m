Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EA1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5F420852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mHzDUEdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5F420852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbeGXPnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:43:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58588 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388448AbeGXPnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ULu90DM1XyLv3lpHBW1T+e//F8XlgNcEhd7IEuPNpqE=; b=mHzDUEdCgb2xd4Xv8WInAn/QR
        NXuGWmyLu4uZtpP2CNqFHI8eiihbvJ5dyc4Gz48g8qSRFl+1dYFU4sfdZpTswFdJg9aliSZfvq61g
        9xkvHUXbB5u4VBkWxiJv5Bei/hNkttB7agKRbM9pvwYrUMRTDyqtyHUVJUue+hWnq4czU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fhyQV-0005WQ-5F; Tue, 24 Jul 2018 14:36:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DC4A81123A86; Tue, 24 Jul 2018 15:36:34 +0100 (BST)
Date:   Tue, 24 Jul 2018 15:36:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Add sw2_sw4 voltage table to cpcap regulator.
Message-ID: <20180724143634.GD13268@sirena.org.uk>
References: <20180724132541.17039-1-pgwipeout@gmail.com>
 <20180724132541.17039-2-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1sNVjLsmu1MXqwQ/"
Content-Disposition: inline
In-Reply-To: <20180724132541.17039-2-pgwipeout@gmail.com>
X-Cookie: Join the march to save individuality!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1sNVjLsmu1MXqwQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 24, 2018 at 09:25:40AM -0400, Peter Geis wrote:
> SW2 and SW4 use a shared table to provide voltage to the cpu core and
> devices on Tegra hardware.
> Added this table to the cpcap regulator driver as the first step to
> supporting this device on Tegra.

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--1sNVjLsmu1MXqwQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltXOXIACgkQJNaLcl1U
h9Bs1Af9Esx5B/jH0/vkzcSK7TdzwrkTjnQ5hyQFW37fVeoYdLIjmf0g1iiWn6iV
+HnLCJXjUPesyDfbTCp70bkMJitAbezK1EgkbhEYZhumyfuDB4p+aRKPmPjxheq3
NbqZKovM6nx38587zTj1T/IrKySPgRqztA/jvW4CL/8TTWPMw9iPsbF5TyPeLQ/s
PHzDIFED3RF8RukQ47aUCQ38/+7w9LrwQsoT1s88SpYyhiqNzq1T0XBY04KCclwZ
HW1y3ne5r2mzX9/rgANsqQYDoEh2iRUl4lO/I6qdcG2I/8FgRcMFfzaK+S4bwJr3
6znQ6DhbI1noJNaPuicPhOY90rbsCw==
=BvPL
-----END PGP SIGNATURE-----

--1sNVjLsmu1MXqwQ/--
