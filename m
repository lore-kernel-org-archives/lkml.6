Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74184ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A306208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A306208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbeGQHqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:46:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:27050 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbeGQHqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:46:21 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 00:15:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="asc'?scan'208";a="65252212"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jul 2018 00:15:02 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Pengbo Mu <pengbo.mu@nxp.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pengbo Mu <pengbo.mu@nxp.com>
Subject: Re: [PATCH] usb: phy: fix copyright issue of phy-fsl-usb.c
In-Reply-To: <1531811402-44183-1-git-send-email-pengbo.mu@nxp.com>
References: <1531811402-44183-1-git-send-email-pengbo.mu@nxp.com>
Date:   Tue, 17 Jul 2018 10:11:58 +0300
Message-ID: <87r2k22v5t.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Pengbo Mu <pengbo.mu@nxp.com> writes:
> Fixed the copyright issue of drivers/usb/phy/phy-fsl-usb.c.
>
> Signed-off-by: Pengbo Mu <pengbo.mu@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhuu@nxp.com>
> ---
>  drivers/usb/phy/phy-fsl-usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
> index 900875f..dcb531c 100644
> --- a/drivers/usb/phy/phy-fsl-usb.c
> +++ b/drivers/usb/phy/phy-fsl-usb.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2007,2008 Freescale semiconductor, Inc.
> + * Copyright 2007,2008 Freescale Semiconductor, Inc.

again, what's the issue here?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAltNlr4ACgkQzL64meEa
mQbIew//XIFxhxdBrE+Wr0EdSyW3uTwoE1qOW949nTkZYyT55Wlzw/riF2u3MTAq
c1n84oBF3u63WtO9xBa3Kt0S9RCi/43VhAHJeLGJ1VLw4QfOthChRUSgjvbu1pkl
w9eufUF8yH5ui0YIymoC/s4JpfnCvYEl9Rf1SdAd6Qyk4CB32dV3KU3cELjIor8C
ZDUgmaI98T+99wb6ET7ezR3Nk7o5kntl7GxgxcdQvYZic3PWgSgO7zLNZAdb95MT
dQxi9bu6JHerglzin2uoL1t/tM41mK0gArVuI4qzu9R+A+XtjKowSIK7ivlmabxT
4c9AkhzGWrj02/dx6XXQ/Z4yhcldxawdK/wofxbJKQzhOcimUgM98bdEnpypAPPg
T7RRKr4m0zN3nuUAtUOjTO5ykEvAQATqgGjW7tlLls0Jnzzz4AJsUI//MdYsb1Hf
ptZ5WU2n4A8u+CTu6f8oLj9MPAzBhmUp0g2V/arsPSGEZNqLc3EulfzqZRux2FRi
z57TCQdx08qgXE2KxvrqwpN2H+IXR6SJoU5xcpzNMyuU0D+jauJ3f/6MXR3/XcQ6
a5HdPxW2ntrGu+1M0kO6Glk27KO3jG2hqKKLlE5nOasyzexyigo6ZpXzgLHyG/bJ
K+EmftC5foosqrR1i3YpQkKMxrYdJb+szKEdIdUC2bQroYlf55I=
=OXJs
-----END PGP SIGNATURE-----
--=-=-=--
