Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031048AbeEXRqQ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:46:16 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:64418 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030941AbeEXRqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:46:02 -0400
X-AuditID: c0a8fbf4-fe7ff70000000f28-d5-5b06f6d1673e
From: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To: Mark Brown <broonie@kernel.org>
CC: "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
Subject: RE: [PATCH 4/9] regulator: bd71837: Devicetree bindings for BD71837
 regulators
Thread-Topic: [PATCH 4/9] regulator: bd71837: Devicetree bindings for
 BD71837 regulators
Thread-Index: AQHT82ez5186Arb5LUSGxLz4W0eXMqQ/HO9p
Date: Thu, 24 May 2018 17:30:57 +0000
Message-ID: <042F8805D2046347BB8420BEAE397A4016C06B47@WILL-MAIL002.REu.RohmEu.com>
References: <20180524055752.GE4249@localhost.localdomain>,<20180524140118.GS4828@sirena.org.uk>
In-Reply-To: <20180524140118.GS4828@sirena.org.uk>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.216.252.121]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42I5sOL3Rt1L39iiDU73MllMffiEzWL+kXOs
        Fve/HmW0+Halg8niY889VovLu+awWSy9fpHJYs7SEywWF0+5WrTuPcJu8e/aRhYHbo8189Yw
        ery/0crusXPWXXaPTas62TzuXNvD5vF5k1wAWxS3TVJiSVlwZnqevl0Cd8adFQsYC7oFKrp+
        XGVvYGzm7WLk4JAQMJFY9sq+i5GLQ0jgGqPEv8Z5TBDOCUaJ/4cXsIEUsQnYSHTdZO9i5OQQ
        EVCWuPp9LwtIDbPALxaJLRtugSWEBSIlzvecZ4MoipJ4fPEsE4RtJPG+s4UZxGYRUJVYtPYf
        I8hMXoEgiVU9TiBhIYF4iQkd/YwgNidQ+cX7bWDljAKyEp0N78DGMAuIS9x6Mh/MlhAQkFiy
        5zwzhC0q8fLxP1YIW1lizamdbBD1OhILdn+CsrUlli18DVbPKyAocXLmE5YJjKKzkIydhaRl
        FpKWWUhaFjCyrGKUyE3MzElPLEk11CtKLdUrys/IBVLJ+bmbGCGx+mUH4/9DnocYBTgYlXh4
        276wRQuxJpYVV+YeYpTkYFIS5WV4BRTiS8pPqcxILM6ILyrNSS0+xCjBwawkwrsgCSjHm5JY
        WZValA+TkuZgURLnjTr/K0pIAGRzdmpqQWoRTFaGg0NJgvfSV6BGwaLU9NSKtMycEoQ0Ewcn
        yHAuKZHi1LyU1KLE0pKMeFCqiC8GJguQFA/Q3rUgZ/IWFyTmAkUhWk8xSkqJ83aBzBUASWSU
        5sGNfcUoDvSdMO91kCwPMFnDdb0CGsgENPDicmaQgSWJCCmpBsY+h98mhfHTjrw8MP34r2nX
        Lxy8wm16e/OuH/zaj5tUbz5vF7q3aJ5Femzggjkz+c/JBjln80/5tMT9ssqGBqMIo0lXUkxv
        RWe9Wbtpi9Yx7k69ws2vL0q1vd71OstB6Bb/G3lR0apMyWsuWsmCP+VXLxZVrkvaelJ36u/w
        B3MmMgvLdqdt7O9VYinOSDTUYi4qTgQAPuMmE5MDAAA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

First of all, thank you for taking your time to check the patches. I do
appreciate it. I find reading patches hard myself.

> From: Mark Brown [broonie@kernel.org]
> Sent: Thursday, May 24, 2018 5:01 PM
> 
> > On Thu, May 24, 2018 at 08:57:52AM +0300, Matti Vaittinen wrote:
>
> > +Required properties:
> > + - compatible: should be "rohm,bd71837-pmic".
> > + - regulator-name: should be "buck1", ..., "buck8" and "ldo1", ..., "ldo7"
>
> The MFD is for a single device, there should be no need for compatibles
> on subfunctions.

I will check this. I must admit I am not sure what is the de-facto mechanism
for assigning the correct device-tree nodes to sub devices if compatibles
are not used? I think I saw device-tree node name being used for regulators
but how is it done for example with clk? I would be grateful if anyone could
point me to right direction with this.

Also, another thing I was wondering is how supply regulators should be
handled? In this case the LDO5 is supplied by BUCK6 and LDO6 by
BUCK7. 

>From generic regulator bindings
/Documentation/devicetree/bindings/regulator/regulator.txt
I found statement:

> - <name>-supply: phandle to the parent supply/regulator node

and

> Regulator Consumers:
> Consumer nodes can reference one or more of its supplies/
> regulators using the below bindings.
>
> - <name>-supply: phandle to the regulator node
>
> These are the same bindings that a regulator in the above
> example used to reference its own supply, in which case
> ts just seen as a special case of a regulator being a
> consumer itself.

but I did not find handling for the supply properties from regulator core.
Thus I ended up hard coding the supply relation in driver. This means
that buck6 name must be fixed.

Br,
    Matti Vaittinen
