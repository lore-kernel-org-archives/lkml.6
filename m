Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 49BFFC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E83208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E83208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=settrans.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935097AbeFMJyC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:54:02 -0400
Received: from verain.settrans.net ([93.93.131.233]:39382 "EHLO
        verain.settrans.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933732AbeFMJyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:54:00 -0400
Received: from [5.79.74.140] (helo=lotus.a.rb)
        by verain.settrans.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <rah@settrans.net>)
        id 1fT2TV-00055O-5K; Wed, 13 Jun 2018 10:53:57 +0100
Received: from localhost ([127.0.0.1])
        by lotus.a.rb with esmtp (Exim 4.89)
        (envelope-from <rah@settrans.net>)
        id 1fT2TP-0005m0-Fo; Wed, 13 Jun 2018 10:53:51 +0100
Subject: Re: [linux-sunxi] Re: [PATCH v2] arm: sun4i: Add support for Pengpod
 1000 tablet
To:     Hans de Goede <hdegoede@redhat.com>, maxime.ripard@bootlin.com
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180602160313.26763-1-rah@settrans.net>
 <20180604081302.hcn7j36gt6xeyquq@flea>
 <313a74ea-0be6-cff1-6b2f-06a4b0b7ba8d@settrans.net>
 <20180605145038.qptdlcphdbnw6jyg@flea>
 <e2787b2a-230d-ea3c-89b9-316ddcd20f67@settrans.net>
 <4d041794-ba90-a9a6-0886-0ca18dab62b9@redhat.com>
From:   Bob Ham <rah@settrans.net>
Message-ID: <94669083-3729-ba6b-cede-40b380cf2440@settrans.net>
Date:   Wed, 13 Jun 2018 10:53:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <4d041794-ba90-a9a6-0886-0ca18dab62b9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="seX7YoAhObCgIOpbJSwDy9sXI4ucIbBbu"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--seX7YoAhObCgIOpbJSwDy9sXI4ucIbBbu
Content-Type: multipart/mixed; boundary="MuQfhw3gHqhFSjADgagDwndjWs0OUCHpe";
 protected-headers="v1"
From: Bob Ham <rah@settrans.net>
To: Hans de Goede <hdegoede@redhat.com>, maxime.ripard@bootlin.com
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-ID: <94669083-3729-ba6b-cede-40b380cf2440@settrans.net>
Subject: Re: [linux-sunxi] Re: [PATCH v2] arm: sun4i: Add support for Pengpod
 1000 tablet
References: <20180602160313.26763-1-rah@settrans.net>
 <20180604081302.hcn7j36gt6xeyquq@flea>
 <313a74ea-0be6-cff1-6b2f-06a4b0b7ba8d@settrans.net>
 <20180605145038.qptdlcphdbnw6jyg@flea>
 <e2787b2a-230d-ea3c-89b9-316ddcd20f67@settrans.net>
 <4d041794-ba90-a9a6-0886-0ca18dab62b9@redhat.com>
In-Reply-To: <4d041794-ba90-a9a6-0886-0ca18dab62b9@redhat.com>

--MuQfhw3gHqhFSjADgagDwndjWs0OUCHpe
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 13/06/18 08:28, Hans de Goede wrote:
> On 05-06-18 20:18, Bob Ham wrote:

>> It's a fine point but it makes me nervous.=C2=A0 I originally based my=
 .dts
>> on sun4i-a10-inet1.dts.=C2=A0 I've CC'd the original copyright holder,=
 Hans
>> de Goede.=C2=A0 Hans, are you willing to give permission for the licen=
se
>> notice to be replaced with just an SPDX header indicating the dual
>> licensing?
>=20
> Yes that is fine by me and you've my permission to switch to using
> just the SPDX header.

Excellent, thanks! :-)


--=20
Bob Ham <rah@settrans.net>

for (;;) { ++pancakes; }


--MuQfhw3gHqhFSjADgagDwndjWs0OUCHpe--

--seX7YoAhObCgIOpbJSwDy9sXI4ucIbBbu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

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
=tFlK
-----END PGP SIGNATURE-----

--seX7YoAhObCgIOpbJSwDy9sXI4ucIbBbu--
