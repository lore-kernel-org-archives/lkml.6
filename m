Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753602AbeA3RUZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 12:20:25 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46768 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751760AbeA3RUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 12:20:23 -0500
X-Google-Smtp-Source: AH8x227a5vP83rcL1BNTbfbWOMcFER8Ohccl9aGmzfM4mY3hxZAjaeq2hlkJqracBHB5nQiGpGO+2A==
Date: Tue, 30 Jan 2018 18:20:20 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Mario Limonciello <mario.limonciello@dell.com>
Cc: dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-laptop: Allocate buffer on heap
 rather than globally
Message-ID: <20180130172020.si4f2goddtlvppu5@pali>
References: <1517331540-13266-1-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ycinrzsc6nt5zihc"
Content-Disposition: inline
In-Reply-To: <1517331540-13266-1-git-send-email-mario.limonciello@dell.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ycinrzsc6nt5zihc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 30 January 2018 10:59:00 Mario Limonciello wrote:
> There may be race conditions with multiple different functions working
> on a module wide buffer causing one function to get the wrong results.
>=20
> Suggested-by: Pali Rohar <pali.rohar@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>

And Fixes: 549b4930f057658dc50d8010e66219233119a4d8

I think fix for such race condition should be forwarded to stable
kernel(s). Apparently only 4.15 is affected.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--ycinrzsc6nt5zihc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWnCpUgAKCRCL8Mk9A+RD
UuhiAJ9tHtmU1P3n86FYeVHtTkHJTfaCWACcCLFRU5htcQ/CRAfARku0NsmHO30=
=L0cK
-----END PGP SIGNATURE-----

--ycinrzsc6nt5zihc--
