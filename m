Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E03AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448FD20685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="hiEN8kuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfAIR6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:58:03 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:35324 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfAIR6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6R7sQ7fJ9l0GkAGymmk7WDdduaIArADKDH45rkx6vkg=; b=hiEN8kuqrchIjfVDzPWrFbbGY
        8QexCKzOQGVA2Uf/4zPS/b62Rzpau9/gpSgJsa4CNmzqlYA4qOnO8Mvcm99Hq8V155MRz5S+Z1HbE
        0zw1bIE53fwbS1dHblbgLP4YXZJCyIzap3yvkKPCYo+COUR22lvA01tD8A4lW/WYmD3U0=;
Received: from pd9e2f330.dip0.t-ipconnect.de ([217.226.243.48] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1ghI71-0002mA-Rf; Wed, 09 Jan 2019 18:57:55 +0100
Date:   Wed, 9 Jan 2019 18:57:51 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?B?QmVu?= =?UTF-8?B?b8OudA==?= Cousson 
        <bcousson@baylibre.com>, devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        linux-omap <linux-omap@vger.kernel.org>,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH v2] arm: dts: gta04: add bluetooth serdev driver flags
Message-ID: <20190109185751.3268420b@aktux>
In-Reply-To: <913cd7034be0d05c01148cbcedbb663454772b03.1547056071.git.hns@goldelico.com>
References: <913cd7034be0d05c01148cbcedbb663454772b03.1547056071.git.hns@goldelico.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TaioDOt1mgAJmI9iA1fT2fy"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TaioDOt1mgAJmI9iA1fT2fy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed,  9 Jan 2019 18:47:52 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> From: Andreas Kemnade <andreas@kemnade.info>
>=20
> gta04a[34] have bluetooth chips which simply understand
> h4 protocol.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

what about upstreaming the full patch based on mainline and not your
on-top-of-other-stuff rebased version of this patch?

Regards,
Andreas

> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3=
-gta04.dtsi
> index 499e3b0e920b..ec7b1e31c07e 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -722,6 +722,8 @@
> =20
>  	bluetooth: bluetooth {
>  		compatible =3D "wi2wi,w2cbw003-bluetooth";
> +		speed =3D <3000000>;
> +		flow;
>  		vdd-supply =3D <&vaux4>;
>  	};
>  };


--Sig_/TaioDOt1mgAJmI9iA1fT2fy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlw2Nh8ACgkQfb1qx03i
kyQePQ/+Kv60fIIvUZiM0/ICT6QwC0h7u0jvd73APxMzo275d3rcML2iN5xj9jiO
VX6LwpfUP3hrUtkqOrdnKAtI95EbYlfOZctYEsV2s+RI5LN0qFN+eOrlXh6qLp6U
zYLlvhe56brMUXV9o6EVwQCB1zVK4fZ/32xQfTarPYsjb4+zTMtPh80ptFQttN/A
cyc9z4UdUFYfb5nhBFb9xjZKgnBuiv6FqcUQcIXrXwtL5fhALPSg8xCC9CkGkeh0
ejTjeMW9eKennDSX96VO57clfitB7+r/O4R5hIEOZy/ZwzfGqPmvwb9HKElix/jJ
3KEfnYQ4/7KkF/UuriJ4r0DBlK0MB40KVjNHlGAzH5vAvI3Cw2igiy1DmM4fNfCb
e0daOrMGaOpfQ9FThrnNsP5tVmTebs5fIxGGdLJNgAnj0T20gLez9LT8pcMZYmZN
52aaCzTHdu1uov7i07JDwu69NWLIM2AqUgNrEU61yHbzc50FVH8ytiihzH5AbOPR
a308K7mAOUVw8oV9jh+jkXa7sm1oWnx08AWlNWBqDpJm1ZZf9aCQFUJQUTo8WXpA
a7xJX8T0fobe9kP0WyZrkie1Zf+59PxtZ2DX54pqQLnYlVOgCLUXp33zPNaH8fcO
Qz7U1pZ72BQjignyHcLm6SDfs8z/lWVVAhTu/CtdWf/gBw1EaC8=
=bbpC
-----END PGP SIGNATURE-----

--Sig_/TaioDOt1mgAJmI9iA1fT2fy--
