Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeESAgE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 20:36:04 -0400
Received: from mail-out-4.itc.rwth-aachen.de ([134.130.5.49]:63841 "EHLO
        mail-out-4.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750957AbeESAf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 20:35:59 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CvCQARbv9a/54agoZdHAEBAQQBAQoBA?=
 =?us-ascii?q?YJvVFOBCzKYZ4F5gQ+VLgsshEACghEhOBQBAgEBAQEBAQJsKIUoAQEBAwF5EAI?=
 =?us-ascii?q?BCBgJJQ8BIiUCBAENhSEIAQOrcIhJgg+GEYIkgVU+hBuEc4VUAoxWi3YHAneVP?=
 =?us-ascii?q?IUhkFACAgICCQIUgSUzIYFSTSSDE4JHjgaCBI1QAYEXAQE?=
X-IPAS-Result: =?us-ascii?q?A2CvCQARbv9a/54agoZdHAEBAQQBAQoBAYJvVFOBCzKYZ4F?=
 =?us-ascii?q?5gQ+VLgsshEACghEhOBQBAgEBAQEBAQJsKIUoAQEBAwF5EAIBCBgJJQ8BIiUCB?=
 =?us-ascii?q?AENhSEIAQOrcIhJgg+GEYIkgVU+hBuEc4VUAoxWi3YHAneVPIUhkFACAgICCQI?=
 =?us-ascii?q?UgSUzIYFSTSSDE4JHjgaCBI1QAYEXAQE?=
X-IronPort-AV: E=Sophos;i="5.49,416,1520895600";
   d="scan'208";a="9769393"
From: =?iso-8859-1?Q?Br=FCns=2C_Stefan?= <Stefan.Bruens@rwth-aachen.de>
To: "linux-sunxi@googlegroups.com" <linux-sunxi@googlegroups.com>,
        "Paul Kocialkowski" <contact@paulk.fr>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: [linux-sunxi] Re: [PATCH v4 3/3] ARM: dts: sun7i: Add support for
 the Ainol AW1 tablet
Thread-Topic: [linux-sunxi] Re: [PATCH v4 3/3] ARM: dts: sun7i: Add support
 for the Ainol AW1 tablet
Thread-Index: AQHT7nfpuM7SaQUnk0GpGjEzr+ffBKQ2EYYA
Date: Sat, 19 May 2018 00:26:14 +0000
Message-ID: <33944340.T0tLPSd54F@sbruens-linux>
References: <20180507220413.21990-1-contact@paulk.fr>
 <0da5787f0ce2309a74db88820bc58b3b3501c451.camel@paulk.fr>
 <20180518071436.3vvyllghrdxptsxg@flea>
In-Reply-To: <20180518071436.3vvyllghrdxptsxg@flea>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [78.35.13.203]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C2DBBB7700A0594F9E84816559F38FF8@rwth-ad.de>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Freitag, 18. Mai 2018 09:14:36 CEST Maxime Ripard wrote:
> On Mon, May 14, 2018 at 10:36:08PM +0200, Paul Kocialkowski wrote:
> > > > +	backlight: backlight {
> > > > +		compatible = "pwm-backlight";
> > > > +		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
> > > > +		brightness-levels = <  0   1   1   1   1   2   2   2
> > > > +				       2   3   3   3   3   4   4   4
> > > > +				       5   5   5   6   6   6   7   7
> > > > +				       8   8   8   9   9   9  10  10
> > > > +				      10  11  11  12  12  12  13  13
> > > > +				      14  14  14  15  15  16  16  17
> > > > +				      17  17  18  18  19  19  20  20
> > > > +				      21  21  21  22  22  23  23  24
> > > > +				      24  25  25  26  26  27  27  28
> > > > +				      28  29  30  30  31  31  32  32
> > > > +				      33  33  34  35  35  36  36  37
> > > > +				      38  38  39  39  40  41  41  42
> > > > +				      43  43  44  44  45  46  47  47
> > > > +				      48  49  49  50  51  51  52  53
> > > > +				      54  54  55  56  57  57  58  59
> > > > +				      60  61  61  62  63  64  65  65
> > > > +				      66  67  68  69  70  71  71  72
> > > > +				      73  74  75  76  77  78  79  80
> > > > +				      81  82  83  84  85  86  87  88
> > > > +				      89  90  91  92  93  94  95  96
> > > > +				      97  98  99 101 102 103 104 105
> > > > +				     106 108 109 110 111 112 114 115
> > > > +				     116 117 119 120 121 123 124 125
> > > > +				     127 128 129 131 132 133 135 136
> > > > +				     138 139 141 142 144 145 147 148
> > > > +				     150 151 153 154 156 157 159 161
> > > > +				     162 164 166 167 169 171 173 174
> > > > +				     176 178 180 181 183 185 187 189
> > > > +				     191 192 194 196 198 200 202 204
> > > > +				     206 208 210 212 214 216 219 221
> > > > +				     223 225 227 229 232 234 236 238
> > > > +				     241 242 244 246 248 250 253 255>;
> > > 
> > > You kind of overdid it here :)
> > > 
> > > What I meant to say before was that if you have 10 elements (and you
> > > really should have something in that magnitude) each step should
> > > increase the perceived brightness by 10%.
> > 
> > Mhh I think 10 elements would fall too short to really depict the curve
> > with appropriate precision. Given the usual size for brightness cursors
> > in e.g. gnome-shell, it feels like a bigger number would be more
> > appropriate. Let's make it to 100 with values from 0 to 255!
> > 
> > > In this particular case, I really think having something close to <0 4
> > > 8 16 32 64 128 255> would be enough.
> > > 
> > > And in general, that kind of odd looking table without any more
> > > context is just screaming for a comment :)
> > 
> > Noted, I will explain the idea, but probably without the exact formula
> > that's really a nasty hack written down on a piece of paper sitting in
> > my garbage at this point.
> 
> So no one will ever be able to understand where this sequence comes
> from (yourself-in-two-years included). That sounds like a pretty bad
> idea.
> 
> Maxime

The following formula yields practically the same table:

out = ceil(255 * (0.245 * in/255  +  0.755 * pow(in/255, 2.6) ))

Maximum error: 4, maximum relative error: 0.33 

Kind regards,

Stefan
