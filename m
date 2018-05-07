Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752937AbeEGUOn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:14:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50799 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752915AbeEGUOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:14:41 -0400
X-Google-Smtp-Source: AB8JxZp2z2ZRiQvgcPw9I6PtL88wb0mxpFSwvh0Qm8GRbN34NBzzJY+N4MThGxWMb0ezuPrfdjL5Hg==
Subject: Re: [PATCH 1/2] dt-bindings: leds: Add SC27xx breathing light
 controller documentation
To: Baolin Wang <baolin.wang@linaro.org>, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc: xiaotong.lu@spreadtrum.com, broonie@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <099f4075ec489e425b5f1e7668a078c05f0d8509.1525427961.git.baolin.wang@linaro.org>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <db2df5f2-994b-066a-3edf-e9848356cecd@gmail.com>
Date: Mon, 7 May 2018 22:13:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <099f4075ec489e425b5f1e7668a078c05f0d8509.1525427961.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

Thank you for the patch. Please find few notes below.

On 05/04/2018 12:08 PM, Baolin Wang wrote:
> This patch adds the binding documentation for Spreadtrum SC27xx series
> breathing light controller, which supports 3 outputs: red LED, green
> LED and blue LED.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>   .../devicetree/bindings/leds/leds-sc27xx-bltc.txt  |   39 ++++++++++++++++++++
>   1 file changed, 39 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
> new file mode 100644
> index 0000000..d4e267d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
> @@ -0,0 +1,39 @@
> +LEDs connected to Spreadtrum SC27XX PMIC breathing light controller
> +
> +The SC27xx breathing light controller supports to 3 outputs:
> +red LED, green LED and blue LED. Each LED can work at normal
> +PWM mode or breath light mode.
> +
> +Required properties:
> +- compatible: should be "sprd,sc27xx-bltc".

s/should/Should/

> +- #address-cells: must be 1.

s/must/Must/

> +- #size-cells: must be 0.

Ditto.

> +- reg: specify controller address.

s/specify/Specify/

> +
> +LED sub-node properties:
> +- reg: number of LED line (could be from 0 to 2).

s/number/Number/

> +- label: (optional) name of LED.

- label: see Documentation/devicetree/bindings/leds/common.txt


> +
> +Examples:
> +
> +led-controller@200 {
> +	compatible = "sprd,sc27xx-bltc";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	reg = <0x200>;
> +
> +	red@0 {

s/red/led/

> +		label = "red";
> +		reg = <0x0>;
> +	};
> +
> +	green@1 {

s/green/led/

> +		label = "green";
> +		reg = <0x1>;
> +	};
> +
> +	blue@2 {

s/blue/led/

> +		label = "blue";
> +		reg = <0x2>;
> +	};
> +};
> 

-- 
Best regards,
Jacek Anaszewski
