Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeC3NHs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 09:07:48 -0400
Received: from nala.villavu.com ([188.165.243.101]:54849 "EHLO
        nala.villavu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeC3NHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 09:07:45 -0400
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
To: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Dan Williams <dcbw@redhat.com>
References: <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
 <20180329133613.khldv72w3zj63vsk@earth.universe>
 <20180329135904.GN5700@atomide.com>
 <20180329154600.qhels5fqzzg364gj@earth.universe> <20180329163716.GA20743@amd>
 <20180329164113.GR5700@atomide.com> <20180329184007.GA27688@amd>
 <20180329215612.GS5700@atomide.com> <20180330103744.GA17404@amd>
From: Merlijn Wajer <merlijn@wizzup.org>
Openpgp: preference=signencrypt
Autocrypt: addr=merlijn@wizzup.org; keydata=
 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
 wEGOBYe/cAE=
Message-ID: <a2a7a65c-1794-66c7-0f69-5919d32665fb@wizzup.org>
Date: Fri, 30 Mar 2018 15:07:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180330103744.GA17404@amd>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hI0ZG3nfavXOuBdbdh9ms3DoDaBj3w1fc"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hI0ZG3nfavXOuBdbdh9ms3DoDaBj3w1fc
Content-Type: multipart/mixed; boundary="KsFUvhtn0PoJ53wI6USGpD3sGO1CJsV2E";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Dan Williams <dcbw@redhat.com>
Message-ID: <a2a7a65c-1794-66c7-0f69-5919d32665fb@wizzup.org>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
References: <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
 <20180329133613.khldv72w3zj63vsk@earth.universe>
 <20180329135904.GN5700@atomide.com>
 <20180329154600.qhels5fqzzg364gj@earth.universe> <20180329163716.GA20743@amd>
 <20180329164113.GR5700@atomide.com> <20180329184007.GA27688@amd>
 <20180329215612.GS5700@atomide.com> <20180330103744.GA17404@amd>
In-Reply-To: <20180330103744.GA17404@amd>

--KsFUvhtn0PoJ53wI6USGpD3sGO1CJsV2E
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 30/03/18 12:37, Pavel Machek wrote:
> On Thu 2018-03-29 14:56:13, Tony Lindgren wrote:
>> * Pavel Machek <pavel@ucw.cz> [180329 18:41]:
>>> Thanks. I got call working including outgoing audio: in capture
>>> settings, right->mic 1, Mic1 + Mic2 in alsamixer -> 100%. But I had
>>> the other phone muted, so I don't yet know if such call would be of
>>> usable quality.
>>
>> Great, good to hear that :)
>=20
> I also got ofonod to work, with rather crazy hacks. But I now have
> incoming/outgoing calls with GUI :-).

Would you mind sharing those hacks - I would like to play around with
ofonod as well. Maybe I can help with a way forward.

Cheers,
Merlijn


--KsFUvhtn0PoJ53wI6USGpD3sGO1CJsV2E--

--hI0ZG3nfavXOuBdbdh9ms3DoDaBj3w1fc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCWr42lQAKCRAGN09rynK8
WqIOAPsEJaQgN9irgNhKw3gSFFCWFTUtdRRIZww8B7hKwSil0wD/ftOoBZ/qkCxQ
hjBUIt8wHI2Cppi8doUUm7HOqyDQ6A4=
=0iGc
-----END PGP SIGNATURE-----

--hI0ZG3nfavXOuBdbdh9ms3DoDaBj3w1fc--
