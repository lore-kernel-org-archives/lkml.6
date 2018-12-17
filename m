Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA44C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A6D21473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbeLQWKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:10:55 -0500
Received: from sauhun.de ([88.99.104.3]:41438 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbeLQWKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:10:55 -0500
Received: from localhost (p54B3357B.dip0.t-ipconnect.de [84.179.53.123])
        by pokefinder.org (Postfix) with ESMTPSA id 1F79E2E3656;
        Mon, 17 Dec 2018 23:10:53 +0100 (CET)
Date:   Mon, 17 Dec 2018 23:10:49 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH v3 12/12] i2c: i2c-cros-ec-tunnel: Switch to SPDX
 identifier.
Message-ID: <20181217221049.laubsut2xxhyevrz@ninjato>
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
 <20180606150900.8342-13-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x3oowm7ztku26jwn"
Content-Disposition: inline
In-Reply-To: <20180606150900.8342-13-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x3oowm7ztku26jwn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 05:09:00PM +0200, Enric Balletbo i Serra wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied to for-next, thanks!


--x3oowm7ztku26jwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwYHuUACgkQFA3kzBSg
KbbTKQ/9HUd/7JCq9wPqy9bhndmW1AMBbdT7Z+M4Swjj4BtXGy/VxePYteViTtGu
EQrRo7WCd6tmQPxj5kj6fUmAgA6EH2sft/PdyqqvsAK7HxesVg0GCDt74BkA3U3G
5n+UFj+bgBarFXb2H/WQzT/QURXmT8KJ46YoEpNQdu4ylYXMnx9fysJoeJEZUITM
QMF8cfNZ/u0TE6mQy2S+d8guMyl9s7QTs3/DE8a/xTZh/21E380dSfByDgchURbh
zwrz2WvFP5iDCggHyfGd3cROu/BhmsOxaYA6Hb2quTbIpnmZ1KDFavBNzS3uodC7
uVyanLERBDlU+0f7UtH58RURf5F20cwwW2BUf8Gsv/qk5Ag6l7yREH8pgam0xWoT
RzYGRrQxU0EaHRRR6fiTSMgXvLrm7DkvJS7NAtL1Qa8wKcxixx11KqvekrAByAcK
H+ULbDgfNQCFJOkniut7cmJFd/WKw3/S1hWXnx3aLOOweij9p8BKcOaD76PJZ7JQ
Nw4rFmX55EIfu8oWnAjjwlkvfR3xfbdl2qyeBsP7f1m0oei5ZXHWuDVXajbZDRrK
MYch6NTIIJ1VbQPOpd0V5uVnx5haU0YEJUXCw+/6K8sIV6DCqagshV4AxDwVEBof
4kIQuE1Vhodh4pUhuMGgxDqx9LUMxvR8zzdpQCxlMtjBOMh15xM=
=p0ck
-----END PGP SIGNATURE-----

--x3oowm7ztku26jwn--
