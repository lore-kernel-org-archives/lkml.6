Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbeBFJFq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:05:46 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58309 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752054AbeBFJFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:05:40 -0500
From: Yannick FERTRE <yannick.fertre@st.com>
To: Philippe CORNU <philippe.cornu@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH v1 1/2] dt-bindings/display/panel: otm8009a: Add optional
 power-supply property
Thread-Topic: [PATCH v1 1/2] dt-bindings/display/panel: otm8009a: Add optional
 power-supply property
Thread-Index: AQHTnmYaEqSE4IHrn0qQZfe2mAGEiaOXBauA
Date: Tue, 6 Feb 2018 09:05:21 +0000
Message-ID: <97b99cc2-c02c-8006-e0bf-f6b71ff00322@st.com>
References: <20180205094532.23547-1-philippe.cornu@st.com>
 <20180205094532.23547-2-philippe.cornu@st.com>
In-Reply-To: <20180205094532.23547-2-philippe.cornu@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D46DFA83A443BF4AA794BB5F2929CEA5@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-06_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1695oTb016997

Reviewed-by: Yannick Fertré <yannick.fertre@st.com>


On 02/05/2018 10:45 AM, Philippe Cornu wrote:
> Some boards use a dedicated voltage regulator for this panel.
> Add & document this related optional power-supply property.
>
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>   Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
> index 6862028e7b2e..203b03eefb68 100644
> --- a/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
> +++ b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
> @@ -9,6 +9,7 @@ Required properties:
>   
>   Optional properties:
>     - reset-gpios: a GPIO spec for the reset pin (active low).
> +  - power-supply: phandle of the regulator that provides the supply voltage.
>   
>   Example:
>   &dsi {
> @@ -17,5 +18,6 @@ Example:
>   		compatible = "orisetech,otm8009a";
>   		reg = <0>;
>   		reset-gpios = <&gpioh 7 GPIO_ACTIVE_LOW>;
> +		power-supply = <&v1v8>;
>   	};
>   };
