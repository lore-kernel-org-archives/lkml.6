Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeC0Gwg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 02:52:36 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:34406 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbeC0Gwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 02:52:34 -0400
X-AuditID: 0a3aad12-eddff70000016568-4f-5ab9ea2f0f9a
From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
To: Rob Herring <robh@kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hs@denx.de" <hs@denx.de>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>,
        "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: Re: [PATCH] Input: add bu21029 touch driver
Thread-Topic: [PATCH] Input: add bu21029 touch driver
Thread-Index: AdPFmBvcuWcHIO+GQ4GRxNEfUInxQQ==
Date: Tue, 27 Mar 2018 06:52:31 +0000
Message-ID: <bf2aff8ab685473c836012bbed96c693@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.142.147]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA22Tf0wbZRjHeXvt9SgcHu06HruhaXUuc/JzxTTDKFFZamKi/yzGJmYrctIG
        2mKvkMFmXHBjP8S5DTHQYQWBJiIGbMYojI3RYbbOKEHY1prRkQgIRbShWB1D6h0Ha//wn8vz
        fr/P53me97k7ApNeIhSE0WyjrWZ9mQqXCCV7v03PyAr267KvX8nRfDnyk0hz/as5pHHfu49p
        /EsRkWZ8oBnXdNwdE2iig25xgVjb5ehCWof9plDbb58Ua12dp3Bt2PXEmyKd5IViusxYSVuz
        XjwoMbR2zGPlH1GHbgw78KNoMek0SiSAUsPSnQh+GkkIKdUoAE93RMgfBhHMRIfF/GERQXC0
        fsO5hsDvmMA5Hqf2wgnnD2Iu3kIp4WHt5yIuCaMuYHDMeVXAGTK2yXGfHeeT8qDuWp2IjzPh
        4tQX67CQ2gHH7QPr+SSVD45AaF1HVDr09IxiXIxRaeCa/VvED05B+yCvAyWH+V/XWJ1gYyU0
        N77Mp2eCr+EznI93g7N1AePLp4K3aVp4FsntcVXtcYg9DrHHIS1I2InkjDG70qR+Xp2baS2i
        mersnMx3LSYX4t+e1I0+7ijyIIpAqmQyabpfJxXpK5kqkwflEQKVnKx+kpVSiizFVQY9Yzhg
        rSijGZWCRAkJCVLZI5mpKDIZGcZoMXsQEJhqC1nawXJksb6qmrZaeMyDthFCVRpZV3xEJ6VK
        9Da6lKbLaeumm08QKiBDcyyYaqVL6EPvGctsm7Yqne+5Nd6JbysgEj1oD5HM9n59nuvNlOtN
        jLFkA3+cx6Wbagy9hd4g1hqnajEicoV7+uYWajGp0Gwx04o0MomrRXGUocL8aBrFdnL3XdaQ
        xxmxikHkQ+w+ZWQvd5dk9oeJzQGkW9b8tjR1Q4xBue0sQ9UQ4KixwpB/HEH32iIGv/zTI4Km
        lhAOt6e+T4TVsFMC9vFIMgxdOJ8CK00Nj8Gx35Yo+N1rl8LPS6syaGwbAgi3zisgWvO1Euq/
        G1dC+BPHDmifDDwDvtngTjjfFtoJE55PM2D5rxsZ0NM3zX5Is51ZsHw5rIYzgRkNPJiZyofl
        U9GXYKR78lW4POUvhFBgoTDI7ljA7vhSjZvbsU1v+58db6ixyymOoiPZF/NWugrnxu6fNURL
        /Z4E3bkm4z3H06PoOddK7i3DH92LZ1qCwadIWcHB6Or+h72H04hXDhR4b97WnXTtMgoN+wa0
        20jFh7L338oY2N7bNqztSxrxqsujr+2Z2OU9t3LY2TCmSQl8885JdfoHV7f+u5/JOzFb31f7
        p+rH0J1R5QOVkDHoc57FrIz+P0B+XGHJBAAA
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2R6qhch009605

Hello Rob,

> > +* Rohm BU21029 Touch Screen Controller
> > +
> > +Required properties:
> > + - compatible              : must be "rohm,bu21029"
> > + - reg                     : i2c device address of the chip
> 
> What the valid value(s)?

The chip itself can be wired to 0x40 or 0x41. The driver can work with
any valid I2C address.

Is this what you are looking for?

- reg                     : i2c device address of the chip (0x40 or 0x41)

> > + - interrupt-parent        : the phandle for the gpio controller
> > + - interrupts              : (gpio) interrupt to which the chip is connected
> > + - reset-gpios             : gpio pin to reset the chip
> 
> Active high or low?

The chip itself needs an active low reset. But depending on whether
there is an inverter between the touch screen controller and the CPU or
not, the CPU's GPIO might need to be active high or active low. This
shall be configured by the polarity given in the device tree. The
driver uses this information to drive the reset appropriately.

Are you looking for documenting the required polarity of the touch
controller itself?

- reset-gpios             : gpio pin to reset the chip (active low)

> > +Example:
> > +
> > +	&i2c1 {
> > +		/* ... */
> > +
> > +		bu21029: bu21029@40 {
> > +			compatible = "rohm,bu21029";
> > +			reg = <0x40>;
> > +			interrupt-parent = <&gpio1>;
> > +			interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
> > +			reset-gpios = <&gpio6 16 GPIO_ACTIVE_LOW>;
> > +			rohm,x-plate-ohms = <600>;
> > +			touchscreen-max-pressure = <4095>;
> > +		};
> > +
> > +		/* ... */
> > +	};

Greetings,
Mark Jonas

Building Technologies, Panel Software Fire (BT-FIR/ENG1) 
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY | www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118 
Aufsichtsratsvorsitzender: Stefan Hartung; Geschäftsführung: Gert van Iperen, Andreas Bartz, Thomas Quante, Bernhard Schuster
