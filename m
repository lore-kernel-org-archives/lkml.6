Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeDEQd6 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:33:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751251AbeDEQd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:33:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F8621834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AIpwx4+kGfPsCu373+aZ0bT16HER8bI7jieyWvwBhJQwNyxS525tMc0YVMpYau2KJhGM4z2Pdb6f6Xv7CETY7NTLU6Y=
MIME-Version: 1.0
In-Reply-To: <4549018.sA3EWz2jVz@avalon>
References: <4060923.7DxT9ae38L@avalon> <20180327101008.GM27746@w540>
 <6353eb46-5a2d-7b75-a60b-c31c59c8636a@mentor.com> <4549018.sA3EWz2jVz@avalon>
From: Rob Herring <robh@kernel.org>
Date: Thu, 5 Apr 2018 11:33:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJUMGo3mxa_Wh=y59TkBzjPyE0CtNuSGV79kZx1XDyaJQ@mail.gmail.com>
Message-ID: <CAL_JsqJUMGo3mxa_Wh=y59TkBzjPyE0CtNuSGV79kZx1XDyaJQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: display: bridge: Document
 THC63LVD1024 LVDS decoder
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        jacopo mondi <jacopo@jmondi.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Archit Taneja <architt@codeaurora.org>,
        David Airlie <airlied@linux.ie>, Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP"
        <linux-renesas-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 2, 2018 at 8:36 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Vladimir,
>
> On Tuesday, 27 March 2018 14:03:25 EEST Vladimir Zapolskiy wrote:
>> On 03/27/2018 01:10 PM, jacopo mondi wrote:
>> > On Tue, Mar 27, 2018 at 12:37:31PM +0300, Vladimir Zapolskiy wrote:
>> >> On 03/27/2018 11:57 AM, jacopo mondi wrote:
>> >>> On Tue, Mar 27, 2018 at 11:30:29AM +0300, Vladimir Zapolskiy wrote:
>> >>>> On 03/27/2018 11:27 AM, Sergei Shtylyov wrote:
>> >>>>> On 3/27/2018 10:33 AM, jacopo mondi wrote:
>> >>>>> [...]
>> >>>>>
>> >>>>>>>>>>> Document Thine THC63LVD1024 LVDS decoder device tree bindings.
>> >>>>>>>>>>>
>> >>>>>>>>>>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>> >>>>>>>>>>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>> >>>>>>>>>>> Reviewed-by: Niklas Söderlund
>> >>>>>>>>>>> <niklas.soderlund+renesas@ragnatech.se>
>> >>>>>>>>>>> ---
>> >>>>>>>>>>>
>> >>>>>>>>>>>   .../bindings/display/bridge/thine,thc63lvd1024.txt | 66
>> >>>>>>>>>>>   +++++++++++++++++++
>> >>>>>>>>>>>   1 file changed, 66 insertions(+)
>> >>>>>>>>>>>   create mode 100644
>> >>>>>>>>>>>
>> >>>>>>>>>>> Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1
>> >>>>>>>>>>> 024.txt
>> >>>>>>>>>>>
>> >>>>>>>>>>> diff --git
>> >>>>>>>>>>> a/Documentation/devicetree/bindings/display/bridge/thine,thc63lv
>> >>>>>>>>>>> d1024.txt
>> >>>>>>>>>>> b/Documentation/devicetree/bindings/display/bridge/thine,thc63lv
>> >>>>>>>>>>> d1024.txt
>> >>>>>>>>>>> new file mode 100644
>> >>>>>>>>>>> index 0000000..8225c6a
>> >>>>>>>>>>> --- /dev/null
>> >>>>>>>>>>> +++
>> >>>>>>>>>>> b/Documentation/devicetree/bindings/display/bridge/thine,thc63lv
>> >>>>>>>>>>> d1024.txt
>> >>>>>>>>>>> @@ -0,0 +1,66 @@
>> >>>>>>>>>>> +Thine Electronics THC63LVD1024 LVDS decoder
>> >>>>>>>>>>> +-------------------------------------------
>> >>>>>>>>>>> +
>> >>>>>>>>>>> +The THC63LVD1024 is a dual link LVDS receiver designed to
>> >>>>>>>>>>> convert LVDS streams
>> >>>>>>>>>>> +to parallel data outputs. The chip supports single/dual
>> >>>>>>>>>>> input/output modes, +handling up to two two input LVDS stream
>> >>>>>>>>>>> and up to two digital CMOS/TTL outputs.
>> >>>>>>>>>>> +
>> >>>>>>>>>>> +Single or dual operation modes, output data mapping and DDR
>> >>>>>>>>>>> output modes are
>> >>>>>>>>>>> +configured through input signals and the chip does not expose
>> >>>>>>>>>>> any control bus.
>> >>>>>>>>>>> +
>> >>>>>>>>>>> +Required properties:
>> >>>>>>>>>>> +- compatible: Shall be "thine,thc63lvd1024"
>> >>>>>>>>>>> +
>> >>>>>>>>>>> +Optional properties:
>> >>>>>>>>>>> +- vcc-supply: Power supply for TTL output and digital circuitry
>> >>>>>>>>>>> +- cvcc-supply: Power supply for TTL CLOCKOUT signal
>> >>>>>>>>>>> +- lvcc-supply: Power supply for LVDS inputs
>> >>>>>>>>>>> +- pvcc-supply: Power supply for PLL circuitry
>> >>>>>>>>>>
>> >>>>>>>>>> As explained in a comment to one of the previous versions of this
>> >>>>>>>>>> series, I'm tempted to make vcc-supply mandatory and drop the
>> >>>>>>>>>> three other power supplies for now, as I believe there's very
>> >>>>>>>>>> little chance they will be connected to separately controllable
>> >>>>>>>>>> regulators (all supplies use the same voltage). In the very
>> >>>>>>>>>> unlikely event that this occurs in design we need to support in
>> >>>>>>>>>> the future, the cvcc, lvcc and pvcc supplies can be added later
>> >>>>>>>>>> as optional without breaking backward compatibility.
>> >>>>>>>>>
>> >>>>>>>>> I'm okay with that.
>> >>>>>>>>>
>> >>>>>>>>>> Apart from that,
>> >>>>>>>>>>
>> >>>>>>>>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> >>>>>>>>>>
>> >>>>>>>>>>> +- pdwn-gpios: Power down GPIO signal. Active low
>> >>>>>>>>>
>> >>>>>>>>> powerdown-gpios is the semi-standard name.
>> >>>>>>>>
>> >>>>>>>> right, I've also noticed it. If possible please avoid shortenings
>> >>>>>>>> in property names.
>> >>>>>>>
>> >>>>>>> It is not shortening, it just follow pin name from decoder's
>> >>>>>>> datasheet.
>> >>>>>>>
>> >>>>>>>>>>> +- oe-gpios: Output enable GPIO signal. Active high
>> >>>>>>>>>>> +
>> >>>>>>>>
>> >>>>>>>> And this one is also a not ever met property name, please consider
>> >>>>>>>> to rename it to 'enable-gpios', for instance display panels define
>> >>>>>>>> it.
>> >>>>>>>
>> >>>>>>> Again, it follows datasheet naming scheme. Has something changed in
>> >>>>>>> DT conventions?
>> >>>>>>
>> >>>>>> Seconded. My understanding is that the property name should reflect
>> >>>>>> what reported in the the chip manual. For THC63LVD1024 the enable and
>> >>>>>> power down pins are named 'OE' and 'PDWN' respectively.
>> >>>>>>
>> >>>>> But don't we need the vendor prefix in the prop names then, like
>> >>>>> "renesas,oe-gpios" then?
>> >>>>
>> >>>> Seconded, with a correction to "thine,oe-gpios".
>> >>>
>> >>> mmm, okay then...
>> >>>
>> >>> A grep for that semi-standard properties names in Documentation/
>> >>> returns only usage examples and no actual definitions, so I assume this
>> >>> is why they are semi-standard.
>> >>
>> >> Here we have to be specific about a particular property, let it be
>> >> 'oe-gpios' vs. 'enable-gpios' and let's collect some statistics:
>> >>
>> >> % grep -Hr oe-gpios Documentation/devicetree/bindings/* | wc -l
>> >> 0
>> >>
>> >> $ grep -Hr enable-gpios Documentation/devicetree/bindings/* | wc -l
>> >> 86
>> >>
>> >> While 'thine,oe-gpios' would be correct, I see no reason to introduce a
>> >> vendor specific property to define a pin with a common and well
>> >> understood purpose.
>> >>
>> >> If you go forward with the vendor specific prefix, apparently you can set
>> >> the name to 'thine,oe-gpio' (single) or even to 'thine,oe', or does the
>> >> datasheet names the pin as "OE GPIO" or "OE connected to a GPIO"? I
>> >> guess no.
>> >
>> > Let me clarify I don't want to push for a vendor specific name or
>> > similar, I'm fine with using 'semi-standard' names, I'm just confused
>> > by the 'semi-standard' definition. I guess from your examples, the
>> > usage count makes a difference here.
>>
>> yes, in gneneral you can read "semi-standard" as "widely used", thus
>> collecting statistics is a good enough method to make a reasoning.
>>
>> Hopefully the next evolutionary step of "widely used" is "described in
>> standard".
>>
>> >> Standards do not define '-gpios' suffix, but partially the description is
>> >> found in Documentation/bindings/gpio/gpio.txt, still it is not a section
>> >> in any standard as far as I know.
>> >>
>> >>> Seems like there is some tribal knowledge involved in defining what
>> >>> is semi-standard and what's not, or are those properties documented
>> >>> somewhere?
>> >>
>> >> The point is that there is no formal standard which describes every IP,
>> >> every IC and every single their property, some device node names and
>> >> property names are recommended in ePAPR and Devicetree Specification
>> >> though.
>> >>
>> >> Think of a confusion if 'rst-gpios' (have you seen any ICs with an RST
>> >> pin?) and 'reset-gpios' are different. Same applies to 'pdwn-gpios' vs.
>> >> 'powerdown-gpios'.
>> >
>> > I see all your points and I agree with most of them. Anyway, if the
>> > chip manual describes a pin as 'RST' I would not find it confusing to
>> > have a 'rst-gpio' defined in bindings :)
>> >
>> > Let me be a bit pesky here: what if a chip defines a reset GPIO, which
>> > is definitely a reset, but names it, say "XYZ" ? Would you prefer to
>> > see it defined as "reset-gpios" for consistency with other bindings,
>> > or "xyz-gpios" for consistency with documentation?
>>
>> If a pin is definitely an IC reset as you said, then my preference is to see
>> it described under 'reset-gpios' property name, plus a comment in the IC
>> device tree documentation document about it. I can provide two reasons to
>> advocate my position:
>>
>> 1) developers spend significantly more time reading and editing the actual
>>    DTSI/DTS board files rather than reading and editing documentation,
>>    it makes sense to use common property names to save time and reduce
>>    amount of "what does 'oe' stand for?" type of questions; I suppose
>>    that the recommendation to avoid not "widely used" abbreviations in
>>    device node and property names arises from the same reasoning,
>>
>> 2) "widely used" and "standard" properties are excellent candidates for
>>    developing (or re-using) generalization wrappers, it happened so many
>>    times in the past, and this process shall be supported in my opinion;
>>    due to compatibility restrictions it might be problematic to change
>>    property names, and every new exception to "widely used" properties
>>    makes problematic to develop and maintain these kinds of wrappers, and
>>    of course it postpones a desired "described in standard" recognition.
>>
>> If my point of view is accepted, I do admit that a developer who
>> translates a board schematics to board DTS file may experience a minor
>> discomfort, which is mitigated if relevant pin names are found in device
>> tree binding documentation in comments to properties, still the overall
>> gain is noticeably higher in my personal opinion.
>
> I have to disagree with this. When using a property name that doesn't
> correspond to the hardware documentation, developers will need to refer to the
> DT bindings documentation to confirm the property name. "Widely used" property
> names will not save time, they will use more time. This is of course marginal
> and I don't think it would have any noticeable impact, but I don't think your
> argument holds.

We can have it both ways. The name should follow the documented
name/function. For example, we have enable-gpios which is simply the
invert of powerdown-gpios (for software's purposes). Pick the one
closest to the documentation. We're not trying to make bindings use
"enable" if a signal is called "powerdown".

What we don't want is gratuitous variation in the names based on the
whims of hw designers:

resetb-gpios
resetn-gpios
rst-gpios
rstn-gpios
nRESET-gpios

...you get the idea (and I left out vendor prefixes).

> I'm all for standardizing properties across DT bindings for multiple
> components, but doing so in a semi-random fashion will in my opinion not
> result in any gain. We can decide that power-down or output-enable GPIOS
> should have common property names (and I'm not even sure that would be useful,
> but we can certainly discuss it), but in that case someone should make a
> proposal and get the names standardized. Unless we do so, no matter what
> property name gets picked for a particular binding, it won't become
> universally used by magic.

For "output enable", I suspect that is a common signal/function and
should have a standardized name. Generally, the way this works is we
get several variations and then we try to standardize things. I think
we can all agree standardizing first is better. If you want to put it
in a common place, please do. Maybe people will read that. Regardless,
the only way to enforce following standard names is with review.

Debating "oe" vs. "output-enable" is bikeshedding IMO. Anyone familiar
with h/w design should recognize OE.

The reason to try and standardize names is so we can have common
drivers or library functions. In particular, for things like GPIOs
that need to be configured first for devices on otherwise discoverable
buses, this is very useful.

Rob
