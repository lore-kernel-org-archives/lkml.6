Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52DBC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2430C20859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Ie+WO2kA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfAIR6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:58:14 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:26033 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfAIR6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547056691;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=rFwJ8tCg5yChV2Li0xhyjxbi+VQsPJrIK/GtRn/2RqA=;
        b=Ie+WO2kACv0O3auff3nF+tFjokULIpBl8BKsbjcvVuXnGkgqvBaMrToAGg1R0jUlih
        ymr7/kYxkvV13PfjWBmVa49rsA9/Xolz3GpMdSiIR6RZT5b2yszTnBx751k52WNhE8W5
        vRx+OOBpmK4HPtmKFIiQ8zk7XuToMI0vt7GWYxI2Yj47mubEYYKT95yARKHUNO8jYa8O
        dT7wI8mi9fxGXnDsrKC20OOf79nyUstsZgRhCft4aXBDxi05y+WBWpx2ELhi6Ls/tVha
        ATziJhRwkkFbi2MzOf39x0n4cdkLDyPMNfNNXbpZrSDoGtWz+NuoqIljmQ1GcKa6rmco
        Zl4g==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlSZXA4PLVY="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id 608499v09Ht9S8O
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Jan 2019 18:55:09 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] [PATCH v2] arm: dts: gta04: add bluetooth serdev driver flags
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <913cd7034be0d05c01148cbcedbb663454772b03.1547056071.git.hns@goldelico.com>
Date:   Wed, 9 Jan 2019 18:55:08 +0100
Cc:     Tony Lindgren <tony@atomide.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <43B99E33-B38A-4275-A639-EA96F63ED509@goldelico.com>
References: <913cd7034be0d05c01148cbcedbb663454772b03.1547056071.git.hns@goldelico.com>
To:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ops,
that was the wrong one...
Please ignore.

> Am 09.01.2019 um 18:47 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> From: Andreas Kemnade <andreas@kemnade.info>
>=20
> gta04a[34] have bluetooth chips which simply understand
> h4 protocol.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> arch/arm/boot/dts/omap3-gta04.dtsi | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi =
b/arch/arm/boot/dts/omap3-gta04.dtsi
> index 499e3b0e920b..ec7b1e31c07e 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -722,6 +722,8 @@
>=20
> 	bluetooth: bluetooth {
> 		compatible =3D "wi2wi,w2cbw003-bluetooth";
> +		speed =3D <3000000>;
> +		flow;
> 		vdd-supply =3D <&vaux4>;
> 	};
> };
> --=20
> 2.19.1
>=20
> _______________________________________________
> http://projects.goldelico.com/p/gta04-kernel/
> Letux-kernel mailing list
> Letux-kernel@openphoenux.org
> http://lists.goldelico.com/mailman/listinfo.cgi/letux-kernel

