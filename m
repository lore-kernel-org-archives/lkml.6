Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932334AbeDWS1C (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 14:27:02 -0400
Received: from anholt.net ([50.246.234.109]:60284 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932194AbeDWS1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 14:27:01 -0400
From: Eric Anholt <eric@anholt.net>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 16/61] gpu: drm: vc4: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-17-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com> <20180419140641.27926-17-wsa+renesas@sang-engineering.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Mon, 23 Apr 2018 11:26:56 -0700
Message-ID: <87vachhj7z.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Wolfram Sang <wsa+renesas@sang-engineering.com> writes:

> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to drm-misc-next.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlreJXAACgkQtdYpNtH8
nuhrfRAAtsGa94ThjB3penHE1ORa0TEnWyCvBzCk80ZZVXTyBXHL1l1vl0AIBFxD
oHoWFooZYxH0FwpBqFPO1J/y4mVtbkbdOVd9AQZ8yccBiTtuehFMGhCW8RAKSYku
NAgS3GPxx3QOk0Nn/eIQ1stlJi9PbJByUEwUuJwjMxzDcl18/wIrflzR6yjiaIbo
c8XhcTao5yy2oHRfQPwSWPdgzaJaQLCQhFcPgoD4ioCNGdtfzQjWV3stHdIcvKwo
BLlqFyar1+2ReUPNu7TZXpQWeZnP2aW9TAwY14S7/MZzRANcd7HkbMb8ceaUMQHs
+TmhRNtJ//L4jSDhXE7/EZfRGbFyPhx2FZyXvI/UYtU7ZObkUYkW5yC7X7ha47E5
uSLEaR6eTqnM/fuHOlEcubp7xpT2lOA2QKvcnUCp0UeNGp01f5BQkfWhbBqYndNb
CgcaUNhKv7SOEvaIapDtuj/SlTtYEQiFzFcA7725Wfxt57iZusM0XwkzpJtfkDSF
z1ZJmffQVskT+ioUClr8X/5R5yC7f3KMLJQ0L4kYjDnWx4D5qcaWmSavfmhgWG4t
5QI8WrxWcNaMbPTkKxOqYxzN1XFE+oaFww68aCySBaFtBIbWASSjNYN4l1aC3P5y
ZVyIoyN9EhmsHdbCLmBrwQJJSBCnfax8aN2zoMEhwiwawthxJG8=
=v5Lv
-----END PGP SIGNATURE-----
--=-=-=--
