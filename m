Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10118C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D293B2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D293B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbeLKUys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:54:48 -0500
Received: from sauhun.de ([88.99.104.3]:45808 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbeLKUys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:54:48 -0500
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
        by pokefinder.org (Postfix) with ESMTPSA id E5F234C0E8F;
        Tue, 11 Dec 2018 21:54:45 +0100 (CET)
Date:   Tue, 11 Dec 2018 21:54:44 +0100
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
Message-ID: <20181211205444.rpfn5cmsndy4y2lv@ninjato>
References: <20181211080448.24007-1-pn@denx.de>
 <20181211080448.24007-4-pn@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="45isqxjr4vjntdmi"
Content-Disposition: inline
In-Reply-To: <20181211080448.24007-4-pn@denx.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45isqxjr4vjntdmi
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

Rob, is this okay or should we drop this patch and update the DT to
contain first the s700 compatible and then s900 as fallback?

> ---
>  drivers/i2c/busses/i2c-owl.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
> index 96b4572e6d9c..b6b5a495118b 100644
> --- a/drivers/i2c/busses/i2c-owl.c
> +++ b/drivers/i2c/busses/i2c-owl.c
> @@ -475,6 +475,7 @@ static int owl_i2c_probe(struct platform_device *pdev)
>  }
> =20
>  static const struct of_device_id owl_i2c_of_match[] =3D {
> +	{ .compatible =3D "actions,s700-i2c" },
>  	{ .compatible =3D "actions,s900-i2c" },
>  	{ /* sentinel */ }
>  };
> --=20
> 2.17.2
>=20

--45isqxjr4vjntdmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQJA8ACgkQFA3kzBSg
KbYC5w//aduy+YzaN8BUpjKgg9R2sXqoXAc22xC6MfkvASLpCMVL2mdw7eNnUgOr
nkTSKS633l8l1yDzzFdreOMwk0LTYnJzEFwKKAUr/zDHmGZYfWjpx/cS8MhCHv+K
48V+gniY04EpacNvTmQssPGEIF6KDmdCxmacqBISLwVe1Npx5AF3IUxyosoyysv4
+ANDuF+Z3S6yOWnQcoXLHJ8iViSSSPXqoaJ0Jm+bUgZB+5osQbSL+viKsPze2aLA
30wTLJmm4qG3fHewozjO3qxkTTu1JTlvAPZmNB0g8jYRoZ/zlgr1FYC5I1B1ET/K
L8MKvLQfqPjczCJ/4joyl1TyVoikaTg98LYTghcnBe0P/pxSQknz+QHTAXwfsJU+
4xKOPyMpEPSjfIdmcWiWVhd1zXW3/R/lU33Tiw8VumMhK/oan9GHuef9IVmtFMbE
wRf9eR9JXJgIjNObQJ8c/EKy3PnGjwLOFCt6bSPJ7llGstE6JvcUYlZXbxQp4kNa
IdLiOUFxwykCOxrnS0ZuMUSwJaKRxQQrteD+dEuH/lQEiOcD8iAPDYTRxdajoOPB
Ga5Uw4VvM4oShExTlxKfPkhO4tv7NZ503SEFBEnpMo0SFFny+MVCIAERJmB2QkL2
QZdp7gZpsfNxzrNueaUtL92mLNrmrfmhDwQ8rE6tTl8Jb+cHMxI=
=cRo4
-----END PGP SIGNATURE-----

--45isqxjr4vjntdmi--
