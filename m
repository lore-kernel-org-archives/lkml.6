Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeBEHC5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 02:02:57 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37246 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750943AbeBEHCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 02:02:50 -0500
From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
To: Rob Herring <robh@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "gabriel.fernandez.st@gmail.com" <gabriel.fernandez.st@gmail.com>,
        Olivier BIDEAU <olivier.bideau@st.com>
Subject: Re: [PATCH 02/14] dt-bindings: clock: add STM32MP1 clocks
Thread-Topic: [PATCH 02/14] dt-bindings: clock: add STM32MP1 clocks
Thread-Index: AQHTnC6ywg+QQEoQ4kW2YLQICP7Gm6OVRqeAgAAOw4A=
Date: Mon, 5 Feb 2018 07:02:24 +0000
Message-ID: <ec89b70e-1500-df15-639c-59165fb2014b@st.com>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
 <1517580222-23301-3-git-send-email-gabriel.fernandez@st.com>
 <20180205042348.2f7ssmzkajeky5l7@rob-hp-laptop>
In-Reply-To: <20180205042348.2f7ssmzkajeky5l7@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FE57713DFCCF143B32B19D42387C69F@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-05_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1572xhR031891



On 02/05/2018 07:09 AM, Rob Herring wrote:
> On Fri, Feb 02, 2018 at 03:03:30PM +0100, gabriel.fernandez@st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> This patch adds the clock binding entry for STM32MP1
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>> ---
>>   include/dt-bindings/clock/stm32mp1-clks.h | 248 ++++++++++++++++++++++++++++++
>>   1 file changed, 248 insertions(+)
>>   create mode 100644 include/dt-bindings/clock/stm32mp1-clks.h
> You can squash this into the previous patch.
Ok Thanks!

BR
Gabriel
