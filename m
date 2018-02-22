Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933043AbeBVPeP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:34:15 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60031 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932874AbeBVPeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:34:13 -0500
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/6] gpio: Add GPIO support for the ST Multi-Function
 eXpander
Thread-Topic: [PATCH 3/6] gpio: Add GPIO support for the ST Multi-Function
 eXpander
Thread-Index: AQHToOkDMk7LryqMCE6GHDVul6FkVaOwdNKAgAAdlIA=
Date: Thu, 22 Feb 2018 15:33:31 +0000
Message-ID: <2440a092-507d-bc39-6ed6-4a4ee094da7a@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
 <1518100057-23234-4-git-send-email-amelie.delaunay@st.com>
 <CACRpkdaeFXuB1Qv-vqNpf4pHsAysiYh03_gfNoRdHBh1pN_Amw@mail.gmail.com>
In-Reply-To: <CACRpkdaeFXuB1Qv-vqNpf4pHsAysiYh03_gfNoRdHBh1pN_Amw@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E024ED14A7477541AA91EDA73DF3AA9A@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1MFYKEi010732



On 02/22/2018 02:47 PM, Linus Walleij wrote:
> On Thu, Feb 8, 2018 at 3:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:
> 
>> ST Multi-Function eXpander (MFX) can be used as GPIO expander.
>> It has 16 fast GPIOs and can have 8 extra alternate GPIOs
>> when other MFX features are not enabled.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> 
> As mentioned I think this driver needs to:
> 
> - Move to drivers/pinctrl/pinctrl-stmfx.c similar to the sx150x controller.
> - Pass a regmap around instead of the custom accessor functions.

I study this right now!
Thanks,
Amelie

> - Maybe refactor and reuse STMPE infrastructure
> 
> Yours,
> Linus Walleij
> 
