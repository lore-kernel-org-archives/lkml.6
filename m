Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDBBC43612
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FE920815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfACTOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:14:00 -0500
Received: from sauhun.de ([88.99.104.3]:55196 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfACTN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:13:59 -0500
Received: from localhost (p54B3379A.dip0.t-ipconnect.de [84.179.55.154])
        by pokefinder.org (Postfix) with ESMTPSA id D43822E3614;
        Thu,  3 Jan 2019 20:13:57 +0100 (CET)
Date:   Thu, 3 Jan 2019 20:13:57 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     manivannan.sadhasivam@linaro.org, afaerber@suse.de,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@cubietech.com, thomas.liau@actions-semi.com,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v3 3/4] i2c: Add Actions Semiconductor Owl family S700
 I2C support
Message-ID: <20190103191357.iegsd3w2qwdyt7qv@ninjato>
References: <20181211080448.24007-1-pn@denx.de>
 <20181211080448.24007-4-pn@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fpxnagkc257sawko"
Content-Disposition: inline
In-Reply-To: <20181211080448.24007-4-pn@denx.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fpxnagkc257sawko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 09:04:47AM +0100, Parthiban Nallathambi wrote:
> Add S700 to the list of devices supported by Owl I2C driver.
>=20
> Add Actions Semiconductor Owl family S700 I2C driver.
>=20
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to for-next, thanks!


--fpxnagkc257sawko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwuXvUACgkQFA3kzBSg
KbbIXhAAn7Gr/BtL4P+5gCIKhJ+7uZDVeTxTHH6v/I9Zcrlr25sY2PgnqXEwzsGl
Kz+3zElXy4q6qMZ8sXjc778+VsmwE5TJXEmnYiVobCprx0Paf+pgxMX/1gKOYmSr
gBJqGiW66FeJSBYkvaoI89moQxyJhl3vmJSDVi8mrlE8/AXhfqyJ2m49IdflIn/8
7WHwMD9jNIuC41tJBtqigS5l0UjYtyB9j4/EXXltcBYyom9t7famyomNOE0eeGRn
qhcN9uBNhHOl4yBbjxqsONyMt+ZjOEa9TyPHXLUsob0POwRwe0FiJMiMy3RmIrqc
n5BbAJIjqATGmpwKtVDjEEvAJ1qbUoMUNu6cEbcmyV5ySkJ3OwKPf8zUiGDTkFU/
/hVvAtc0WutEzoz1kwKpsm7OufuE6C96cDNkPvDyzgI5VjlSsFuhmBxtmUvLLIg4
0E9h5j1cpI7luxt3SFGtIM4kfJyWXDZnIRGxllJKkgmQzM+9+ZkTLjpXQ5sFMuJu
VEZQfG2Z5AcKUDzaHcXLA0lhedrDTYQIB9IowFRN8AHjxpt4TElehgkroohOh2ad
sH8jaN9oH/uYuA1z4SjtPVafd2giR8ChZ3PMrqVfuCRtgav7c2morRLr9J7Ru3PS
lFibpUL6pUNiw1M9C+3DD+68y9MkiGTGf7PUk+WLIH1n8CdGLgU=
=bUoW
-----END PGP SIGNATURE-----

--fpxnagkc257sawko--
