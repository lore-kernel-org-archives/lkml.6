Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeFESTF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:19:05 -0400
Received: from verain.settrans.net ([93.93.131.233]:44814 "EHLO
        verain.settrans.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeFESTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:19:03 -0400
Subject: Re: [linux-sunxi] Re: [PATCH v2] arm: sun4i: Add support for Pengpod
 1000 tablet
To: maxime.ripard@bootlin.com
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180602160313.26763-1-rah@settrans.net>
 <20180604081302.hcn7j36gt6xeyquq@flea>
 <313a74ea-0be6-cff1-6b2f-06a4b0b7ba8d@settrans.net>
 <20180605145038.qptdlcphdbnw6jyg@flea>
From: Bob Ham <rah@settrans.net>
Message-ID: <e2787b2a-230d-ea3c-89b9-316ddcd20f67@settrans.net>
Date: Tue, 5 Jun 2018 19:18:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605145038.qptdlcphdbnw6jyg@flea>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jCWhrdhzfOkfSBXiEngMyxOhQfBV0IV10"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jCWhrdhzfOkfSBXiEngMyxOhQfBV0IV10
Content-Type: multipart/mixed; boundary="Q9ft8ANUDvW8vI5wFvSibA02DDaroqPVO";
 protected-headers="v1"
From: Bob Ham <rah@settrans.net>
To: maxime.ripard@bootlin.com
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <e2787b2a-230d-ea3c-89b9-316ddcd20f67@settrans.net>
Subject: Re: [linux-sunxi] Re: [PATCH v2] arm: sun4i: Add support for Pengpod
 1000 tablet
References: <20180602160313.26763-1-rah@settrans.net>
 <20180604081302.hcn7j36gt6xeyquq@flea>
 <313a74ea-0be6-cff1-6b2f-06a4b0b7ba8d@settrans.net>
 <20180605145038.qptdlcphdbnw6jyg@flea>
In-Reply-To: <20180605145038.qptdlcphdbnw6jyg@flea>

--Q9ft8ANUDvW8vI5wFvSibA02DDaroqPVO
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 05/06/18 15:50, Maxime Ripard wrote:
> On Mon, Jun 04, 2018 at 06:33:02PM +0100, Bob Ham wrote:
>> On 04/06/18 09:13, Maxime Ripard wrote:
>>> On Sat, Jun 02, 2018 at 05:03:13PM +0100, Bob Ham wrote:
>>
>>>> + * This file is dual-licensed: you can use it either under the term=
s
>>>> + * of the GPL or the X11 license, at your option. Note that this du=
al
>>>> + * licensing only applies to this file, and not this project as a
>>>> + * whole.
>>
>>>> + *     The above copyright notice and this permission notice shall =
be
>>>> + *     included in all copies or substantial portions of the Softwa=
re.
>>
>>> And this is redundant with the SPDX header.
>>
>> The X11 license notice states explicitly that the notice has to be
>> included in the file.  Wouldn't removing it be a violation of the lice=
nse?
>=20
> The SPDX header is explicitly here to remove the license text and
> create a tag that is in a indirect reference to the license text in
> LICENSES. It's not going away.

Well, the top bit that I quoted above says that the licenses refer to
only that one file in particular and not the project as a whole.  Then
the X11 license states that the notice can't be removed from 'this
software and associated documentation files (the "Software")' which
would seem to refer to the single file.  Therefore, removing the notice
from the single file and replacing it with an SPDX header would seem to
violate the license.

It's a fine point but it makes me nervous.  I originally based my .dts
on sun4i-a10-inet1.dts.  I've CC'd the original copyright holder, Hans
de Goede.  Hans, are you willing to give permission for the license
notice to be replaced with just an SPDX header indicating the dual
licensing?

While we're at it, there are a number of other files with the same
license text.  Hans, are you prepared to give permission for your other
license notices to be replaced with SPDX headers?

Thanks,

Bob

--=20
Bob Ham <rah@settrans.net>

for (;;) { ++pancakes; }


--Q9ft8ANUDvW8vI5wFvSibA02DDaroqPVO--

--jCWhrdhzfOkfSBXiEngMyxOhQfBV0IV10
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

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
=taMu
-----END PGP SIGNATURE-----

--jCWhrdhzfOkfSBXiEngMyxOhQfBV0IV10--
