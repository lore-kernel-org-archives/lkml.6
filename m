Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeCTIUs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 04:20:48 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:15887 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751328AbeCTIUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 04:20:45 -0400
From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
To: Stephen Boyd <sboyd@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "gabriel.fernandez.st@gmail.com" <gabriel.fernandez.st@gmail.com>,
        Olivier BIDEAU <olivier.bideau@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH RESEND 2/2] clk: stm32: Add DSI clock for STM32F469 Board
Thread-Topic: [PATCH RESEND 2/2] clk: stm32: Add DSI clock for STM32F469 Board
Thread-Index: AQHTt3Pu/R5B2FNf1k2nD0shjh6Li6PYBtIAgADCBYA=
Date: Tue, 20 Mar 2018 08:20:07 +0000
Message-ID: <898668a8-5582-e84f-878a-35749ab39657@st.com>
References: <1520578651-28849-1-git-send-email-gabriel.fernandez@st.com>
 <1520578651-28849-3-git-send-email-gabriel.fernandez@st.com>
 <152149234283.242365.10046675267029705746@swboyd.mtv.corp.google.com>
In-Reply-To: <152149234283.242365.10046675267029705746@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9ED6ABD04D4494ABB60EA6AA5A4B5B4@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-20_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2K8KrMQ025147

Thanks Stephen !

Best Regards

Gabriel


On 03/19/2018 09:45 PM, Stephen Boyd wrote:
> Quoting gabriel.fernandez@st.com (2018-03-08 22:57:31)
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> This patch adds DSI clock for STM32F469 board
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>> ---
> Applied to clk-next
>
