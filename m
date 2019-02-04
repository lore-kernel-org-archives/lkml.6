Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A33C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA072082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549285447;
	bh=USrUMjr9UIN2hbKDwhRm5JA31VtbQQGAY8hOo8U16NI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bwPzUiMmJOXC2gEjZQynr1uYJ+ugy/wf3cyzyGWrVVkVD2oQmeksbeVvQ+2kc8n6i
	 ANx+ur8Tg9MmE8/NXKDuzB3VuiC6Oh5F6yvedY3AtajFzTiyMoKecnfNoRE0MEAGMG
	 PYr/uwMibTpXkK2h648NzFN/Fj7Lb55zeXVMz5yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbfBDNEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 08:04:05 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41860 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbfBDNEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 08:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Fonou85UFsLunBr86+KxEuOPXIOKPsC0t4U2/hPoAwo=; b=uSaxMfBT8MZNqujXUpC4sDe9h
        9gs6hDBPgUEZvTb6Ponq5g4D7quO0+n0TaXaHhabFIbxz8UA0pEeG9e9tCRh4jgRtz6p+jNPd02Ac
        vShh3EwCGtsIb8L/Zu8tGxsqiDsU3LQ8iFTWqfW57ma7qbB0PnaLO1U/70Lr+TECjqrNc=;
Received: from 53.97-247-81.adsl-dyn.isp.belgacom.be ([81.247.97.53] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gqduo-0003Sh-Lb; Mon, 04 Feb 2019 13:03:58 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id A29A7440082; Mon,  4 Feb 2019 13:03:56 +0000 (GMT)
Date:   Mon, 4 Feb 2019 14:03:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v5] ARM: dspi: Provide support for DSPI slave mode
 operation (Vybryd vf610)
Message-ID: <20190204130356.GF23441@sirena.org.uk>
References: <20180927150709.17010-1-lukma@denx.de>
 <20190109082644.14941-1-lukma@denx.de>
 <20190204113001.77d59570@jawa>
 <20190204105737.GE23441@sirena.org.uk>
 <20190204135242.7112d48c@jawa>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Content-Disposition: inline
In-Reply-To: <20190204135242.7112d48c@jawa>
X-Cookie: Murphy was an optimist.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 01:52:42PM +0100, Lukasz Majewski wrote:
> > On Mon, Feb 04, 2019 at 11:30:01AM +0100, Lukasz Majewski wrote:

> > You've been sending ARM: patches to me (the SPI maintainer) and one of
> > the DT maintainers.=20

=2E..

> Moreover, I've CC'ed developers (Esben, Andrey, Martin) involved in the
> changes for previous work done in this file/driver.

> And those changes are solely related to SPI work in this driver, no ARM
> Vybrid.

If they're SPI patches they should have a changelog that looks like a
SPI patch which means that it should start with "spi" (see other patches
on the list or git log for examples).  When your patch subject lines
start with ARM: that means they are for arch/arm - I don't 100% know but
I suspect I've just not got far enough into the mails to notice that
they're for SPI, people do send a lot of patches that just happen to
mention buses to maintainers for those buses.  In general you should try
to make sure that the subject line for your patch matches the style used
in the relevant subsystem.

> What else shall I do?

You'll need to resend the patch, preferrably with a suitable subject
line.

--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxYODkACgkQJNaLcl1U
h9DgQQgAgIDt2K7uNIIQCWmf0tz+YhIqnAV6fh/hvA12LQbTpN4ftZoMo5rgPbRH
JWreTvSwfdGdZzirzndN+UhweiK4x6JoqZRbrRFbGKxzRHNbp+n03fzNc0M14n1B
EH4nm4vyVzVmMND/HgJGuD2UcQaObYqU/4gVzDPrMJKkPVMPBeyQkUpW/p2A36Ga
I+UsFv9rCzBAF+X+wI/DEvAGT5R3ZdKUrii5cHuivaqNnUlGBdfi3JUgtv4n4bQh
HTdCR3ElX7QgA1lAeGxesmIZFYga/5BrKsxXabGgwzccIArFSdWtnlPuicmHbWEV
wqCsLjz17IPcjB0SH1tuUOAQXWo50w==
=yqeA
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
