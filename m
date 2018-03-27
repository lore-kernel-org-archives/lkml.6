Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeC0I57 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:57:59 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36041 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbeC0I54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:57:56 -0400
X-Originating-IP: 2.224.242.101
Date: Tue, 27 Mar 2018 10:57:48 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Rob Herring <robh@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        architt@codeaurora.org, airlied@linux.ie, horms@verge.net.au,
        magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: display: bridge: Document
 THC63LVD1024 LVDS decoder
Message-ID: <20180327085748.GK27746@w540>
References: <1521213399-31947-1-git-send-email-jacopo+renesas@jmondi.org>
 <1521213399-31947-2-git-send-email-jacopo+renesas@jmondi.org>
 <4060923.7DxT9ae38L@avalon>
 <20180326222249.tvjiutyd4amlibpa@rob-hp-laptop>
 <CGME20180327061536epcas5p40faf6caf0d9825e6c33cd3e6ba9d8378@epcas5p4.samsung.com>
 <a1b0e678-38b8-dd29-b441-e2a09b565105@mentor.com>
 <1dd27170-153c-90f6-e13f-949ba7d0d4a9@samsung.com>
 <20180327073332.GI27746@w540>
 <70826dc1-d9ea-dc98-f591-c80f1904806a@cogentembedded.com>
 <b7d0e35e-3077-feba-dded-9b8f8422367b@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
In-Reply-To: <b7d0e35e-3077-feba-dded-9b8f8422367b@mentor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

On Tue, Mar 27, 2018 at 11:30:29AM +0300, Vladimir Zapolskiy wrote:
> Hi Sergei,
>
> On 03/27/2018 11:27 AM, Sergei Shtylyov wrote:
> > Hello!
> >
> > On 3/27/2018 10:33 AM, jacopo mondi wrote:
> > [...]
> >>>>>>> Document Thine THC63LVD1024 LVDS decoder device tree bindings.
> >>>>>>>
> >>>>>>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >>>>>>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> >>>>>>> Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragn=
atech.se>
> >>>>>>> ---
> >>>>>>>   .../bindings/display/bridge/thine,thc63lvd1024.txt | 66 +++++++=
++++++++++++
> >>>>>>>   1 file changed, 66 insertions(+)
> >>>>>>>   create mode 100644
> >>>>>>> Documentation/devicetree/bindings/display/bridge/thine,thc63lvd10=
24.txt
> >>>>>>>
> >>>>>>> diff --git
> >>>>>>> a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd=
1024.txt
> >>>>>>> b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd=
1024.txt
> >>>>>>> new file mode 100644
> >>>>>>> index 0000000..8225c6a
> >>>>>>> --- /dev/null
> >>>>>>> +++
> >>>>>>> b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd=
1024.txt
> >>>>>>> @@ -0,0 +1,66 @@
> >>>>>>> +Thine Electronics THC63LVD1024 LVDS decoder
> >>>>>>> +-------------------------------------------
> >>>>>>> +
> >>>>>>> +The THC63LVD1024 is a dual link LVDS receiver designed to conver=
t LVDS
> >>>>>>> streams
> >>>>>>> +to parallel data outputs. The chip supports single/dual input/ou=
tput modes,
> >>>>>>> +handling up to two two input LVDS stream and up to two digital C=
MOS/TTL
> >>>>>>> outputs.
> >>>>>>> +
> >>>>>>> +Single or dual operation modes, output data mapping and DDR outp=
ut modes
> >>>>>>> are
> >>>>>>> +configured through input signals and the chip does not expose an=
y control
> >>>>>>> bus.
> >>>>>>> +
> >>>>>>> +Required properties:
> >>>>>>> +- compatible: Shall be "thine,thc63lvd1024"
> >>>>>>> +
> >>>>>>> +Optional properties:
> >>>>>>> +- vcc-supply: Power supply for TTL output and digital circuitry
> >>>>>>> +- cvcc-supply: Power supply for TTL CLOCKOUT signal
> >>>>>>> +- lvcc-supply: Power supply for LVDS inputs
> >>>>>>> +- pvcc-supply: Power supply for PLL circuitry
> >>>>>> As explained in a comment to one of the previous versions of this =
series, I'm
> >>>>>> tempted to make vcc-supply mandatory and drop the three other powe=
r supplies
> >>>>>> for now, as I believe there's very little chance they will be conn=
ected to
> >>>>>> separately controllable regulators (all supplies use the same volt=
age). In the
> >>>>>> very unlikely event that this occurs in design we need to support =
in the
> >>>>>> future, the cvcc, lvcc and pvcc supplies can be added later as opt=
ional
> >>>>>> without breaking backward compatibility.
> >>>>> I'm okay with that.
> >>>>>
> >>>>>> Apart from that,
> >>>>>>
> >>>>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>>>>
> >>>>>>> +- pdwn-gpios: Power down GPIO signal. Active low
> >>>>> powerdown-gpios is the semi-standard name.
> >>>>>
> >>>> right, I've also noticed it. If possible please avoid shortenings in
> >>>> property names.
> >>>
> >>> It is not shortening, it just follow pin name from decoder's datashee=
t.
> >>>
> >>>>
> >>>>>>> +- oe-gpios: Output enable GPIO signal. Active high
> >>>>>>> +
> >>>> And this one is also a not ever met property name, please consider to
> >>>> rename it to 'enable-gpios', for instance display panels define it.
> >>>
> >>>
> >>> Again, it follows datasheet naming scheme. Has something changed in DT
> >>> conventions?
> >>
> >> Seconded. My understanding is that the property name should reflect
> >> what reported in the the chip manual. For THC63LVD1024 the enable and
> >> power down pins are named 'OE' and 'PDWN' respectively.
> >
> >     But don't we need the vendor prefix in the prop names then, like
> > "renesas,oe-gpios" then?
> >
>
> Seconded, with a correction to "thine,oe-gpios".
>

mmm, okay then...

A grep for that semi-standard properties names in Documentation/
returns only usage examples and no actual definitions, so I assume this
is why they are semi-standard. Seems like there is some tribal knowledge
involved in defining what is semi-standard and what's not, or are those
properties documented somewhere?

Thanks
   j


> If vendor agnostic properties are supposed to be used, then please follow
> the referenced by Rob semi-standard notations.
>
> --
> With best wishes,
> Vladimir

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJaugeMAAoJEHI0Bo8WoVY8G90QAMPMZSrBI95urx2ZdnVLInNR
ICWC3VOoKpZBulwSr6ALrIuWCtqTW+7wqEMtOvK4NVsn+e4eIiMFrZn4F9jA64fg
9KHSPPCuq4dX4DlMbpfnYUcUoB/uVeqNvcKgjmtopX1ADYu8NTbFBODlW4OJgamG
fKhgHOzFKmcgsvlamJJDiOz6gZ1mfExdU4aoNko9WP+DKjVVMlp5dDEY8PhUXO6m
brYzILx0qDNBS326663obFJUTtsrxtZiz6+kXTHLdPYM8ZIUqgSg7y6ImRZW8UiG
W+kPh9vA38NES38b6LQWD390Lxe9azf3APDuHkDxRH4sb5SJLw4T2v94g3zM+bQo
AzlKvXCuRyZ0IC1oUE9xx3ke/vhLsLmLlpdbwz4X8nAqUYzY//CHQ422NgrYZQaj
zZofFllZqiEBGFvGbuOYivHIq4++ETsBDZpjt3y7Tw5RZ3tmRmFPPs0r9eZDtblG
bZL+DnJRrVU9L/W6YAiL1NC+Vp3/t4I3bj2WXwgvTKrZcczjw0f2iRwF43Zo3J6x
Fl/sxfXN+zvm5oxTEMfgqjHpPrOFwus5a5c1dvaLvIfaVRFcrY8PpoBbmmcMpEPV
rB0CksBDXdQ9Nsl846gFnoCRPrQ4nnZchOvCQVcLkVs1/tlZRjEK9EPcYftfikfS
UywS94jzTffh795euNmZ
=GySd
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
