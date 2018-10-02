Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487A3C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082672089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082672089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeJBOKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:10:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40742 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJBOKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:10:20 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 785288078F; Tue,  2 Oct 2018 09:28:28 +0200 (CEST)
Date:   Tue, 2 Oct 2018 09:28:27 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, linux-omap@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/9] dt-bindings: ti-lmu: Remove LM3697
Message-ID: <20181002072827.GA19677@amd>
References: <20180928182954.25446-1-dmurphy@ti.com>
 <20180928182954.25446-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20180928182954.25446-3-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-09-28 13:29:47, Dan Murphy wrote:
> Remove support for the LM3697 LED device
> from the ti-lmu.  The LM3697 will be supported
> via a stand alone LED driver.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

NAK, for reasons I explained before. Please add it to the patch so
that it does not get applied by mistake. Ouch and AFAICT Rob was not
happy with this either.

Yes, you are creating new drivers, ok; but that does _not_ mean you
should create new binding.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluzHhsACgkQMOfwapXb+vKklgCeIvPQ1q4qktH+N0rwTB34zw83
fckAnR4JcCIl2eF+evx3eR/tsO/sWjtA
=Z0W9
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
