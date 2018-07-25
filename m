Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC89C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253CF20893
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="SABusRL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253CF20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbeGYNnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:43:24 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:18177 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbeGYNnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1532521913;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ReIfomQBJx3tNlFXyC49nKV2keiduo3Dxs1WyULAq9s=;
        b=SABusRL928J8XHIGOc4k3cBj0Aa7d/g27l0mhK21pJBXRKNoAjJup7oYxqToxgZURK
        Q8VmuhzwMRwHS2TTjNrFP+symEOLqwfzRyCWixBk0j3jI1r0Okil5WiU8KcE2SJBJlv5
        9OOKmLlZgO54mSdsobL9aDsXcRs91muOvpP3FsHcAzscMU0ueSgAJwLaCbnaqgV7qDrC
        z6IquaHb7SExMHZITYknGcb3ayN26510PgXxkg2Jb8L7vlaePz9+qiQNd0jd5DdZrCt4
        0nld6i5RfQmlFP5Xq6T7XIMCEYjsHouhbNPhdr+lO3Q+kNZxatIXMEIqYIdzzkryFOi8
        rhkQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87Wiuc1qET/2Lw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6PCVpfQm
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 25 Jul 2018 14:31:51 +0200 (CEST)
Subject: Re: [PATCH 04/32] ARM: dts: omap3-gta04: fixes for tvout / venc
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_76CB1DAC-E045-4FA2-BE6A-5ED1FEE3CA78"; protocol="application/pgp-signature"; micalg=pgp-sha256
X-Pgp-Agent: GPGMail
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180725103750.4yltpfswd52fpw63@earth.universe>
Date:   Wed, 25 Jul 2018 14:31:48 +0200
Cc:     Marek Belisko <marek@goldelico.com>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Message-Id: <7FAC0538-D5AE-4DCF-9036-DAD881E957C5@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com> <73e5b1fd4cc27e3148c6bc2e8f8281f3996ccf68.1532501910.git.hns@goldelico.com> <20180725103750.4yltpfswd52fpw63@earth.universe>
To:     Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_76CB1DAC-E045-4FA2-BE6A-5ED1FEE3CA78
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Sebastian,

> Am 25.07.2018 um 12:37 schrieb Sebastian Reichel =
<sebastian.reichel@collabora.co.uk>:
>=20
> Hi,
>=20
> On Wed, Jul 25, 2018 at 08:58:36AM +0200, H. Nikolaus Schaller wrote:
>> 			port@1 {
>> -				reg =3D <1>;
>> +				reg =3D <0>;
>=20
> You should also update the node name.

I did take another look at this and we might have the wrong fix here =
anyways.
The first indication is that a port@0 already exists soI can't simply =
rename
the node.

The opa362 is an exceptional dssdev since it has an input and an output =
port
which should be differentiated by the reg property and the node name.

Ports are apparently matched by reg number, i.e. here:

	=
https://elixir.bootlin.com/linux/v4.18-rc6/source/drivers/gpu/drm/omapdrm/=
dss/output.c#L146

The issue seems to be that the driver does not set the out->port_num of =
the endpoint to 1.

	=
https://elixir.bootlin.com/linux/v4.18-rc6/source/drivers/gpu/drm/omapdrm/=
displays/encoder-opa362.c#L205

So the <1> does not match and we were just lucky to make it working by =
choosing <0> in the DT.

I'll need a little time to test if a (one-liner) patch for the driver =
does the same/right thing.

And since it is omapdss related I've put Tomi on CC:

BR,
Nikolaus

--Apple-Mail=_76CB1DAC-E045-4FA2-BE6A-5ED1FEE3CA78
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJbWG22AAoJEIl79TGLgAm6ZiMP/RhFnFf6AHORlWK28kLa3vp/
HvpLkIMcL+3r8XBWHAc0ywYj6+ns+VUIlLDMMqKAoc6BM4fkKBINGb0aoWAo99dl
qoH+0nFgj/J+6SBKmx2WKF8JkO5W7sp6bY42PanbJk/rn+3RAPvmK3Gppk4MBy/p
N1C4ZGcZ9irHP1JN3Cstamau4/L4QtngbIEQxOIwyvETYhjwcLWfcNnEywjOwMiu
oA11ptfu6zXI17/Wz27GvRSQoNcIrxCNFxsyV55JnCiUwsvqXycsVH7VSVGsrPRs
G/pRZGXV18hBrTPL8LQESOEUnKw5UhcveZZWvOK7F+VZtmLCoH256SKZAQ/zu/x/
5jy6M6vpG4ConovaJ6k1XLwV7tjq2Y9BC86JxJ9D0EHs9bEq1rbRbPZK9UX2Kviq
gHOkIIIwbMhKggXfgIE79MJWu6CCQP0bS3WuRx54DZQIO4B6oVBzBG0pB2o9HrRC
/35i7OwI7T6X/lN0MIkzFVSjwZpzTQ7qcUJlhIl/XerGlb7cEpcZtpgCkxnisK2n
ZSBvCxd0nR/o/vE5Npb6lJfqe4RNl5ePdo1YSn6KgxzFtAeaH46TJlUZ0HVwWV8V
T0tdEPkubk3rWc6/7F4TKEkxqrEoDaDD4yWkhyxP0nd7Yk7HO25BILfIR3DD6y1Y
1nSg1MqRrEiPIHKkePhB
=aGiN
-----END PGP SIGNATURE-----

--Apple-Mail=_76CB1DAC-E045-4FA2-BE6A-5ED1FEE3CA78--
