Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeDSKcX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:32:23 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:41399 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeDSKcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:32:21 -0400
Date: Thu, 19 Apr 2018 12:32:07 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, horms@verge.net.au, magnus.damm@gmail.com,
        geert@linux-m68k.org, niklas.soderlund@ragnatech.se,
        sergei.shtylyov@cogentembedded.com, robh+dt@kernel.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] dt-bindings: display: bridge: Document
 THC63LVD1024 LVDS decoder
Message-ID: <20180419103207.GA4235@w540>
References: <1523357590-3841-1-git-send-email-jacopo+renesas@jmondi.org>
 <1523357590-3841-2-git-send-email-jacopo+renesas@jmondi.org>
 <29caaf6f-1783-9b01-5304-8748398d41c6@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <29caaf6f-1783-9b01-5304-8748398d41c6@mentor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 12:44:32PM +0300, Vladimir Zapolskiy wrote:
Hi Vladimir,

> Hi Jacopo, Laurent,
>
> On 04/10/2018 01:53 PM, Jacopo Mondi wrote:
> > Document Thine THC63LVD1024 LVDS decoder device tree bindings.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> > Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>
> > ---
> >  .../bindings/display/bridge/thine,thc63lvd1024.txt | 60 ++++++++++++++=
++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/th=
ine,thc63lvd1024.txt
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/thine,thc=
63lvd1024.txt b/Documentation/devicetree/bindings/display/bridge/thine,thc6=
3lvd1024.txt
> > new file mode 100644
> > index 0000000..0b23e70
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd10=
24.txt
> > @@ -0,0 +1,60 @@
> > +Thine Electronics THC63LVD1024 LVDS decoder
> > +-------------------------------------------
> > +
> > +The THC63LVD1024 is a dual link LVDS receiver designed to convert LVDS=
 streams
> > +to parallel data outputs. The chip supports single/dual input/output m=
odes,
> > +handling up to two LVDS input streams and up to two digital CMOS/TTL o=
utputs.
> > +
> > +Single or dual operation mode, output data mapping and DDR output mode=
s are
> > +configured through input signals and the chip does not expose any cont=
rol bus.
> > +
> > +Required properties:
> > +- compatible: Shall be "thine,thc63lvd1024"
> > +- vcc-supply: Power supply for TTL output, TTL CLOCKOUT signal, LVDS i=
nput,
> > +  PPL and digital circuitry
> > +
> > +Optional properties:
> > +- powerdown-gpios: Power down GPIO signal, pin name "/PDWN". Active low
>
> Thank you for the change.
>
> I would suggest to rename 'pwdn-gpios' property of THC63LVDM83D as well,
> as far as I understand it is only described in DT bindings documentation,
> and the property is unused in the driver or board DTS files at the moment.

Thanks for the suggestion, I'll do that!

>
> > +- oe-gpios: Output enable GPIO signal, pin name "OE". Active high
>
> Okay :)

Yeah, please see Rob's and Laurent's reply to v7, where I renamed this
to 'enable'.

Thanks
   j
>
> --
> With best wishes,
> Vladimir

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJa2HAnAAoJEHI0Bo8WoVY8CLUP/0oI3S4m1u0cQT7zFrVBWQKA
Z/1mTuAz3fbLQgzg3IRlQm9CdmTqt3EzZ6bCkuV/qw2Xx9VXLqHp/tQbw7oYKTzD
ZinQKq4o5vx+EjrKmoA8T4YFgfIHYvlfGAc+s5GvZ/+xjP5sJv6O0oEZe9jrrtz3
ZL7fxvkwSrBnpz9xrkmBfZLhlrSQW+eseEEATIQ0Fr0njHr+ojVcAIEurEpfvF6u
MJ6LMpGJY6clEJZWNQ/HjFvmVupJxz5LS14utEdKM1fHOjte2fPjlmd+RCaKu1T4
jlx/QMY6/m5YWv+tjBRSmHA7LVF5eZzw/six5F1vSnjfsGfpSRa5f4RO2O0hheX6
mEAjzjh699D8zCl2i/9ZDiiRVoSCQsvopS32ry/ZNnjqVoiqQkpKYg4GPtOWBLEr
IxsUFdXC88+Z0cywWnwYgHbMfgY0Ine1NitAItkY3Tr4lArPC521FMg6fshiOKTz
ALKAbcmMXTAEHrw8B67Bsew5G9+m+FDu5zj5P9gVznsE+fVrYjmrIuuTpwVZQZEJ
VKY7CNxwWnR8UIEoHWnBsDGDwKxcl+ulF8xkgxzePWzaRaiaCJ/ds8eb1ddzV9zr
5Zlkg5uXo7aGYYLepXVbk/0t/WhbahLZ6w9R7y5iQih1f/Ua85G3GXpJb5a4nz1M
k0T8RtEx0GtoSHxcjZN/
=2O14
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
