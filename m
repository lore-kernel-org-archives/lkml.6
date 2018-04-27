Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932361AbeD0IkU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 04:40:20 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49028 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757548AbeD0IkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 04:40:17 -0400
Subject: Re: [PATCH 02/17] dt-bindings: display: renesas: du: Document the
 R8A77965 bindings
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:DRM DRIVERS FOR RENESAS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
 <20180426165346.494-3-kieran.bingham+renesas@ideasonboard.com>
 <e94ae62f-30bb-5056-9646-03941d74ae75@ideasonboard.com>
 <69317997.GXJe2a7Jrz@avalon>
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham@ideasonboard.com; prefer-encrypt=mutual;
 keydata=
 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
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <366c0a0f-f179-7796-fc06-94b3d949fc7f@ideasonboard.com>
Date: Fri, 27 Apr 2018 09:40:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <69317997.GXJe2a7Jrz@avalon>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="CKxIVZoB72RoTArDOvlPH2QMEqNAZ6hDL"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CKxIVZoB72RoTArDOvlPH2QMEqNAZ6hDL
Content-Type: multipart/mixed; boundary="pLp2pVKpxOWVRmxM8HJns8ahRdgVMottG";
 protected-headers="v1"
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "open list:DRM DRIVERS FOR RENESAS" <dri-devel@lists.freedesktop.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Message-ID: <366c0a0f-f179-7796-fc06-94b3d949fc7f@ideasonboard.com>
Subject: Re: [PATCH 02/17] dt-bindings: display: renesas: du: Document the
 R8A77965 bindings
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
 <20180426165346.494-3-kieran.bingham+renesas@ideasonboard.com>
 <e94ae62f-30bb-5056-9646-03941d74ae75@ideasonboard.com>
 <69317997.GXJe2a7Jrz@avalon>
In-Reply-To: <69317997.GXJe2a7Jrz@avalon>

--pLp2pVKpxOWVRmxM8HJns8ahRdgVMottG
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On 26/04/18 21:10, Laurent Pinchart wrote:
> Hi Kieran,
>=20
> Thank you for the patch.
>=20
> On Thursday, 26 April 2018 19:57:32 EEST Kieran Bingham wrote:
>> Ahem - this one seems to have lost it's commit message.
>>
>> Apologies :)
>=20
> Apart from that, this looks good to me.
>=20
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>=20
> and applied to my tree with the commit message
>=20
> Document the M3-N (r8a77965) SoC in the R-Car DU bindings
>=20

That's perfect, thanks - and saves me sending a v1.1

Regards

Kieran

> Let me know if you would like a different message.
>=20
>> On 26/04/18 17:53, Kieran Bingham wrote:
>>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.co=
m>
>>> ---
>>>
>>>  Documentation/devicetree/bindings/display/renesas,du.txt | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/renesas,du.txt=

>>> b/Documentation/devicetree/bindings/display/renesas,du.txt index
>>> a36a6e7ee54f..7c6854bd0a04 100644
>>> --- a/Documentation/devicetree/bindings/display/renesas,du.txt
>>> +++ b/Documentation/devicetree/bindings/display/renesas,du.txt
>>>
>>> @@ -13,6 +13,7 @@ Required Properties:
>>>      - "renesas,du-r8a7794" for R8A7794 (R-Car E2) compatible DU
>>>      - "renesas,du-r8a7795" for R8A7795 (R-Car H3) compatible DU
>>>      - "renesas,du-r8a7796" for R8A7796 (R-Car M3-W) compatible DU
>>> +    - "renesas,du-r8a77965" for R8A77965 (R-Car M3-N) compatible DU
>>>      - "renesas,du-r8a77970" for R8A77970 (R-Car V3M) compatible DU
>>>      - "renesas,du-r8a77995" for R8A77995 (R-Car D3) compatible DU
>>>
>>> @@ -59,6 +60,7 @@ corresponding to each DU output.
>>>
>>>   R8A7794 (R-Car E2)     DPAD 0         DPAD 1         -             =
 -
>>>   R8A7795 (R-Car H3)     DPAD 0         HDMI 0         HDMI 1        =
 LVDS
>>>   0
>>>   R8A7796 (R-Car M3-W)   DPAD 0         HDMI 0         LVDS 0        =
 -
>>> + R8A77965 (R-Car M3-N)  DPAD 0         HDMI 0         LVDS 0        =
 -
>>>   R8A77970 (R-Car V3M)   DPAD 0         LVDS 0         -             =
 -
>>>   R8A77995 (R-Car D3)    DPAD 0         LVDS 0         LVDS 1        =
 -
>=20


--pLp2pVKpxOWVRmxM8HJns8ahRdgVMottG--

--CKxIVZoB72RoTArDOvlPH2QMEqNAZ6hDL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEkC3XmD+9KP3jctR6oR5GchCkYf0FAlri4esACgkQoR5GchCk
Yf00AQ//X+oc+ghTn1uTwxozzYplHfGDBCbJkcparx4gxwS+gzbeIL8AIg3CcKWq
8nY1xMv380KKRemJIjQaAxvIpgAljTy1BUqGf+n7M12fKJcn4jmX3d6g2l4HZbcf
WgzsUB34QVtiMQRKHs52U5AkOAXo5L3fBqgL8nN0yWpQ+I5HTciZDY/S/LLIPpFB
HfNJsMdDo53d9OAwWQ9funTH6/c7uP1qwzNy3g7ZV1YfkMGmrkZG++rzJ7w51dDw
tRh6yl/BzVePvuBMwFQYO8FXKmeaHH4gPS5alvzVRmZf1GGyb50DretF4/6zV/rb
XO+leHtGkQ8NBx1DGhVNd2YSRjM3wG8VaCk4KsYzJf0r9it1pekqVijoMhv9zGQ8
yllfndPITV2zcncxweMNoQcCZAMpt6S/gMzsbfL4JyVIupVrKiPUioxivFW/ja38
j61fETqw9TYl0wgL/U/lJ+ynFBwwD1PrQLv/DHiLvzqh4CLNX8D84u3gkWjcWiYW
5bIPrYJ6uiNz/CCbA0H7yXYkrUq/ZvJgof9PRvlV50mm/WsRYaxtOtz84NNmw8it
9IIPVKgyGGdMSHsQarPWn/cQ3xiBYnzPYcEjR1hSaodZ8cJwT1/LizAPV8YfSSdD
trrdbbGaN77wtxoxC80dGn0se7/QzXWt/MxzN13DRq2OrHtKV2M=
=EFgz
-----END PGP SIGNATURE-----

--CKxIVZoB72RoTArDOvlPH2QMEqNAZ6hDL--
