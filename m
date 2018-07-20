Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33854ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB7A20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB7A20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeGTJda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:33:30 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11884 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeGTJda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:33:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b51a1500000>; Fri, 20 Jul 2018 01:46:08 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 20 Jul 2018 01:46:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 20 Jul 2018 01:46:16 -0700
Received: from [10.21.132.122] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 20 Jul
 2018 08:46:14 +0000
Subject: Re: [PATCH v2] pinctrl: tegra: fix spelling in devicetree binding
 document
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180720082258.1590-1-marcel@ziswiler.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <90b69bd2-e514-5b08-4b75-74e5085ec94a@nvidia.com>
Date:   Fri, 20 Jul 2018 09:46:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180720082258.1590-1-marcel@ziswiler.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/07/18 09:22, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This fixes a spelling mistake.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - Also fix up the one in nvidia,tegra210-pinmux.txt as suggested by Jon.
> 
>  Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt | 2 +-
>  Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt
> index ecb5c0d25218..f4d06bb0b55a 100644
> --- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt
> @@ -17,7 +17,7 @@ Tegra124 adds the following optional properties for pin configuration subnodes.
>  The macros for options are defined in the
>  	include/dt-binding/pinctrl/pinctrl-tegra.h.
>  - nvidia,enable-input: Integer. Enable the pin's input path.
> -		enable :TEGRA_PIN_ENABLE0 and
> +		enable :TEGRA_PIN_ENABLE and
>  		disable or output only: TEGRA_PIN_DISABLE.
>  - nvidia,open-drain: Integer.
>  		enable: TEGRA_PIN_ENABLE.
> diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt
> index a62d82d5fbe9..85f211436b8e 100644
> --- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt
> @@ -44,7 +44,7 @@ Optional subnode-properties:
>  - nvidia,tristate: Integer.
>      0: drive, 1: tristate.
>  - nvidia,enable-input: Integer. Enable the pin's input path.
> -    enable :TEGRA_PIN_ENABLE0 and
> +    enable :TEGRA_PIN_ENABLE and
>      disable or output only: TEGRA_PIN_DISABLE.
>  - nvidia,open-drain: Integer.
>      enable: TEGRA_PIN_ENABLE.

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
