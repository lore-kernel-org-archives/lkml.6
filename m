Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683F9C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BBA20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CQEd4N6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfA1Hqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:46:33 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14936 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfA1Hqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:46:33 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4eb33d0001>; Sun, 27 Jan 2019 23:46:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 27 Jan 2019 23:46:32 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 27 Jan 2019 23:46:32 -0800
Received: from [10.19.108.140] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Jan
 2019 07:46:30 +0000
Subject: Re: [PATCH 1/6] dt-bindings: usb: xhci-tegra: Add Tegra186 support
To:     Thierry Reding <thierry.reding@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, <linux-usb@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190125113013.11447-1-thierry.reding@gmail.com>
From:   jckuo <jckuo@nvidia.com>
Message-ID: <69c05dea-0e52-addf-c119-04d1a241e3b2@nvidia.com>
Date:   Mon, 28 Jan 2019 15:46:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125113013.11447-1-thierry.reding@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548661565; bh=mw+dUIsMZSrjgMZE8FQZ+N4w57HedyUGoKQVI5jKPp8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=CQEd4N6zBHtroqXSVBffbwqyUCRGTw1ZXpNS+3O08dP7yWcIl8j/v+Cc94k5/OnbQ
         cpdjcSKopHFgpDLArVfwil/Xq3iZX6xcK68zA23D0SJdiAtNNBaWCMVLxFADzlewR4
         m0+a10kQgMG1J3B31nZ9IIihi3BoUzsDQjlUvNngafcHTxKOWX4yuInPrKopfG9yA0
         ePQKjNvufJRn7WwYtkuHkgdpIKTEV89cfXCZsmGiQbbYc41mQpsO0sQzYY8uyUL9rk
         9jBqu87diSVB4hGe1vJX2uS0RiSyAn1u5iR6i1YBmoMsLDXwM8t+DD5XcI2VbceFNM
         59jsv6pH+/EkA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: JC Kuo <jckuo@nvidia.com>

On 1/25/19 7:30 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Extend the bindings to cover the set of features found in Tegra186.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   .../devicetree/bindings/usb/nvidia,tegra124-xusb.txt          | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
> index 4156c3e181c5..5bfcc0b4d6b9 100644
> --- a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
> +++ b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
> @@ -10,6 +10,7 @@ Required properties:
>     - Tegra124: "nvidia,tegra124-xusb"
>     - Tegra132: "nvidia,tegra132-xusb", "nvidia,tegra124-xusb"
>     - Tegra210: "nvidia,tegra210-xusb"
> +  - Tegra186: "nvidia,tegra186-xusb"
>   - reg: Must contain the base and length of the xHCI host registers, XUSB FPCI
>     registers and XUSB IPFS registers.
>   - reg-names: Must contain the following entries:
> @@ -59,6 +60,8 @@ For Tegra210:
>   - avdd-pll-uerefe-supply: PLLE reference PLL power supply. Must supply 1.05 V.
>   - dvdd-pex-pll-supply: PCIe/USB3 PLL power supply. Must supply 1.05 V.
>   - hvdd-pex-pll-e-supply: High-voltage PLLE power supply. Must supply 1.8 V.
> +
> +For Tegra210 and Tegra186:
>   - power-domains: A list of PM domain specifiers that reference each power-domain
>     used by the xHCI controller. This list must comprise of a specifier for the
>     XUSBA and XUSBC power-domains. See ../power/power_domain.txt and
> @@ -78,6 +81,7 @@ Optional properties:
>     - Tegra132: usb2-0, usb2-1, usb2-2, hsic-0, hsic-1, usb3-0, usb3-1
>     - Tegra210: usb2-0, usb2-1, usb2-2, usb2-3, hsic-0, usb3-0, usb3-1, usb3-2,
>                 usb3-3
> +  - Tegra186: usb2-0, usb2-1, usb2-2, hsic-0, usb3-0, usb3-1, usb3-2
>   
>   Example:
>   --------
