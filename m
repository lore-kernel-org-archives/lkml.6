Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FFDC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 04:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15DB218A4
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 04:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfALEox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 23:44:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:51948 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726376AbfALEow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 23:44:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D72ACAC8D;
        Sat, 12 Jan 2019 04:44:48 +0000 (UTC)
Subject: Re: [PATCH lora-next 4/4] dt-bindings: lora: sx130x: add clock
 bindings
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     linux-lpwan@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20190108084132.10214-1-ben.whitten@gmail.com>
 <20190108084132.10214-4-ben.whitten@gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <56999005-89ca-c98c-0f5b-48eda15ea9fa@suse.de>
Date:   Sat, 12 Jan 2019 05:44:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190108084132.10214-4-ben.whitten@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.01.19 um 09:41 schrieb Ben Whitten:
> The sx130x family consumes two clocks, a 32MHz clock provided by a
> connected IQ transceiver, and a 133MHz high speed clock.
> 
> In the example we connect the concentrator to output 0 of a fixed clock
> providing the 133MHz high speed clock, and we connect to output 0 of a
> connected transceiver 32MHz clock.
> 
> The connected radios are both fed from output 0 of a fixed 32MHz clock,
> with only one being the clock source back with one output to the
> sx130x concentrator.

No, no, no... See below.

> 
> Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
> ---
>  .../{ => net}/lora/semtech,sx130x.yaml        | 39 ++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/{ => net}/lora/semtech,sx130x.yaml (62%)
> 
> diff --git a/Documentation/devicetree/bindings/lora/semtech,sx130x.yaml b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
> similarity index 62%
> rename from Documentation/devicetree/bindings/lora/semtech,sx130x.yaml
> rename to Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
> index ad263bc4e60d..23a096ca2912 100644
> --- a/Documentation/devicetree/bindings/lora/semtech,sx130x.yaml
> +++ b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
> @@ -15,7 +15,8 @@ description: |
>    demodulating LoRa signals on 8 channels simultaneously.
>  
>    It is typically paired with two sx125x IQ radios controlled over an
> -  SPI directly from the concentrator.
> +  SPI directly from the concentrator. One of the radios will provide
> +  a 32MHz clock back into the concentrator.

The SX125x does not seem to document the frequency of the output clock,
so I assume it's pass-through of whatever went in, and 32 MHz seems
correct for the SX130x input side.

>  
>    The concentrator itself it controlled over SPI.
>  
> @@ -41,6 +42,20 @@ properties:
>        in Hz. Maximum SPI frequency is 10MHz although 8MHz is typically used
>        on a number of cards.
>  
> +  clocks:
> +    maxItems: 2
> +    items:
> +      - description: 32MHz clock provider
> +      - description: 133MHz high speed clock provider
> +    description: The chip requires two clock inputs; A 32MHz clock at CMOS
> +      level which is provided from a connected radio.
> +      And a 133MHz high speed clock at CMOS level provided by an oscillator.
> +
> +  clock-names:
> +    items:
> +      - const: clk32m

The pin is called CLK32M; in the specs there's XTAL32F/XTAL32T.

> +      - const: clkhs

The pin is called CLKHS; in the specs it's HSC_F.

So I assume both names are good, but wanted to double-check.

> +
>    radio-spi:
>      description: The concentrator has two radios connected which are contained
>        within the following node.
> @@ -64,11 +79,27 @@ required:
>  
>  examples:
>    - |
> +    tcxo: dummy32m {
> +      compatible = "fixed-clock";
> +      clock-frequency = <32000000>;
> +      clock-output-names = "tcxo";
> +      #clock-cells = <0>;
> +    };
> +
> +    clkhs: dummy133m {
> +      compatible = "fixed-clock";
> +      clock-frequency = <133000000>;
> +      clock-output-names = "clkhs";
> +      #clock-cells = <0>;
> +    };
> +
>      concentrator0: lora@0 {
>        compatible = "semtech,sx1301";
>        reg = <0>;
>        reset-gpios = <&pioB 27 GPIO_ACTIVE_HIGH>;
>        spi-max-frequency = <8000000>;
> +      clocks = <&radio1 0>, <&clkhs 0>;

Once again, this is wrong use of #clock-cells: <&radio1>, <&clkhs>
Otherwise you have four clocks, and your "clkhs" will be <0>.

> +      clock-names = "clk32m", "clkhs";
>  
>        radio-spi {
>          #address-cells = <1>;
> @@ -77,11 +108,17 @@ examples:
>          radio0: lora@0 {
>            compatible = "semtech,sx1257";
>            reg = <0>;
> +          clocks = <&tcxo 0>;

Ditto, <&tcxo>.

> +          clock-names = "tcxo";
>          };
>  
>          radio1: lora@1 {
>            compatible = "semtech,sx1257";
>            reg = <1>;
> +          clocks = <&tcxo 0>;

<&tcxo>

> +          clock-names = "tcxo";
> +          clock-output-names = "clk32m";
> +          #clock-cells = <0>;
>          };
>        };
>      };

This example may need to be updated to use a fixed-clock instead of the
radio'S output, due to unsolved clk provider implementation problems
that will render the example unusable.

Same as for the radio, we should also prepare optional regulator inputs.
There's at least 1.8 V and 3.3 V supplies here.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
