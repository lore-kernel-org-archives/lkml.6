Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbeCLJGi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:06:38 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9760 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750988AbeCLJGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:06:36 -0400
From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
To: Rob Herring <robh@kernel.org>
CC: "sboyd@kernel.org" <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
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
        Olivier BIDEAU <olivier.bideau@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2 01/12] dt-bindings: Document STM32MP1 Reset Clock
 Controller (RCC) bindings
Thread-Topic: [PATCH v2 01/12] dt-bindings: Document STM32MP1 Reset Clock
 Controller (RCC) bindings
Thread-Index: AQHTtv4YAZrTZxLX0kSjTI36DqQJ5KPIhQUAgAO+9oA=
Date: Mon, 12 Mar 2018 09:06:11 +0000
Message-ID: <7d552f25-a7b8-c99a-8f28-eb9beb455724@st.com>
References: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
 <1520528045-18330-2-git-send-email-gabriel.fernandez@st.com>
 <20180309235356.qd2wx6teeuxkwwjz@rob-hp-laptop>
In-Reply-To: <20180309235356.qd2wx6teeuxkwwjz@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D139A43B588564B91C9154FD6C33D94@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2C96jjd003604

Thanks Rob !

Best Regards

Gabriel


On 03/10/2018 12:53 AM, Rob Herring wrote:
> On Thu, Mar 08, 2018 at 05:53:54PM +0100, gabriel.fernandez@st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> The RCC block is responsible of the management of the clock and reset
>> generation for the complete circuit.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>> ---
>>   .../devicetree/bindings/clock/st,stm32mp1-rcc.txt  | 60 ++++++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.txt
> Reviewed-by: Rob Herring <robh@kernel.org>
