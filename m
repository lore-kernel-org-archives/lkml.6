Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42763C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38D820870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38D820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbeIJTLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:11:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57808 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbeIJTLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:11:13 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E0E6A80647; Mon, 10 Sep 2018 16:16:53 +0200 (CEST)
Date:   Mon, 10 Sep 2018 16:16:54 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Subject: Re: next-20180910: boots on thinkpad x60 (32bit machine) but has
 problems during suspend
Message-ID: <20180910141654.GA881@amd>
References: <20180909214632.GA26303@amd>
 <20180910060533.GA26941@amd>
 <20180910075053.GA26513@amd>
 <alpine.DEB.2.21.1809101457400.1292@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809101457400.1292@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Next -0910 seems to boot ok... but when I hit the power button to
> > suspend the machine...  Full dmesg is in the attachment.
>=20
> Is this a next only issue or is this happening on Linus tree as well?

I believe this only happens in next. I'm pretty sure v4.19-rc1 was
ok. Let me check v4.19-rc3... that one is ok.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluWfNYACgkQMOfwapXb+vJHawCgpDQeuxIRhK8tI17jGRAC7pOd
nE4An37wUZCLB71xtApUxr6QB2FnBFW6
=HlhM
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
