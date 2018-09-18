Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B9AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0E821508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0E821508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbeISA2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:28:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33760 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeISA2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:28:00 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id F237380639; Tue, 18 Sep 2018 20:54:02 +0200 (CEST)
Date:   Tue, 18 Sep 2018 20:54:02 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Subject: Re: next-20180910: boots on thinkpad x60 (32bit machine) but has
 problems during suspend
Message-ID: <20180918185402.GA4501@amd>
References: <20180909214632.GA26303@amd>
 <20180910060533.GA26941@amd>
 <20180910075053.GA26513@amd>
 <alpine.DEB.2.21.1809101457400.1292@nanos.tec.linutronix.de>
 <20180910141654.GA881@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20180910141654.GA881@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Next -0910 seems to boot ok... but when I hit the power button to
> > > suspend the machine...  Full dmesg is in the attachment.
> >=20
> > Is this a next only issue or is this happening on Linus tree as well?
>=20
> I believe this only happens in next. I'm pretty sure v4.19-rc1 was
> ok. Let me check v4.19-rc3... that one is ok.

I tested next-0913, and that seems to have no obvious problems.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluhSckACgkQMOfwapXb+vIzmwCfU/FzJKP/LM9fNt53iNQUTY/v
KcwAoL4L1GK9MeDXa+f+NV/rfegjQzH9
=ywZj
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
