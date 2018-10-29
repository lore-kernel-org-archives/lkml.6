Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88006C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAF32084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAF32084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeJ3Aqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:46:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:10654 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727565AbeJ3Aqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:46:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 08:57:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,440,1534834800"; 
   d="asc'?scan'208";a="81823516"
Received: from jtkirshe-desk1.jf.intel.com ([134.134.177.96])
  by fmsmga007.fm.intel.com with ESMTP; 29 Oct 2018 08:57:19 -0700
Message-ID: <c7970686b40e5348b2351580b19f45ee6edc12a9.camel@intel.com>
Subject: Re: [PATCH 2/2] kconfig: remove silentoldconfig target
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Oct 2018 09:00:48 -0700
In-Reply-To: <1540827688-15999-2-git-send-email-yamada.masahiro@socionext.com>
References: <1540827688-15999-1-git-send-email-yamada.masahiro@socionext.com>
         <1540827688-15999-2-git-send-email-yamada.masahiro@socionext.com>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Zp+VR215FWXUzxuFZmnr"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Zp+VR215FWXUzxuFZmnr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-10-30 at 00:41 +0900, Masahiro Yamada wrote:
> As commit 911a91c39cab ("kconfig: rename silentoldconfig to
> syncconfig") announced, it is time for the removal.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>=20
>  Documentation/networking/ice.rst | 2 +-
>  scripts/kconfig/Makefile         | 9 +--------
>  2 files changed, 2 insertions(+), 9 deletions(-)

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

For the ice driver documentation change.

--=-Zp+VR215FWXUzxuFZmnr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlvXLrAACgkQ5W/vlVpL
7c7czA/7BJyuUZ7KlnPwyyvsq4CeO2EBjuqMQJTPHs44GgDBGLAQZxmnnsQNS8qY
VoBpJeytrK3eiCOLEZj2jiQskY1kWY8SPwJumdotICdonIhnBkb9+9YcOKqb+BXx
1szIy/8acRFWc+3WAoTcrICDKVCwf0cV7phXuj6NMjOPmH33Gt5X6gMfQWobAWZK
XIppy5J2aBTH6XgDtAi0/SZA4FIZx/wl8mi36QQU83Utd/Cm86WMDi6CjD6InAdw
eJSEPSATlxhxR4o2J+gv/KrieVKyctShS0nJCJ6IMgD4jHdMYLWOkAE2qMRySGqY
klt7ts3eUG8V+7uEHROG9UbQUWnynsdgf2EStUJyGgVWRYubbrWs7mJjVX9tIrGa
74FYauDDoAgd2sCjBIOaP5ys7pMw7Vqqrq5NoytBQJJkTQHpOKIX8ueLA09Kt9Qb
kFsUhWkuF2G2l0PEb7ltq2O29dfQ6YTOdhGa+xIrgcp0d1f/ietVrAyhHucd8q8O
iMBSO8cVMW1C+nwtbolmupAMrdDhhTsQ0xhGzruXkqjEj+z1J6zDhJKq/sfpvLNo
0B73BXGfNL+sZ1L1kFrO5EFkvK7x/4SQtgjQwt11qhBlkBhXgOM1h4/JWa9725v7
suMbspxRrPXscXBIXnLmHcr7tVY3l5E8NoKNpp88BFFceH7RT/k=
=SE6r
-----END PGP SIGNATURE-----

--=-Zp+VR215FWXUzxuFZmnr--

