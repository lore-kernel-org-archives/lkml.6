Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933040AbeE2Kqm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:46:42 -0400
Received: from butterbrot.org ([176.9.106.16]:45712 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932828AbeE2Kqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:46:37 -0400
Subject: Re: [PATCH 0/9] Hid multitouch rewrite, support os system multi-axis
 devices
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com, Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180529095800.13504-1-benjamin.tissoires@redhat.com>
From: Florian Echtler <floe@butterbrot.org>
Openpgp: preference=signencrypt
Autocrypt: addr=floe@butterbrot.org; prefer-encrypt=mutual; keydata=
 xsDiBDuvTgcRBAD3yCehD8VSv9/5ALV2PGNpRyPd/H7y4E0nh/fNHjOtq/Iy822ZQgPxP9+a
 nbtC7KMzT0JIr5ontFH4TuMxikeE92ID+h0a755FiHAtSACXzNcLY370YfRJuTQMBANEwf/T
 ozY7clf8uZc9emk0TLQJ7ZFksRAxd2Ql3lyGlM+jEQCg/6aPMk/pV3Jjfz01dckZH65DSb0E
 AKcZOV/KpQwPqRE1L7yEax19p1+38InBhGQg5ZORsPDXNDKAx5TovSM/4H68DzVjCTtb1Qig
 E2InSlT4qxOZq2hTIwsbUrl4YrOLG0msYeB+1avaVCxkjEs4e6fYX9VvJxUdgkYSmwWxzSGK
 wiEeRlbcNGdKeVKYezNyjRKO5OnSBACb3t89sJsqaotwh+CO4cwgKbjIgHnIjH5TminqiGt9
 chYXGA+IjkVef+Q/pWRzXj4IDC1gubW5GELuMa6WO+aMchJKfD4VDflvdUqWTuXKj6qjwxnY
 qtX/3O7QwVFoVgkPqsl8goAPSGk5lWHIvKJJUSMFgjWG+BafnppZs/R+Bc0lRmxvcmlhbiBF
 Y2h0bGVyIDxmbG9lQGJ1dHRlcmJyb3Qub3JnPsJjBBMRAgAjAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AFAk47tRkCGQEACgkQ7CzyshGvatgVzgCg9kkfrcPWEmqSADhAX4Bj83gZQEgA
 n1PrIrMQE85069aGgJE/kuMyWUJczsFNBDuvTggQCAD2Qle3CH8IF3KiutapQvMF6PlTETlP
 tvFuuUs4INoBp1ajFOmPQFXz0AfGy0OplK33TGSGSfgMg71l6RfUodNQ+PVZX9x2Uk89PY3b
 zpnhV5JZzf24rnRPxfx2vIPFRzBhznzJZv8V+bv9kV7HAarTW56NoKVyOtQa8L9GAFgr5fSI
 /VhOSdvNILSd5JEHNmszbDgNRR0PfIizHHxbLY7288kjwEPwpVsYjY67VYy4XTjTNP18F1dD
 ox0YbN4zISy1Kv884bEpQBgRjXyEpwpy1obEAxnIByl6ypUM2Zafq9AKUJsCRtMIPWakXUGf
 nHy9iUsiGSa6q6Jew1XpMgs7AAICCACB1zq0sSVcye/cvwTnHZyGvILT6VU8+xUxvmG9ota2
 yuk9A+0GSnDpjNxyBkmDBVQkLLvW8lBErPYvaq9pFMeYntOhYwRP31e7rbsWh48QjfkL5M/X
 Q5kFCTO4jVXHXYJ034x0vXamDDzFbAdUg/V/zN+KRIcEZcs8foIgC7BR6i/TsCsFHN3OHAmk
 hZ8NRB//UIJXxq3CcBXLiu2OGFrfoSvpAp5OzMyrWneMCaySmN/i3wSYl6h3Nl4YRMH6Yx+E
 RnNF5/cy3xUZODG1JHnEw+owc0dl3ch+oQe0t3zN5LGAznf7hYmOYl27xvym/FVA/skTD1wM
 MZhfxLVyis75wlQEGBECAAwFAjuvTggFGwwAAAAAEgkQ7CzyshGvatgHZUdQRwABASUVAKC7
 c7SIc/xurEhWVpzt1wPPsPOQ2wCglsSZ1yg7JIMh4o+a178IK9ozwQY=
Message-ID: <a6f0601c-fd8b-2a16-6f66-77f350f114b5@butterbrot.org>
Date: Tue, 29 May 2018 12:38:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529095800.13504-1-benjamin.tissoires@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pL9bhnipVP4hcfXdt4QGiBKpLCMZGfPtt"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pL9bhnipVP4hcfXdt4QGiBKpLCMZGfPtt
Content-Type: multipart/mixed; boundary="zPmzaN3Oc5uTMkrpGrjoq1nKzy9Z4CPb5";
 protected-headers="v1"
From: Florian Echtler <floe@butterbrot.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com, Peter Hutterer <peter.hutterer@who-t.net>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <a6f0601c-fd8b-2a16-6f66-77f350f114b5@butterbrot.org>
Subject: Re: [PATCH 0/9] Hid multitouch rewrite, support os system multi-axis
 devices
References: <20180529095800.13504-1-benjamin.tissoires@redhat.com>
In-Reply-To: <20180529095800.13504-1-benjamin.tissoires@redhat.com>

--zPmzaN3Oc5uTMkrpGrjoq1nKzy9Z4CPb5
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello Benjamin,

I have a side question about your patchset: for the SUR40 touchscreen, we=
 had a
discussion a while ago about how to support the different object types wh=
ich the
firmware can detect (plain touch contact, printed token with ID, generic =
blob
outline). Would the pass-through for the tool type allow us to differenti=
ate
those, once we define suitable tool types for each object class?

Thanks & best regards, Florian

On 29.05.2018 11:57, Benjamin Tissoires wrote:
> Hi Jiri,
>=20
> this heavy rewrite of hid-multitouch serves two main purposes:
> - the first point is to enable the support of the Totem on the Dell Can=
vas 27.
>   This new type of devices (System Multi Axis) is used by Microsoft to =
show
>   a new circular menu that is used by the second hand while you interac=
t with
>   your preferred hand with your tool.
>   I couldn't enable it before because hid-multitouch expected to have o=
nly one
>   multitouch collection, and this device is exported as a separate mult=
itouch
>   collextion in the same HID device than the one containing the touch s=
ensor.
>=20
> - the second point is to streamline the process of the multitouch event=
s. We
>   used to temporary store the events in a struct as they come in, and t=
hen do
>   the processing on the cache we just made. When doing the processing w=
as also
>   not very clear. This made that even if hid-multitouch should IMO be m=
erged in
>   hid-core, we couldn't.
>=20
>   The new processing of the events here adds a preparsing of the report=
 in
>   one HID collection (application usage), and from now on, the processi=
ng
>   of the report is cleaner IMO. I still haven't merged hid-mt into hid-=
core,
>   because even if I wrote a bunch of unit tests trying to not break any=
 devices,
>   we are not protected from a weird thing that magically happened befor=
e but is
>   now broken.
>=20
> I must say that when I worked on the tests, I came to realise that some=
 legacy
> Win7 devices were better handled now. Initially I thought my new code b=
roke them
> but comparing the outputs from https://github.com/bentiss/hid-devices b=
efore
> and after the changes, the new changes are closer to what I would expec=
t by
> looking at the raw HID events.
>=20
> I also included 2 patches to enable the Surface Dial. It's a BLE device=
 similar
> to the Totem from Dell, except that you can buy it for roughly $80 inst=
ead of
> $1800 for the Canvas.
>=20
>=20
> Dmitry, 2 patches are of interest for you:
> - 1/9 Input: mt - export MT_TOOL in input_mt_init_slot()
> - 7/9 HID: input: enable Totem on the Dell Canvas 27
>=20
> The second one exports a new MT_TOOL. In theory, I think patch 1/9 coul=
d be
> carried through your tree but it'll be better to have the full series a=
pplied
> at once.
>=20
> Cheers,
> Benjamin
>=20
> Benjamin Tissoires (9):
>   Input: mt - export MT_TOOL in input_mt_init_slot()
>   HID: multitouch: make sure the static list of class is not changed
>   HID: multitouch: Store per collection multitouch data
>   HID: multitouch: store a per application quirks value
>   HID: multitouch: ditch mt_report_id
>   HID: multitouch: remove one copy of values
>   HID: input: enable Totem on the Dell Canvas 27
>   HID: core: do not upper bound the collection stack
>   HID: microsoft: support the Surface Dial
>=20
>  drivers/hid/hid-core.c                   |  17 +-
>  drivers/hid/hid-input.c                  |   3 +
>  drivers/hid/hid-microsoft.c              |  49 +-
>  drivers/hid/hid-multitouch.c             | 941 ++++++++++++++++++-----=
--------
>  drivers/input/input-mt.c                 |   1 +
>  drivers/input/rmi4/rmi_2d_sensor.c       |   2 -
>  drivers/input/touchscreen/atmel_mxt_ts.c |   2 -
>  drivers/input/touchscreen/hideep.c       |   2 -
>  drivers/input/touchscreen/wacom_w8001.c  |   2 -
>  include/linux/hid.h                      |  15 +-
>  include/uapi/linux/input.h               |   3 +-
>  11 files changed, 616 insertions(+), 421 deletions(-)
>=20


--=20
SENT FROM MY DEC VT50 TERMINAL


--zPmzaN3Oc5uTMkrpGrjoq1nKzy9Z4CPb5--

--pL9bhnipVP4hcfXdt4QGiBKpLCMZGfPtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlsNLZEACgkQ7CzyshGvatgjOACg0bFa3eJ5R8lTLZk9olunBe+8
d/YAn1u/GGQw2qhAM8KSJaHq4iGrW4gc
=WOig
-----END PGP SIGNATURE-----

--pL9bhnipVP4hcfXdt4QGiBKpLCMZGfPtt--
