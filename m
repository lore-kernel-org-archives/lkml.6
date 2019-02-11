Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6910C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2EC2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfBKKZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:25:57 -0500
Received: from sauhun.de ([88.99.104.3]:52952 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKKZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:25:57 -0500
Received: from localhost (p54B333B4.dip0.t-ipconnect.de [84.179.51.180])
        by pokefinder.org (Postfix) with ESMTPSA id E83452E3542;
        Mon, 11 Feb 2019 11:25:55 +0100 (CET)
Date:   Mon, 11 Feb 2019 11:25:55 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] i2c:ocores: add SPDX tag
Message-ID: <20190211102555.ldigmnnd2lrrgy5t@ninjato>
References: <20190211083122.32485-1-federico.vaga@cern.ch>
 <20190211083122.32485-5-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nscyjifdlxugrr2w"
Content-Disposition: inline
In-Reply-To: <20190211083122.32485-5-federico.vaga@cern.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nscyjifdlxugrr2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 09:31:21AM +0100, Federico Vaga wrote:
> It adds the SPDX tag and it removes the old text about the GPLv2.
>=20
> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Applied SPDX to the platform_data include as well and...

Applied to for-next, thanks!


--nscyjifdlxugrr2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxhTbMACgkQFA3kzBSg
KbZW8g//YveQJfACxbomy0DDXrlOERyzFjX6V90eu2qw+zj5SzkO0iO1XtmDaHm0
mCUHMlJ+3iMzRIemwSSPcSJwDojvoIb466jftT8KyamVxEn2+bZueRrrmlqMb4nf
JKt4xpHhRjq5oZ2lFyl/vd2ApS+ZaGfyMFl0i7wGhEy1a4zhv1wslYAkfO9sOYmz
iE10t3dGqoqzZ8hPkXRbtPTK2Bqs8evkLj/cPHZSmOwts76MkmVuXU4CNeY7UXnH
7xlVpOfcA4KJsVlFbbEaLOvfS4y8695CYtPdsjJNLFrBmhtqisAouAQuh01yE39I
mvBHsKgkYugsnR8FtJg+3y6UOvhjGgzIQ5Ftm7Bn96d9XB/yZIIEf17LJqL8Pav4
VyhTUIbWMzztw0GmZFnUXK6lqFNdv/+87H+XIhaOYpe09y38TRFdknRv54T4Tg4o
671+u5Y/Fc0drTVcWSgQo26OhSEJZH1ElIXV4J3/+U2D7EtMADoYCktGKp97D47A
pjZeUQZfotfs5OyBlAwOt6T5Ub4rwMPE6NnaD0poXE34Vz5sNYPd2ZNVsqR10s0G
3kzcrA5G/FL2zeE51lm4IcGyXmGURrRUqFNmYIjZsc5ze/zZ1fmlbG+4aY6WrNn0
uC18ozbgjpSFXj6ejCfDhc9kc/AKaD0oct00BkojWJ+hlhPhxjY=
=PsM4
-----END PGP SIGNATURE-----

--nscyjifdlxugrr2w--
