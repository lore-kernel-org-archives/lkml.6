Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2583C31D64
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7532720823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548055083;
	bh=Igd5GzNXesTGFa66J0kiGXJV4L71glyWWerlSQ7nKEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EOUcEUn0rekRIzEtYI8P2Y6VKzoU8L80gDDaOQ4uMfmbFksvPDgViUu7ekC3QlAoe
	 CI1r8qrONIWlEd4jk6hNOL91NB+iv3lZIP3OYBGedjY32uyCOSouSm3eEA2hxDWVWJ
	 u9rPqrPh22us6WWQCxrO65ZakPvuUFcKc9W+kkdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfAUHSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:18:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbfAUHR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:17:58 -0500
Received: from earth.universe (unknown [194.136.232.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E2062175B;
        Mon, 21 Jan 2019 00:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548029491;
        bh=Igd5GzNXesTGFa66J0kiGXJV4L71glyWWerlSQ7nKEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B0fwlXQF5j7qUKJfDp9eYVj/YMtBu6GOO5Paw26iHWtv1DnBJzE7gILnnr+RVq3st
         WeP5XtJ1jFB9J2jMj0Re2wJf7IANIBKC7iN8jQeJ+5Y7Mtpw6qc+YE3baEKHiRINDv
         Nw8YHHOi7/ROQk2LKj5fYirvYaK34zRs2+1KjyyA=
Received: by earth.universe (Postfix, from userid 1000)
        id 8FBF13C08EC; Sun, 20 Jan 2019 22:45:27 +0100 (CET)
Date:   Sun, 20 Jan 2019 22:45:27 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jiri Kosina <trivial@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: charger-manager: Fix trivial language
 typos
Message-ID: <20190120214527.vhfgufoob4dtl7m4@earth.universe>
References: <1546949532-30150-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x2bs3sv77t67xb3f"
Content-Disposition: inline
In-Reply-To: <1546949532-30150-1-git-send-email-krzk@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x2bs3sv77t67xb3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 08, 2019 at 01:12:12PM +0100, Krzysztof Kozlowski wrote:
> Fix few trivial language typos.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/charger-manager.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index 38be91f21cc4..2e8db5e6de0b 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -4,7 +4,7 @@
>   *
>   * This driver enables to monitor battery health and control charger
>   * during suspend-to-mem.
> - * Charger manager depends on other devices. register this later than
> + * Charger manager depends on other devices. Register this later than
>   * the depending devices.
>   *
>   * This program is free software; you can redistribute it and/or modify
> @@ -29,7 +29,7 @@
>  #include <linux/thermal.h>
> =20
>  /*
> - * Default termperature threshold for charging.
> + * Default temperature threshold for charging.
>   * Every temperature units are in tenth of centigrade.
>   */
>  #define CM_DEFAULT_RECHARGE_TEMP_DIFF	50
> @@ -356,7 +356,7 @@ static bool is_polling_required(struct charger_manage=
r *cm)
>   * Note that Charger Manager keeps the charger enabled regardless whether
>   * the charger is charging or not (because battery is full or no external
>   * power source exists) except when CM needs to disable chargers forcibly
> - * bacause of emergency causes; when the battery is overheated or too co=
ld.
> + * because of emergency causes; when the battery is overheated or too co=
ld.
>   */
>  static int try_charger_enable(struct charger_manager *cm, bool enable)
>  {
> @@ -643,7 +643,7 @@ static int cm_check_thermal_status(struct charger_man=
ager *cm)
>  	if (ret) {
>  		/* FIXME:
>  		 * No information of battery temperature might
> -		 * occur hazadous result. We have to handle it
> +		 * occur hazardous result. We have to handle it
>  		 * depending on battery type.
>  		 */
>  		dev_err(cm->dev, "Failed to get battery temperature\n");
> @@ -693,7 +693,7 @@ static bool _cm_monitor(struct charger_manager *cm)
>  			uevent_notify(cm, default_event_names[temp_alrt]);
> =20
>  	/*
> -	 * Check whole charging duration and discharing duration
> +	 * Check whole charging duration and discharging duration
>  	 * after full-batt.
>  	 */
>  	} else if (!cm->emergency_stop && check_charging_duration(cm)) {
> @@ -866,7 +866,7 @@ static void battout_handler(struct charger_manager *c=
m)
>  }
> =20
>  /**
> - * misc_event_handler - Handler for other evnets
> + * misc_event_handler - Handler for other events
>   * @cm: the Charger Manager representing the battery.
>   * @type: the Charger Manager representing the battery.
>   */
> @@ -1218,7 +1218,7 @@ static int charger_extcon_init(struct charger_manag=
er *cm,
>  }
> =20
>  /**
> - * charger_manager_register_extcon - Register extcon device to recevie s=
tate
> + * charger_manager_register_extcon - Register extcon device to receive s=
tate
>   *				     of charger cable.
>   * @cm: the Charger Manager representing the battery.
>   *
> @@ -1538,7 +1538,7 @@ static struct charger_desc *of_cm_parse_desc(struct=
 device *dev)
>  	of_property_read_u32(np, "cm-discharging-max",
>  				&desc->discharging_max_duration_ms);
> =20
> -	/* battery charger regualtors */
> +	/* battery charger regulators */
>  	desc->num_charger_regulators =3D of_get_child_count(np);
>  	if (desc->num_charger_regulators) {
>  		struct charger_regulator *chg_regs;
> @@ -1801,7 +1801,7 @@ static int charger_manager_probe(struct platform_de=
vice *pdev)
> =20
>  	/*
>  	 * Charger-manager have to check the charging state right after
> -	 * tialization of charger-manager and then update current charging
> +	 * initialization of charger-manager and then update current charging
>  	 * state.
>  	 */
>  	cm_monitor();
> --=20
> 2.7.4
>=20

--x2bs3sv77t67xb3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxE6/cACgkQ2O7X88g7
+prupw/+M3m4rmhrb2SHzGIrnraeP5X9CuQtDWfxr9cxyiyeWcpwAhJYEZnGMJj0
LBOyiJxsGs8ZUDSKPjEsuCJYWWmRpkqQhYTQS6xy9z9vOwhhaaQIc17cs2Ffpvbv
C0400UrkirP3ieSS1EyhUnCHA4XWkOyg4ccjjCWxo6z3zR62Vu1N85+cLkDZAnqP
JE4F2tbm/BYLv+x8uB9gfHLNTImbXl++U3cIJAp8uABml3KP1kqKS6kuHmPxb1ck
9gv7RnvJQAXLkFImUF0vEWCdEc+bmHPkkK1YUdViQCKZ6X0WAJsx8sZtF6YruOfw
z/QlpK/TptlXIlte6l9urOc2UqRpCCHky/+tvZiMJFd/si08u7sjpQ5VSG8GoaF/
R5OQgxP7SjxBcN4y7DSQ1uo8ZCHPduKBSu6rjRASJQZhw8Vnhrna0Bu88tRrUnsk
KrdCTeQL/T/ER/UrfrzRL4VVWA5YhPcDxiFS0UG5wg1gj0/SNRHdW5oDfRdEdttO
4BIMBi1R1598aUSccujLFml8nua1lBcQvENxoUwhNPUOCsZVwxRiNayRDit/CcwB
qZUpuRtL7zNpzQzEfCz49JZRZdw2XF8ZMfHgjylAtr1EzqpnwnvpDL8qhvGwlzUp
gi3bS5rfnwkIH/gZfhQmZ8IIta8GV8H++NXIUytaUiJWv5gLc5E=
=dgrP
-----END PGP SIGNATURE-----

--x2bs3sv77t67xb3f--
