Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeC0KKO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 06:10:14 -0400
Received: from relay0.mail.gandi.net ([217.70.178.220]:53109 "EHLO
        relay0-d.mail.gandi.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751859AbeC0KKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 06:10:13 -0400
X-Originating-IP: 2.224.242.101
Date: Tue, 27 Mar 2018 12:10:08 +0200
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
Message-ID: <20180327101008.GM27746@w540>
References: <4060923.7DxT9ae38L@avalon>
 <20180326222249.tvjiutyd4amlibpa@rob-hp-laptop>
 <CGME20180327061536epcas5p40faf6caf0d9825e6c33cd3e6ba9d8378@epcas5p4.samsung.com>
 <a1b0e678-38b8-dd29-b441-e2a09b565105@mentor.com>
 <1dd27170-153c-90f6-e13f-949ba7d0d4a9@samsung.com>
 <20180327073332.GI27746@w540>
 <70826dc1-d9ea-dc98-f591-c80f1904806a@cogentembedded.com>
 <b7d0e35e-3077-feba-dded-9b8f8422367b@mentor.com>
 <20180327085748.GK27746@w540>
 <871a3805-b20c-3f48-406c-145461837388@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline
In-Reply-To: <871a3805-b20c-3f48-406c-145461837388@mentor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

On Tue, Mar 27, 2018 at 12:37:31PM +0300, Vladimir Zapolskiy wrote:
> Hi Jacopo,
>
> On 03/27/2018 11:57 AM, jacopo mondi wrote:
> > Hi Vladimir,
> >
> > On Tue, Mar 27, 2018 at 11:30:29AM +0300, Vladimir Zapolskiy wrote:
> >> Hi Sergei,
> >>
> >> On 03/27/2018 11:27 AM, Sergei Shtylyov wrote:
> >>> Hello!
> >>>
> >>> On 3/27/2018 10:33 AM, jacopo mondi wrote:
> >>> [...]
> >>>>>>>>> Document Thine THC63LVD1024 LVDS decoder device tree bindings.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >>>>>>>>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> >>>>>>>>> Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ra=
gnatech.se>
> >>>>>>>>> ---
> >>>>>>>>>   .../bindings/display/bridge/thine,thc63lvd1024.txt | 66 +++++=
++++++++++++++
> >>>>>>>>>   1 file changed, 66 insertions(+)
> >>>>>>>>>   create mode 100644
> >>>>>>>>> Documentation/devicetree/bindings/display/bridge/thine,thc63lvd=
1024.txt
> >>>>>>>>>
> >>>>>>>>> diff --git
> >>>>>>>>> a/Documentation/devicetree/bindings/display/bridge/thine,thc63l=
vd1024.txt
> >>>>>>>>> b/Documentation/devicetree/bindings/display/bridge/thine,thc63l=
vd1024.txt
> >>>>>>>>> new file mode 100644
> >>>>>>>>> index 0000000..8225c6a
> >>>>>>>>> --- /dev/null
> >>>>>>>>> +++
> >>>>>>>>> b/Documentation/devicetree/bindings/display/bridge/thine,thc63l=
vd1024.txt
> >>>>>>>>> @@ -0,0 +1,66 @@
> >>>>>>>>> +Thine Electronics THC63LVD1024 LVDS decoder
> >>>>>>>>> +-------------------------------------------
> >>>>>>>>> +
> >>>>>>>>> +The THC63LVD1024 is a dual link LVDS receiver designed to conv=
ert LVDS
> >>>>>>>>> streams
> >>>>>>>>> +to parallel data outputs. The chip supports single/dual input/=
output modes,
> >>>>>>>>> +handling up to two two input LVDS stream and up to two digital=
 CMOS/TTL
> >>>>>>>>> outputs.
> >>>>>>>>> +
> >>>>>>>>> +Single or dual operation modes, output data mapping and DDR ou=
tput modes
> >>>>>>>>> are
> >>>>>>>>> +configured through input signals and the chip does not expose =
any control
> >>>>>>>>> bus.
> >>>>>>>>> +
> >>>>>>>>> +Required properties:
> >>>>>>>>> +- compatible: Shall be "thine,thc63lvd1024"
> >>>>>>>>> +
> >>>>>>>>> +Optional properties:
> >>>>>>>>> +- vcc-supply: Power supply for TTL output and digital circuitry
> >>>>>>>>> +- cvcc-supply: Power supply for TTL CLOCKOUT signal
> >>>>>>>>> +- lvcc-supply: Power supply for LVDS inputs
> >>>>>>>>> +- pvcc-supply: Power supply for PLL circuitry
> >>>>>>>> As explained in a comment to one of the previous versions of thi=
s series, I'm
> >>>>>>>> tempted to make vcc-supply mandatory and drop the three other po=
wer supplies
> >>>>>>>> for now, as I believe there's very little chance they will be co=
nnected to
> >>>>>>>> separately controllable regulators (all supplies use the same vo=
ltage). In the
> >>>>>>>> very unlikely event that this occurs in design we need to suppor=
t in the
> >>>>>>>> future, the cvcc, lvcc and pvcc supplies can be added later as o=
ptional
> >>>>>>>> without breaking backward compatibility.
> >>>>>>> I'm okay with that.
> >>>>>>>
> >>>>>>>> Apart from that,
> >>>>>>>>
> >>>>>>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>>>>>>
> >>>>>>>>> +- pdwn-gpios: Power down GPIO signal. Active low
> >>>>>>> powerdown-gpios is the semi-standard name.
> >>>>>>>
> >>>>>> right, I've also noticed it. If possible please avoid shortenings =
in
> >>>>>> property names.
> >>>>>
> >>>>> It is not shortening, it just follow pin name from decoder's datash=
eet.
> >>>>>
> >>>>>>
> >>>>>>>>> +- oe-gpios: Output enable GPIO signal. Active high
> >>>>>>>>> +
> >>>>>> And this one is also a not ever met property name, please consider=
 to
> >>>>>> rename it to 'enable-gpios', for instance display panels define it.
> >>>>>
> >>>>>
> >>>>> Again, it follows datasheet naming scheme. Has something changed in=
 DT
> >>>>> conventions?
> >>>>
> >>>> Seconded. My understanding is that the property name should reflect
> >>>> what reported in the the chip manual. For THC63LVD1024 the enable and
> >>>> power down pins are named 'OE' and 'PDWN' respectively.
> >>>
> >>>     But don't we need the vendor prefix in the prop names then, like
> >>> "renesas,oe-gpios" then?
> >>>
> >>
> >> Seconded, with a correction to "thine,oe-gpios".
> >>
> >
> > mmm, okay then...
> >
> > A grep for that semi-standard properties names in Documentation/
> > returns only usage examples and no actual definitions, so I assume this
> > is why they are semi-standard.
>
> Here we have to be specific about a particular property, let it be 'oe-gp=
ios'
> vs. 'enable-gpios' and let's collect some statistics:
>
> % grep -Hr oe-gpios Documentation/devicetree/bindings/* | wc -l
> 0
>
> $ grep -Hr enable-gpios Documentation/devicetree/bindings/* | wc -l
> 86
>
> While 'thine,oe-gpios' would be correct, I see no reason to introduce a v=
endor
> specific property to define a pin with a common and well understood purpo=
se.
>
> If you go forward with the vendor specific prefix, apparently you can set=
 the name
> to 'thine,oe-gpio' (single) or even to 'thine,oe', or does the datasheet =
names
> the pin as "OE GPIO" or "OE connected to a GPIO"? I guess no.
>

Let me clarify I don't want to push for a vendor specific name or
similar, I'm fine with using 'semi-standard' names, I'm just confused
by the 'semi-standard' definition. I guess from your examples, the
usage count makes a difference here.

> Standards do not define '-gpios' suffix, but partially the description is=
 found
> in Documentation/bindings/gpio/gpio.txt, still it is not a section in any
> standard as far as I know.

>
> > Seems like there is some tribal knowledge involved in defining what
> > is semi-standard and what's not, or are those properties documented som=
ewhere?
> >
>
> The point is that there is no formal standard which describes every IP,
> every IC and every single their property, some device node names and prop=
erty
> names are recommended in ePAPR and Devicetree Specification though.
>
> Think of a confusion if 'rst-gpios' (have you seen any ICs with an RST pi=
n?) and
> 'reset-gpios' are different. Same applies to 'pdwn-gpios' vs. 'powerdown-=
gpios'.

I see all your points and I agree with most of them. Anyway, if the
chip manual describes a pin as 'RST' I would not find it confusing to
have a 'rst-gpio' defined in bindings :)

Let me be a bit pesky here: what if a chip defines a reset GPIO, which
is definitely a reset, but names it, say "XYZ" ? Would you prefer to
see it defined as "reset-gpios" for consistency with other bindings,
or "xyz-gpios" for consistency with documentation?

Thanks
   j
>
> >> If vendor agnostic properties are supposed to be used, then please fol=
low
> >> the referenced by Rob semi-standard notations.
>
> --
> With best wishes,
> Vladimir

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJauhiAAAoJEHI0Bo8WoVY86+8QAL0/Vfrk1XKEhgJF77qfiW1A
Th9XqKh0hooywgaL2x7a0edahAj/AGE5carW2xMYvP6MEgQ/DCRTBH6QkJkHYO0U
3/XlZnwzyYbybOvn6zVdxyfPnjJDMR5+ALYvTSfIvjFa4xYCd4cZS5Ewdgpro33W
z3eg8Cd+ASBsp6rxYMj7ee+305rG3H7uYafEMq/C8kIunrBra+zqvpLt8nSfrcNc
XdMRsm65bGvEfqotyaKRVuS1b/IRqm/PJR2nlHDfwku0NtnFl4Hhn8rbjDvhKVGX
M2Gi/bBE18JxdLGdCPrie4UKzio9b6GrbNpHCELYtJgCqwPHv4NQAg5mwfWgldGv
VJ5l1zigC/h+nwaHDHUiIz+j5Ip7R1/0DLOc727s3Dt1hHsFAVUBmP7Tmh4FDy8x
oKpsWy8qAZYl5njL9YxEgCSaBidumhGUy+Bm1ygJV6CJVltCmy/AnE7fP3vY9Gnd
hthiEJIdhoXbm4FOccZ3FkJHvJyRrfrymjA5S1i465/fOc4fS9XYZWUrPGNhlTxu
ABPwf6qwCUmKaWqfhG8TqFC1+ShKXsLlBIwhdfjU1NZkJpxlYjIMLor7NKA5+Odb
ExNHqMwnB+37H4DSd4XOlZblEH341eD1vSJ2pXiLoE5FWCgGngCIVOIXl+bUqVbo
0/3w8sy53G+mT2iBV23W
=Ftfk
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
