Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D503C31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024CE20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548055090;
	bh=3GDN5WoPWS4KWKusYYeDpmAEBq9fNZ4PPDc/28BTfE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1QZhlfFlWSQlJwCWTsd2P/1kl6+RoIMiZ4kSNf9HGWbv/8mzQWkkjVlVDLOniBD8w
	 L2ykYZpTVk6bL4WUnQuh5L9unSzEGINoRI+Gk4RWcAEUC/mQ2VLw78zdX/Km7T1Lzd
	 rvrl1Kood5jUkyXBrCpIQxlWU213hL5pMh99CkrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfAUHSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:18:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbfAUHR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:17:58 -0500
Received: from earth.universe (unknown [194.136.232.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B8F521741;
        Mon, 21 Jan 2019 00:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548029491;
        bh=3GDN5WoPWS4KWKusYYeDpmAEBq9fNZ4PPDc/28BTfE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ULtLcfG7hROS0vzczMmzXibBPhsimfyWkQx6f53aWuis65p7NkKyP0vT2xHya6sFt
         6JN0pB1qTLgnLQj/AcJHSn0Ino8liKig+1miCcdVUAQWcW3tfXxpq98Xn7DLUbkHqL
         0nTwG2ZW7ZvR3aBlCqHB3QX0aleGIg+Xe9ICehRA=
Received: by earth.universe (Postfix, from userid 1000)
        id B24603C08EB; Sun, 20 Jan 2019 22:44:48 +0100 (CET)
Date:   Sun, 20 Jan 2019 22:44:48 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     fuyao <fuyao@allwinnertech.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power_suuupy: change brace's place
Message-ID: <20190120214448.yjiuy7gqkfcrktss@earth.universe>
References: <20181229055925.GA12884@AExdroid03>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="irl2k3n5wbpagzeo"
Content-Disposition: inline
In-Reply-To: <20181229055925.GA12884@AExdroid03>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--irl2k3n5wbpagzeo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi fuyao,

Sorry, but your patch does not follow kernel patch submission rules.
All patches should have a long description, that describes _why_ the
patch is required. Also it needs a Signed-off-by line submitted with
your full realname. Last but not least there is a typo in the
subject and the patch is not send to the right mailinglist. Please
resubmit after reading the files in Documentation/process.

Thanks for your patch,

-- Sebastian

On Sat, Dec 29, 2018 at 01:59:25PM +0800, fuyao wrote:
> ---
>  drivers/power/supply/power_supply_sysfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 5204f115970f..be1577e96c59 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -75,7 +75,8 @@ static const char * const power_supply_scope_text[] =3D=
 {
> =20
>  static ssize_t power_supply_show_property(struct device *dev,
>  					  struct device_attribute *attr,
> -					  char *buf) {
> +					  char *buf)
> +{
>  	ssize_t ret =3D 0;
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	const ptrdiff_t off =3D attr - power_supply_attrs;
> --=20
> 2.19.1
>=20

--irl2k3n5wbpagzeo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxE69AACgkQ2O7X88g7
+pp0WA/9HIkpk5D6r1kBmR/1pq6YoikJTmycOOXra35nis8/6c1iU5sTlpIcfs3Y
fqa2toiZf0DGEh8yAbKExmWxgwCHEDYru/jtkIOWYDlE2RdAwIsqJ6zoPyZdVfjt
r4wNyTl6cJ/WFdC8Wq8J57YSjcc3ieKZoKzdxJJ0h++QPdra//Qb5jvi3xy1MoJH
w3sGmnOprPO6BjmBeCk1R5rDZNdM1Y28Z7nO1f/kFA8MjGBMQsf/B5V+iswGCT0c
IFoZi9o0KD5KpFZn76zxRSjP3/On/mrWazTpzU2tU5SprkC6cgmk5O68nrHDm2R6
Zwm3PSpe4hgM9bLG8VIek8C1uaF89Gs9PZtqR16h4G2iUavfElDy78vraGVUqfj0
/1x1dqQclkdqoSxbAabqnSeVgZG4LhEACvtDsvS6RvpVRHbreH3YCq5RsQ5TYEAt
qBudSv8rKc6RcIKASAi8M2UUQq8+f5u76zrRXYWZ+196CXm9qDZ62LpSlg3CLhbN
pTMgk7Qs1ljbuuTRS8Nv5zSb9VVk6kleC4pX1v7WkN0Dnys8pRwAzVkQDq2PYbCa
z0X3x7fSwAb9q8MjNdglwcOeCxLjoiahswXmdb45K8rwO9+4sfgnjwmpBjfiJwFL
ZigBEWFLlfPr5lzXBc1k1KFcoMIo4XFoXOiMparKcQT7fQxo7io=
=WAre
-----END PGP SIGNATURE-----

--irl2k3n5wbpagzeo--
