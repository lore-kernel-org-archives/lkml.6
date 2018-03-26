Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AG47ELszgIsI8dzAHEKJoW6x0CYT5oks1XHm9ldCQt99wbMos1JKuEhCpbFySCYwnwJfgVI4zctH
ARC-Seal: i=1; a=rsa-sha256; t=1522063224; cv=none;
        d=google.com; s=arc-20160816;
        b=H/TZ7TTbPKTwGY6lecyLQ73hzhjKomfR9yrNL3+6FydGpGapxY/OsQzLsahLOoz915
         Uvsb14kGHkmDz5+zlcfJRXC9lfyEmTOn7uNcUjsK34cTWYGp6v+dsUs4azAjrYu8kxge
         W75i4qVDfIos3djbJ5KQ03oKMf60Yk+Kbtq9hfAVFSsO+/k4bI/low+Lh0xkJJhXtY+Q
         qnGDIYeTzs2tvD8Y4PJuSWnVGqW8uyUDMqL2kdAhSPlSszfJBZOEslYcwtVPZzKMHf8A
         Au+WTOl7ottah0JLXJiXdwSPbfRstz6ztjPemmEmfvQ9DpWmTSRdYBt8qNCcAqz3synd
         mVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=/43E4sLx6vf16HlGtDZVPKs4Wq+hU5TvADqeZVLA8CY=;
        b=bP85duxrDP3Q6szhp3H5I1rI8sJeahQyctfc5Z7nXcXz59SVSVafXf4s/TAeo/or+b
         5Wdt5v1GfbmONJmEkKzEpR18SCIA8tXLmMEHmQugvU26IkT16MOMWoEveyYOpFi3WA5Y
         mVWnqXkh7Xq8nulb7E+GjXZF3BDyYTHSMBXSpwv8ywvCwUPbZ7KfId2shjvickLhH9jY
         A//rypJCJPP8MGzfsD4pdq3g80azzUtDeS/XjS08OtYMpUIfne/3Q2T1HCzRTCvUVktT
         pReITbwbkVZZAhE2h5Xsbv/x/THe3ltMcMKGS1KjwDlosaq0VackDy73fKguPGrpswjV
         ErCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Mon, 26 Mar 2018 13:19:46 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec
 <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta
 <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja
 Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka
 <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal
 Ciepiela <rafalc@cadence.com>, Thomas Petazzoni
 <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob
 Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland
 <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Vitor Soares <Vitor.Soares@synopsys.com>,
 Linus Walleij <linus.walleij@linaro.org>, Xiang Lin
 <Xiang.Lin@synaptics.com>, "open list:GPIO SUBSYSTEM"
 <linux-gpio@vger.kernel.org>, Boris Brezillon
 <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 05/11] dt-bindings: i3c: Document core bindings
Message-ID: <20180326131946.5513c6e2@bbrezillon>
In-Reply-To: <CAMuHMdV9xW8o6zuOmOxB+=h1XTdi-VFq2mp897SUjZKtRMOWOw@mail.gmail.com>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
	<20180323110020.19080-6-boris.brezillon@bootlin.com>
	<CAMuHMdV9xW8o6zuOmOxB+=h1XTdi-VFq2mp897SUjZKtRMOWOw@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725932611927845?=
X-GMAIL-MSGID: =?utf-8?q?1595998967166438561?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Geert,

On Mon, 26 Mar 2018 12:22:24 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Boris,
> 
> On Fri, Mar 23, 2018 at 12:00 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > From: Boris Brezillon <boris.brezillon@free-electrons.com>
> >
> > A new I3C subsystem has been added and a generic description has been
> > created to represent the I3C bus and the devices connected on it.
> >
> > Document this generic representation.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>  
> 
> Thanks for your patch!
> 
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i3c/i3c.txt
> > @@ -0,0 +1,140 @@  
> 
> > +I3C devices
> > +===========
> > +
> > +All I3C devices are supposed to support DAA (Dynamic Address Assignment), and
> > +are thus discoverable. So, by default, I3C devices do not have to be described
> > +in the device tree.  
> 
> But if they're described, they should have a compatible value, no?

What's the point of having a compatible here? I mean, I3C devices are
already attached to the relevant drivers using the Provisional ID, why
would we need a compatible if we don't parse it?

> 
> > +This being said, one might want to attach extra resources to these devices,
> > +and those resources may have to be described in the device tree, which in turn
> > +means we have to describe I3C devices.
> > +
> > +Another use case for describing an I3C device in the device tree is when this
> > +I3C device has a static address and we want to assign it a specific dynamic
> > +address before the DAA takes place (so that other devices on the bus can't
> > +take this dynamic address).
> > +
> > +The I3C device should be names <device-type>@<static-address>,<i3c-pid>,  
> 
> named

Oops. Will fix the typo.

> 
> So the i3c-pid in the unit address is represented as a 64-bit number, not as two
> comma-separated 32-bit numbers?

Right. I've changed my mind so many times that I ended up mixing the 2
representations I have considered.

Here are the choices we have:

1/ expose the raw ProvisionalID which is a 48-bit integer formed by the
   concatenation of the vendor ID, part ID and instance ID:
   ProvisionalID = VendorID << 33 | PartID << 16 | InstanceID << 12 |
		   ExtraInfo
   The I3C dev node name should in this case be something like
   <device-type>@<static-address>,<i3c-pid>

2/ split the fields we are really interested in in different cells:
   2nd cell: vendorID
   3rd cell: partID
   4th cell: instanceID
   In this case, the node name should be
   <device-type>@<static-address>,<i3c-vendor>,<i3c-partid>,<i3c-instanceid>

Note that we can still change for the second representation if Rob is
okay.

> 
> > +Example:
> > +
> > +       i3c-master@d040000 {
> > +               compatible = "cdns,i3c-master";
> > +               clocks = <&coreclock>, <&i3csysclock>;
> > +               clock-names = "pclk", "sysclk";
> > +               interrupts = <3 0>;
> > +               reg = <0x0d040000 0x1000>;
> > +               #address-cells = <3>;
> > +               #size-cells = <0>;
> > +
> > +               status = "okay";
> > +               i2c-scl-frequency = <100000>;
> > +
> > +               /* I2C device. */
> > +               nunchuk: nunchuk@52 {  
> 
> @52,8000001000000000?

Well, I2C devs is a special case, and I'm not sure we want to add the
extra LVR information + the IS_I2C_DEV bit in the node name.

> 
> > +                       compatible = "nintendo,nunchuk";
> > +                       reg = <0x52 0x80000010 0x0>;

One more detail: people are unlikely to define reg using raw values: I
provide macros to do that in patch 6.

> > +               };
> > +
> > +               /* I3C device with a static address. */
> > +               thermal_sensor: sensor@68,39200144004 {  
> 
> No compatible value?

No, as said above, it's not needed.

> 
> > +                       reg = <0x68 0x392 0x144004>;
> > +                       assigned-address = <0xa>;
> > +               };
> > +
> > +               /*
> > +                * I3C device without a static address but requiring resources
> > +                * described in the DT.
> > +                */
> > +               sensor@0,39200154004 {  
> 
> No compatible value?

Ditto.

Thanks for your review.

Boris

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
