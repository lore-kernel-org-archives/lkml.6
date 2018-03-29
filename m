Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeC2KCm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 06:02:42 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54895 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751896AbeC2KCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 06:02:40 -0400
X-Originating-IP: 2.224.242.101
Date: Thu, 29 Mar 2018 12:02:24 +0200
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
Message-ID: <20180329100224.GV27746@w540>
References: <CGME20180327061536epcas5p40faf6caf0d9825e6c33cd3e6ba9d8378@epcas5p4.samsung.com>
 <a1b0e678-38b8-dd29-b441-e2a09b565105@mentor.com>
 <1dd27170-153c-90f6-e13f-949ba7d0d4a9@samsung.com>
 <20180327073332.GI27746@w540>
 <70826dc1-d9ea-dc98-f591-c80f1904806a@cogentembedded.com>
 <b7d0e35e-3077-feba-dded-9b8f8422367b@mentor.com>
 <20180327085748.GK27746@w540>
 <871a3805-b20c-3f48-406c-145461837388@mentor.com>
 <20180327101008.GM27746@w540>
 <6353eb46-5a2d-7b75-a60b-c31c59c8636a@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eGLW8NzjjVmDHwQh"
Content-Disposition: inline
In-Reply-To: <6353eb46-5a2d-7b75-a60b-c31c59c8636a@mentor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eGLW8NzjjVmDHwQh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

On Tue, Mar 27, 2018 at 02:03:25PM +0300, Vladimir Zapolskiy wrote:
> Hi Jacopo,
>
> On 03/27/2018 01:10 PM, jacopo mondi wrote:
> > Hi Vladimir,
> >
> > On Tue, Mar 27, 2018 at 12:37:31PM +0300, Vladimir Zapolskiy wrote:
> >> Hi Jacopo,
> >>
> >> On 03/27/2018 11:57 AM, jacopo mondi wrote:
> >>> Hi Vladimir,
> >>>
> >>> On Tue, Mar 27, 2018 at 11:30:29AM +0300, Vladimir Zapolskiy wrote:
> >>>> Hi Sergei,
> >>>>
> >>>> On 03/27/2018 11:27 AM, Sergei Shtylyov wrote:
> >>>>> Hello!
> >>>>>
> >>>>> On 3/27/2018 10:33 AM, jacopo mondi wrote:
> >>>>> [...]
> >>>>>>>>>>> Document Thine THC63LVD1024 LVDS decoder device tree bindings.
> >>>>>>>>>>>
> >>>>>>>>>>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >>>>>>>>>>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> >>>>>>>>>>> Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@=
ragnatech.se>
> >>>>>>>>>>> ---
> >>>>>>>>>>>   .../bindings/display/bridge/thine,thc63lvd1024.txt | 66 +++=
++++++++++++++++
> >>>>>>>>>>>   1 file changed, 66 insertions(+)
> >>>>>>>>>>>   create mode 100644
> >>>>>>>>>>> Documentation/devicetree/bindings/display/bridge/thine,thc63l=
vd1024.txt
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git
> >>>>>>>>>>> a/Documentation/devicetree/bindings/display/bridge/thine,thc6=
3lvd1024.txt
> >>>>>>>>>>> b/Documentation/devicetree/bindings/display/bridge/thine,thc6=
3lvd1024.txt
> >>>>>>>>>>> new file mode 100644
> >>>>>>>>>>> index 0000000..8225c6a
> >>>>>>>>>>> --- /dev/null
> >>>>>>>>>>> +++
> >>>>>>>>>>> b/Documentation/devicetree/bindings/display/bridge/thine,thc6=
3lvd1024.txt
> >>>>>>>>>>> @@ -0,0 +1,66 @@
> >>>>>>>>>>> +Thine Electronics THC63LVD1024 LVDS decoder
> >>>>>>>>>>> +-------------------------------------------
> >>>>>>>>>>> +
> >>>>>>>>>>> +The THC63LVD1024 is a dual link LVDS receiver designed to co=
nvert LVDS
> >>>>>>>>>>> streams
> >>>>>>>>>>> +to parallel data outputs. The chip supports single/dual inpu=
t/output modes,
> >>>>>>>>>>> +handling up to two two input LVDS stream and up to two digit=
al CMOS/TTL
> >>>>>>>>>>> outputs.
> >>>>>>>>>>> +
> >>>>>>>>>>> +Single or dual operation modes, output data mapping and DDR =
output modes
> >>>>>>>>>>> are
> >>>>>>>>>>> +configured through input signals and the chip does not expos=
e any control
> >>>>>>>>>>> bus.
> >>>>>>>>>>> +
> >>>>>>>>>>> +Required properties:
> >>>>>>>>>>> +- compatible: Shall be "thine,thc63lvd1024"
> >>>>>>>>>>> +
> >>>>>>>>>>> +Optional properties:
> >>>>>>>>>>> +- vcc-supply: Power supply for TTL output and digital circui=
try
> >>>>>>>>>>> +- cvcc-supply: Power supply for TTL CLOCKOUT signal
> >>>>>>>>>>> +- lvcc-supply: Power supply for LVDS inputs
> >>>>>>>>>>> +- pvcc-supply: Power supply for PLL circuitry
> >>>>>>>>>> As explained in a comment to one of the previous versions of t=
his series, I'm
> >>>>>>>>>> tempted to make vcc-supply mandatory and drop the three other =
power supplies
> >>>>>>>>>> for now, as I believe there's very little chance they will be =
connected to
> >>>>>>>>>> separately controllable regulators (all supplies use the same =
voltage). In the
> >>>>>>>>>> very unlikely event that this occurs in design we need to supp=
ort in the
> >>>>>>>>>> future, the cvcc, lvcc and pvcc supplies can be added later as=
 optional
> >>>>>>>>>> without breaking backward compatibility.
> >>>>>>>>> I'm okay with that.
> >>>>>>>>>
> >>>>>>>>>> Apart from that,
> >>>>>>>>>>
> >>>>>>>>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.c=
om>
> >>>>>>>>>>
> >>>>>>>>>>> +- pdwn-gpios: Power down GPIO signal. Active low
> >>>>>>>>> powerdown-gpios is the semi-standard name.
> >>>>>>>>>
> >>>>>>>> right, I've also noticed it. If possible please avoid shortening=
s in
> >>>>>>>> property names.
> >>>>>>>
> >>>>>>> It is not shortening, it just follow pin name from decoder's data=
sheet.
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>>> +- oe-gpios: Output enable GPIO signal. Active high
> >>>>>>>>>>> +
> >>>>>>>> And this one is also a not ever met property name, please consid=
er to
> >>>>>>>> rename it to 'enable-gpios', for instance display panels define =
it.
> >>>>>>>
> >>>>>>>
> >>>>>>> Again, it follows datasheet naming scheme. Has something changed =
in DT
> >>>>>>> conventions?
> >>>>>>
> >>>>>> Seconded. My understanding is that the property name should reflect
> >>>>>> what reported in the the chip manual. For THC63LVD1024 the enable =
and
> >>>>>> power down pins are named 'OE' and 'PDWN' respectively.
> >>>>>
> >>>>>     But don't we need the vendor prefix in the prop names then, like
> >>>>> "renesas,oe-gpios" then?
> >>>>>
> >>>>
> >>>> Seconded, with a correction to "thine,oe-gpios".
> >>>>
> >>>
> >>> mmm, okay then...
> >>>
> >>> A grep for that semi-standard properties names in Documentation/
> >>> returns only usage examples and no actual definitions, so I assume th=
is
> >>> is why they are semi-standard.
> >>
> >> Here we have to be specific about a particular property, let it be 'oe=
-gpios'
> >> vs. 'enable-gpios' and let's collect some statistics:
> >>
> >> % grep -Hr oe-gpios Documentation/devicetree/bindings/* | wc -l
> >> 0
> >>
> >> $ grep -Hr enable-gpios Documentation/devicetree/bindings/* | wc -l
> >> 86
> >>
> >> While 'thine,oe-gpios' would be correct, I see no reason to introduce =
a vendor
> >> specific property to define a pin with a common and well understood pu=
rpose.
> >>
> >> If you go forward with the vendor specific prefix, apparently you can =
set the name
> >> to 'thine,oe-gpio' (single) or even to 'thine,oe', or does the datashe=
et names
> >> the pin as "OE GPIO" or "OE connected to a GPIO"? I guess no.
> >>
> >
> > Let me clarify I don't want to push for a vendor specific name or
> > similar, I'm fine with using 'semi-standard' names, I'm just confused
> > by the 'semi-standard' definition. I guess from your examples, the
> > usage count makes a difference here.
>
> yes, in gneneral you can read "semi-standard" as "widely used", thus coll=
ecting
> statistics is a good enough method to make a reasoning.
>
> Hopefully the next evolutionary step of "widely used" is "described in st=
andard".
>
> >> Standards do not define '-gpios' suffix, but partially the description=
 is found
> >> in Documentation/bindings/gpio/gpio.txt, still it is not a section in =
any
> >> standard as far as I know.
> >
> >>
> >>> Seems like there is some tribal knowledge involved in defining what
> >>> is semi-standard and what's not, or are those properties documented s=
omewhere?
> >>>
> >>
> >> The point is that there is no formal standard which describes every IP,
> >> every IC and every single their property, some device node names and p=
roperty
> >> names are recommended in ePAPR and Devicetree Specification though.
> >>
> >> Think of a confusion if 'rst-gpios' (have you seen any ICs with an RST=
 pin?) and
> >> 'reset-gpios' are different. Same applies to 'pdwn-gpios' vs. 'powerdo=
wn-gpios'.
> >
> > I see all your points and I agree with most of them. Anyway, if the
> > chip manual describes a pin as 'RST' I would not find it confusing to
> > have a 'rst-gpio' defined in bindings :)
> >
> > Let me be a bit pesky here: what if a chip defines a reset GPIO, which
> > is definitely a reset, but names it, say "XYZ" ? Would you prefer to
> > see it defined as "reset-gpios" for consistency with other bindings,
> > or "xyz-gpios" for consistency with documentation?
>
> If a pin is definitely an IC reset as you said, then my preference is to =
see
> it described under 'reset-gpios' property name, plus a comment in the IC
> device tree documentation document about it. I can provide two reasons to
> advocate my position:
>
> 1) developers spend significantly more time reading and editing the actual
>    DTSI/DTS board files rather than reading and editing documentation,
>    it makes sense to use common property names to save time and reduce
>    amount of "what does 'oe' stand for?" type of questions; I suppose
>    that the recommendation to avoid not "widely used" abbreviations in
>    device node and property names arises from the same reasoning,
>
> 2) "widely used" and "standard" properties are excellent candidates for
>    developing (or re-using) generalization wrappers, it happened so many
>    times in the past, and this process shall be supported in my opinion;
>    due to compatibility restrictions it might be problematic to change
>    property names, and every new exception to "widely used" properties
>    makes problematic to develop and maintain these kinds of wrappers, and
>    of course it postpones a desired "described in standard" recognition.
>
> If my point of view is accepted, I do admit that a developer who
> translates a board schematics to board DTS file may experience a minor
> discomfort, which is mitigated if relevant pin names are found in device
> tree binding documentation in comments to properties, still the overall
> gain is noticeably higher in my personal opinion.
>

Thank you for sharing your point of view. Makes much sense actually.
I will use semi-standard names in v7 bindings.

Thanks
   j

> --
> With best wishes,
> Vladimir

--eGLW8NzjjVmDHwQh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJavLmwAAoJEHI0Bo8WoVY8JcQP/RDBB/chrOmMWIozh/whA2Do
WbSY6dgi7v1dNU72dM/awLnMrW8I4vCzwNqj6ZPFctyNv+aq7osvKuaQzdWOoLpr
v6CGKlhBzAeGyh17hdy5b7ZBQLvvJIbMS7Djk1yFfAyqfd+1PkkHMhelefEycwEh
hRFfDS6kS6CXM8qs10zpbPXdSWe9nkJWH89bc1c5KzXhkTC6QWmzCicwdqD/uUYc
O30qg4Dgvnhp2/kpeGqkhIBe1VE5d1qhJ8PrGei+dwr4c5y/1a2VJ9UVb8UtAagE
8G1v1CwNyMM+3AHGily2+BZqxAKM7KOyFJ9h31GRu/cR4WDdthYt8iNgRtFJF7fy
EbWcm3RYeHbp1WiHs9lTiRN1ouV5OUTy3hia36JgQv7m2aiO/85NlH851ALTssjV
3cUfO7F49Sl9bTodnMdwJwGGfKq9gqQoP4j4m0Sl8+rdI8vyclqTgtwCM0sP/vKY
OdfmIzZ8++4o8McIup2qYSzr45I1njKsg9YeXasZ9IqeVJf4v9Ob1ZkNdblwenYk
8xFoCqFIKQfx8+GCUxS2FUiodUfjLdVGSKebrSQLV4G3p84XeF6WKr8X55g/Rqwm
R6xpY1K7buqe16Oy+SnTxJNeOD+ZKo3OgPavVejPVZkJ/vl8t1X/EY7o+g0CEEre
zCsjPFU6fhoWrDOYqJcN
=S8Vi
-----END PGP SIGNATURE-----

--eGLW8NzjjVmDHwQh--
