Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeDFMYL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:24:11 -0400
Received: from nala.villavu.com ([188.165.243.101]:47474 "EHLO
        nala.villavu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752114AbeDFMYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:24:08 -0400
Subject: Re: call/normal switch was Re: omap4-droid4: voice call support was
To: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>
Cc: Dan Williams <dcbw@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20180331195524.GB19388@amd> <20180331234314.GZ5700@atomide.com>
 <20180401131852.GA11086@amd> <20180401153631.GA5700@atomide.com>
 <20180401173012.GB5700@atomide.com>
 <67086fdd0cdd69142cb89cd00f90e5a580e6607a.camel@redhat.com>
 <20180402155754.GD5700@atomide.com> <20180403150444.GE5700@atomide.com>
 <20180403155023.GA14638@atrey.karlin.mff.cuni.cz>
 <20180403194419.GG5700@atomide.com> <20180406120423.GA18691@amd>
From: Merlijn Wajer <merlijn@wizzup.org>
Openpgp: preference=signencrypt
Autocrypt: addr=merlijn@wizzup.org; prefer-encrypt=mutual; keydata=
 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
 wEGOBYe/cAE=
Message-ID: <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
Date: Fri, 6 Apr 2018 14:23:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180406120423.GA18691@amd>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Yg6daGM2LthClS44kTC15S8eIOJ1qdktd"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Yg6daGM2LthClS44kTC15S8eIOJ1qdktd
Content-Type: multipart/mixed; boundary="1PGQP6m7Ci8bnWYKtrlqnHrPe51cDuysD";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>
Cc: Dan Williams <dcbw@redhat.com>,
 Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Message-ID: <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
Subject: Re: call/normal switch was Re: omap4-droid4: voice call support was
References: <20180331195524.GB19388@amd> <20180331234314.GZ5700@atomide.com>
 <20180401131852.GA11086@amd> <20180401153631.GA5700@atomide.com>
 <20180401173012.GB5700@atomide.com>
 <67086fdd0cdd69142cb89cd00f90e5a580e6607a.camel@redhat.com>
 <20180402155754.GD5700@atomide.com> <20180403150444.GE5700@atomide.com>
 <20180403155023.GA14638@atrey.karlin.mff.cuni.cz>
 <20180403194419.GG5700@atomide.com> <20180406120423.GA18691@amd>
In-Reply-To: <20180406120423.GA18691@amd>

--1PGQP6m7Ci8bnWYKtrlqnHrPe51cDuysD
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/04/18 14:04, Pavel Machek wrote:
> Hi!
>=20
>> OK that explains why the speaker keeps working then :)
>=20
> Ok, I pushed new version of unicsy_demo.
>=20
> It now sends & receives sms and you can call & receive call. Tone from
> linphone is used for incoming call. User interface and code is
> slightly weird, as ofono was -- and still is -- meant as a backend.

Great news, can't wait to try it.

Did you modify ofono beyond the patches you have already posted? And
what version of ofono was that for?

Cheers,
Merlijn


--1PGQP6m7Ci8bnWYKtrlqnHrPe51cDuysD--

--Yg6daGM2LthClS44kTC15S8eIOJ1qdktd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCWsdm0gAKCRAGN09rynK8
Ws8sAP93UQwdDXpLrVbWYOChCd2Wq4VDL+W97apx969J1TFVDAD+I8heEI3NZTVS
BWnO78TUDpWCIQxqBLeD9VVDLEPeLwA=
=nLpl
-----END PGP SIGNATURE-----

--Yg6daGM2LthClS44kTC15S8eIOJ1qdktd--
