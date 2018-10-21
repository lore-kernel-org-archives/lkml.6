Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10174C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DF82064E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjLRK6Qq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DF82064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbeJVTvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbeJVTvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:51:41 -0400
Received: from earth.universe (unknown [185.7.230.215])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CD5320890;
        Mon, 22 Oct 2018 11:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540208010;
        bh=CGYBPdStsQ7Yu4y3s0nzqGdqaSsjr38C48EBKm6gOYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KjLRK6QqSsBDhLTEW9VaotLtRmUcp64+KIXhQAHz84F4RO5BD6ln0AwYoXEEYw0he
         2At3UT+9bA/9jccSZbT2V6ihWm8DZtqF8QCyCTAz+5j5ZsAfmD/p+zzSBb3Rp396LX
         PSn7gVRFEJuMWLNFWVSMlUn97Iyo+tU+57LiuqTE=
Received: by earth.universe (Postfix, from userid 1000)
        id 07B7A3C098C; Sun, 21 Oct 2018 23:15:26 +0200 (CEST)
Date:   Sun, 21 Oct 2018 23:15:26 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/7] dt-bindings: power: supply: axp20x: add AXP813 AC
 power DT binding
Message-ID: <20181021211526.gnynhk3ibte3o2kf@earth.universe>
References: <20181013080848.29894-1-oskari@lemmela.net>
 <20181013080848.29894-2-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u4twyzyo3rubrpig"
Content-Disposition: inline
In-Reply-To: <20181013080848.29894-2-oskari@lemmela.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u4twyzyo3rubrpig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 13, 2018 at 11:08:42AM +0300, Oskari Lemmela wrote:
> The AXP803/AXP813 AC power supply can limit input current and voltage.
>=20
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  .../devicetree/bindings/power/supply/axp20x_ac_power.txt       | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_ac_pow=
er.txt b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
> index 826e8a879121..7a1fb532abe5 100644
> --- a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
> @@ -4,6 +4,7 @@ Required Properties:
>   - compatible: One of:
>  			"x-powers,axp202-ac-power-supply"
>  			"x-powers,axp221-ac-power-supply"
> +			"x-powers,axp813-ac-power-supply"
> =20
>  This node is a subnode of the axp20x PMIC.
> =20
> @@ -13,6 +14,8 @@ reading ADC channels from the AXP20X ADC.
>  The AXP22X is only able to tell if an AC power supply is present and
>  usable.
> =20
> +AXP813/AXP803 are able to limit current and supply voltage
> +
>  Example:
> =20
>  &axp209 {
> --=20
> 2.17.1
>=20

--u4twyzyo3rubrpig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvM7GsACgkQ2O7X88g7
+ppRDhAAlOzpWCAqyTCbY3wqpzLCchIxX5mpjbrYJRVBM+gQvuo6PQyzmF5/JKdV
xhfXDucdKEG1GcNyjpegeaX79dpmuzvh5EF9T5DSXdZUyjo5wb5rcfajX2xYHMhM
UuSqNfDjAFjtO0gT9v3xsfhazBajb8zbi13Bq9fS0GjVFsE9VmME3vAzku56gIUq
3UtGAdLP9IALUegtyuPT5jvytqd7nwJR64OlD0OrcCclaiXKKenfi7k9YYg3icxV
NWBRE+ykD5w9NNvNdhR2WJSgzZ/k9pr6bHvqPWuX/eVFH1TdtG9PHpN3ynOx6vKP
yPV3gnAeYhxsJS+aPfEY61PffKFJnGpqz06o81i7LMIJ3IuTUbx42Mc7yoVCc7aj
gqHEZ99n3oDJQ/2JBgfmWhZN/zP9onjknwjmAtUiW9l8EJwKLQZ1ySAcNDWtKOwY
szocE3JReDU5kreqi5uZLhSODrwJEZj1AysLQqqMgxoHpMPDRGchSVk15Z8NznvC
c7vmcvzvuf5FQ8lLk9AoBmCAOaxr4bgs1UQMO+7pC7eCI2CZky09+JbdBcaz2l53
obv8PtTV7kipln2jOP01zPh1LQhZ9Qu/iZ1rYOsKKLYdfgVaZ4J5P/aiXVmPdoLl
SmO5gyjsx+LsRgEvJZPqdTucoJWSnzexf4AI66edyeOyGoKj66w=
=p1Or
-----END PGP SIGNATURE-----

--u4twyzyo3rubrpig--
