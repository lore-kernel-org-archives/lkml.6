Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6C7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56B7218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbeLXMAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 07:00:52 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58030 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbeLXMAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 07:00:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF66E80D;
        Mon, 24 Dec 2018 04:00:51 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85F473F718;
        Mon, 24 Dec 2018 04:00:51 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id D0DAB680369; Mon, 24 Dec 2018 12:00:49 +0000 (GMT)
Date:   Mon, 24 Dec 2018 12:00:49 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 2/9] dt/bindings: drm/komeda: Add DT bindings for ARM
 display processor D71
Message-ID: <20181224120049.GD22341@e110455-lin.cambridge.arm.com>
References: <20181221095757.15510-1-james.qian.wang@arm.com>
 <20181221095757.15510-3-james.qian.wang@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181221095757.15510-3-james.qian.wang@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 09:59:12AM +0000, james qian wang (Arm Technology China) wrote:
> Add DT bindings documentation for the ARM display processor D71 and later
> IPs.
> 
> Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
> 
> Changes in v3:
> - Deleted unnecessary property: interrupt-names.
> - Dropped 'ports' and moving 'port' up a level.
> ---
>  .../bindings/display/arm/arm,komeda.txt       | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/arm/arm,komeda.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/arm/arm,komeda.txt b/Documentation/devicetree/bindings/display/arm/arm,komeda.txt
> new file mode 100644
> index 000000000000..b4e450243c7d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/arm/arm,komeda.txt
> @@ -0,0 +1,79 @@
> +Device Tree bindings for ARM Komeda display driver
> +
> +Required properties:
> +- compatible: Should be "arm,mali-d71"
> +- reg: Physical base address and length of the registers in the system
> +- interrupts: the interrupt line number of the device in the system
> +- clocks: A list of phandle + clock-specifier pairs, one for each entry
> +    in 'clock-names'
> +- clock-names: A list of clock names. It should contain:
> +      - "mclk": for the main processor clock
> +      - "pclk": for the APB interface clock
> +- #address-cells: Must be 1
> +- #size-cells: Must be 0
> +
> +Required properties for sub-node: pipeline@nq
> +Each device contains one or two pipeline sub-nodes (at least one), each
> +pipeline node should provide properties:
> +- reg: Zero-indexed identifier for the pipeline
> +- clocks: A list of phandle + clock-specifier pairs, one for each entry
> +    in 'clock-names'
> +- clock-names: should contain:
> +      - "pxclk": pixel clock
> +      - "aclk": AXI interface clock
> +
> +- port: each pipeline connect to an encoder input port. The connection is
> +    modeled using the OF graph bindings specified in
> +    Documentation/devicetree/bindings/graph.txt
> +
> +Optional properties:
> +  - memory-region: phandle to a node describing memory (see
> +    Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt)
> +    to be used for the framebuffer; if not present, the framebuffer may
> +    be located anywhere in memory.
> +
> +Example:
> +/ {
> +	...
> +
> +	dp0: display@c00000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "arm,mali-d71";
> +		reg = <0xc00000 0x20000>;
> +		interrupts = <0 168 4>;
> +		clocks = <&dpu_mclk>, <&dpu_aclk>;
> +		clock-names = "mclk", "pclk";
> +
> +		dp0_pipe0: pipeline@0 {
> +			clocks = <&fpgaosc2>, <&dpu_aclk>;
> +			clock-names = "pxclk", "aclk";
> +			reg = <0>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <0>;

These are undocumented and not necessary anyway, as the pipelines will
inherit display's attributes.

> +
> +			port@0 {
> +				dp0_pipe0_out: endpoint {
> +					remote-endpoint = <&db_dvi0_in>;
> +				};
> +			};
> +		};
> +
> +		dp0_pipe1: pipeline@1 {
> +			clocks = <&fpgaosc2>, <&dpu_aclk>;
> +			clock-names = "pxclk", "aclk";
> +			reg = <1>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <0>;

same here.

> +
> +			port@0 {
> +				dp0_pipe1_out: endpoint {
> +					remote-endpoint = <&db_dvi1_in>;
> +				};
> +			};
> +		};
> +	};
> +	...
> +};
> -- 
> 2.17.1
> 

With these changes:

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu


-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
