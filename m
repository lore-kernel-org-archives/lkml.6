Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbeEKOwy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 10:52:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752981AbeEKOwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 10:52:53 -0400
Date: Fri, 11 May 2018 15:52:47 +0100
From: James Hogan <jhogan@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mathieu Malaterre <malat@debian.org>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 5/8] MIPS: jz4740: dts: Add bindings for the
 jz4740-wdt driver
Message-ID: <20180511145246.GA12956@jamesdev>
References: <20180510184751.13416-1-paul@crapouillou.net>
 <20180510184751.13416-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20180510184751.13416-5-paul@crapouillou.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, May 10, 2018 at 08:47:48PM +0200, Paul Cercueil wrote:
> Also remove the watchdog platform_device from platform.c, since it
> wasn't used anywhere anyway.

Nit: it'd be slightly nicer IMO if the patch body was a superset of the
subject line. It's fine to repeat what the subject says since thats
meant to summarise the body.

> -struct platform_device jz4740_wdt_device = {

There's an extern in arch/mips/include/asm/mach-jz4740/platform.h that
should perhaps be removed also?

Otherwise
Acked-by: James Hogan <jhogan@kernel.org>

I'm happy to apply for 4.18 with that change if you want it to go
through the MIPS tree.

Cheers
James

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvWuPQAKCRA1zuSGKxAj
8mlfAQCJf5mvfQD9ow7oPKhrS7ZEEtsAokvWC1M/Z2F3mCx3bgD9HQQl05Fya66i
Dpd1TlEADWA+H91gd5uKii85SdfeNwo=
=IGgX
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
