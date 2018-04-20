Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754337AbeDTJkx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:40:53 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46519 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754231AbeDTJkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:40:51 -0400
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Benjamin GAIGNARD" <benjamin.gaignard@st.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: stm32: add reset binding on stm32mp157c
Thread-Topic: [PATCH] ARM: dts: stm32: add reset binding on stm32mp157c
Thread-Index: AQHT2IfsjXu2a8WD5EuHzTsahyqdMKQJRKYA
Date: Fri, 20 Apr 2018 09:40:30 +0000
Message-ID: <26cab19f-e8ea-edf1-9ee7-e7a0cc589d2d@st.com>
References: <1524215347-10600-1-git-send-email-gabriel.fernandez@st.com>
In-Reply-To: <1524215347-10600-1-git-send-email-gabriel.fernandez@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.117]
Content-Type: text/plain; charset="utf-8"
Content-ID: <03FBC517EE0B5E4BBA83A4031F655B8F@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3K9evkq009761


On 04/20/2018 11:09 AM, gabriel.fernandez@st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch adds reset binding file.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index bc3eddc..7e91fd6 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -5,6 +5,7 @@
>    */
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/clock/stm32mp1-clks.h>
> +#include <dt-bindings/reset/stm32mp1-resets.h>
>   
>   / {
>   	#address-cells = <1>;
> 

Reviewed-by: Amelie Delaunay <amelie.delaunay@st.com>
