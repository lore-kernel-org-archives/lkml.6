Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA598ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA66021528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA66021528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeJQS3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:29:38 -0400
Received: from sauhun.de ([88.99.104.3]:36108 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbeJQS3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:29:38 -0400
Received: from localhost (p54B338A0.dip0.t-ipconnect.de [84.179.56.160])
        by pokefinder.org (Postfix) with ESMTPSA id 9210D2E359D;
        Wed, 17 Oct 2018 12:34:31 +0200 (CEST)
Date:   Wed, 17 Oct 2018 12:34:31 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] x86: baytrail/cherrytrail: Rework and move P-Unit
 PMIC bus semaphore code
Message-ID: <20181017103430.GA1563@kunai>
References: <20181011142911.13750-1-hdegoede@redhat.com>
 <20181011142911.13750-2-hdegoede@redhat.com>
 <20181014131724.GA863@kunai>
 <f040787b-3f64-e338-7a9c-0d44f968f496@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <f040787b-3f64-e338-7a9c-0d44f968f496@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > For the record: once the designware maintainers are okay with this
> > change, I am also okay with it going via the x86 platform tree.
> >=20
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvHEDMACgkQFA3kzBSg
KbZ8fQ/9GPZzZB/WIcMzmSZHbX0okCplGqCv2Ad1Xpm1dy0XuwTQJUSwAF+vN365
rsP3Nr8wyYNLj6EYLS6+jJ0Rh5dGuG8mhgDjYMEny7UBr0pUhjzFOQXN9U0NeFYs
YF1UyppAaX+uViiPz89bcDc5zj3heoFjjGP2r+0vJUw5uscXEQr+hEA6jw2fAL0n
RgMuB0audo3sj87pyZd8Aur1/gQEfQ4UBW6Z09BYltvGhwsy6SMA/GtbX2lC7+iJ
d0G2/TeuzpHDXsc4Bot3kbb69hx3CYnyAirFlC/tnNklZqaykC8qTEpXAL3mcMbE
B2f4uEq1d86pPqqOmNTkcBhFqTbT+HFLqqdOjCdWrR8vW/qAqts/2RzZhr0c2OUh
0IN7EJcaNbX2oDuuIN1SYAVll84+SCXQ+PesX8vsxPF6/r0DlMXxFrcuqz1L9n0v
FnyXMGfnqPmIFIiBSkD17k6nRShZm9U0ZDtJThdhWNt2ObnXe9bVlGBg6+3YVLeZ
U+2TCcoajrZXLVct8XuBj4LwVsg5r9bSjXE6N+w1prgvUkpw4vLkymCEO9Ki6BqP
ZtlzXwQCmLd3sKZz+UcqrXm0qeXgbCsmQajHyAYHLevMvKKQma5Wn2iWHSOmefnN
JQcRhwy/pwZFCcH/I5LIcAVZHJEDYH5RP45rmK44/KanQ9QDcCc=
=U+Xp
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
