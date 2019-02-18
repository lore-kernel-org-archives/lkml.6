Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEB9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA2C20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391039AbfBRRGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:06:13 -0500
Received: from sauhun.de ([88.99.104.3]:37886 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390984AbfBRRGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:06:12 -0500
Received: from localhost (p54B3327C.dip0.t-ipconnect.de [84.179.50.124])
        by pokefinder.org (Postfix) with ESMTPSA id A98BD2C7BF4;
        Mon, 18 Feb 2019 18:06:09 +0100 (CET)
Date:   Mon, 18 Feb 2019 18:06:06 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Shikai Wang <sxauwsk@163.com>
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: cadence: try reset when master receive arbitration
 lost
Message-ID: <20190218170606.qt35ciis4zpqo7d2@katana>
References: <20190218094132.5226-1-sxauwsk@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="55tyi4ztso44igmw"
Content-Disposition: inline
In-Reply-To: <20190218094132.5226-1-sxauwsk@163.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--55tyi4ztso44igmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 05:41:32PM +0800, Shikai Wang wrote:
> When the adapter receive arbitration lost error interrupts,
> cdns_i2c_master_xfer return to the caller directly instead of resetting
> the adapter which resulted in the adapter being out of control.
>=20
> So when driver detect err_status such as arbitration lost,
> then try to repair and fix it.

Thanks for working on this issue.

> Signed-off-by: Shikai Wang <sxauwsk@163.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Reading the previous thread, isn't this more of an acked-by or
reviewed-by than a Signed-off?

Also, is there a suitable Fixes tag?


--55tyi4ztso44igmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxq5fgACgkQFA3kzBSg
KbZszRAAljXV2RneaUpe4jL8KnONqVWgRXYtj/MG7rxBhl6B2jg5TH1HqH0MRZIO
hhTB21+VhdzjEyg9/Dai52L1BbndZKkTGTeL/jjIBI740iC4Nn6+3qerN3UmNkYR
tHKCw1LLmDj0gph9Gez9PXZwBYBJAdnCugvbE88iNiJ1E8TrVxGV4mGkdXjGJDqV
gYOV3cvlQoznHiq3iaoSrF05iCMJCvoPuHAWPoRGXNk2wuHkWr+H2RK7jBzZE4GQ
Q+JJQe0AgXIgE5ivAkTanKcmu/6vZpEnUKu2Q1jS2fESt1nd00tgT0zhi3Mr1oB2
EhjAxdq46q74gKAJGm0GgHnhzwjBTBi5rHuglxR/Z5yCdHc7WgM7bASsKKpVmcQt
vBO0geyHGL5rsyIgKIBzQXpJeB0fCdpUEO/CNmQqTRJEbHM2Ra8X/BRYWFwof1Ae
9G1LnECNAQOoXVV3bmq+CpzXCJZOQVh+LnMb1sBiltKLSdMVgIx35Q7fL5hiJF/I
FjEEH4MUjvjwocer9fLOArAUWggPdKKSbcQAOE9jKi1BBIzwIEdL39eM/Mq2Ih96
bR2C72CHEqSAsbCNcxNrYSCy54pL9tW/QZJb/DousDgbpJGwPbZJWXUr12bfml9G
+s+/LU37XtbG262QCd0CKbSb8Nz4gbzz0ZQWQ2Dh+jVUi7EJ1Ns=
=WSqx
-----END PGP SIGNATURE-----

--55tyi4ztso44igmw--
