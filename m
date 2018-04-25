Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeDYFw5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 01:52:57 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59852 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeDYFww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 01:52:52 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180425055250euoutp02426909337bb3a03eb791a3e57ee18493~ol-khRuA51801118011euoutp02b
X-AuditID: cbfec7f4-6f9ff700000043e4-c1-5ae017b0de1f
Subject: Re: [RFT][PATCH] arm64: dts: exynos: Remove unneeded address space
 mapping for soc node
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <4ebc237b-b29a-0169-8d1b-8726b33bbf9c@samsung.com>
Date: Wed, 25 Apr 2018 07:52:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424173652.14735-1-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH++3eu12HV67T2PGByaIn+SThUiYSUkuCgvrHWdnMi0rz0eYj
        C1LDRJepCGkO8RFZNk2XmtZAwQdezXyTlvgqpbLQWa5EisrtzvK/zznfc873HDgkJuEIVzI2
        PolVxytVMqEYb+lZH/QySOcUvqMlHsxceYuQMT3MQ8yE+SPBVHQPEkzB/BeMGRoyiJjG+XGC
        GTOWCZl7Q+0CpnpiRMDcf2YWMbfaukXM4tdePJiS15XXIXmjPlcob3qQLs9v1iP5aqPHaUIh
        DoxiVbEprNon6KI4Zqz9Dkqccrw6UN+DZ6CflBbZkUAfhLI1g1CLxKSErkGQNffWFpgRrAzo
        EB+sIijONaDNlnVTldDCEvoRAu3iGb7IhMC8/MFa5ERHwgz3BLcIznQhBnOVrVYBo89Ch67f
        ykLaD7RLWuskig6CGoPWmsfpXVA73GvNb6fPQXH5hICvcYS+0gXcwnZ0AHQslWD8zB3QulRm
        YylMLlQILMZAj4vAOFmA8WuHwIqpRcSzE3zmmm3sDn9eVAh4Tof8tW5bcx6Ctqy7NuEwdHEj
        hBaRGw77oMHoY0Ggj8Bo7UkeHeDNkiO/ggMUtVhWs6QpyMmW8DN2g46r/2faMTyKFaKdui2H
        6bYco9tyjO6/bSXC9UjKJmviolmNfzyb6q1RxmmS46O9LyXENaKN9+r/zZmfI+OvyE5Ek0hm
        T/mGzSokhDJFkxbXiYDEZM5Um8eMQkJFKdOuseqECHWyitV0IjcSl0mpC3tvKCR0tDKJvcyy
        iax6UxWQdq4Z6Kl98J4k/3d9MY+nf0weDXHJnB4/NfDN5H7g0MTr6uvf9YQscBDCMwvTVMqo
        Y9ho4KBnae1YECcVVA6/DOpZJjubvNYM7vleV7qmIyN8ynOcqnzfh6VySaqbrwLkOz/dDqWi
        fY0NzaEuRcvVU+GzpGeos56b3HbCjajKDs4/f1yGa2KUfvsxtUb5FzrwfepaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xe7rrxB9EGbR2WVk8mLeNzeL9sh5G
        i+tfnrNazD9yjtWi//FrZovz5zewW2x6fI3V4vKuOWwWM87vY7JYev0ik8WirV/YLVr3HmG3
        ePnxBIsDr8eaeWsYPTat6mTz2Lyk3qNvyypGj8+b5AJYo/RsivJLS1IVMvKLS2yVog0tjPQM
        LS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyLu/rZSy4I1hxdt0xlgbG37xdjJwcEgIm
        Ej/fL2QDsYUEljJKnFmiDBGXkTg5rYEVwhaW+HOtC6iGC6jmLaPEks0vWEASwgJJEveOr2UB
        SYgITGKW6Dq+F6yDWSBEYubCT8wQHR2MEjPmHmEGSbAJGEp0ve0CW8crYCexYkMXI4jNIqAq
        sfrCCbC4qECMxI+jXSwQNYISJ2c+AbM5BUwlDr6dzgyxwExi3uaHULa8xPa3c6BscYlbT+Yz
        TWAUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMGK3Hfu5eQfj
        pY3BhxgFOBiVeHgNIu9HCbEmlhVX5h5ilOBgVhLh3St3L0qINyWxsiq1KD++qDQntfgQoynQ
        cxOZpUST84HJJK8k3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dUA+PC
        8oK2c0tlkpZmudgyuUhx6MasXO7yyK/atvuOkliyVs3M/6rbfS/pdrDdjH9nf6y0IUG3oH+5
        ytZtPzKFwzr3dAdOLZ8iLBrWkdV90yria/VVhfYTB1Y/Tar85aOxZ9WCve1ZQtPb+Q/3KpZd
        +bnK5DzHZme5OpuvEpcPbbsZo9B2b17DByWW4oxEQy3mouJEAESNnWDuAgAA
X-CMS-MailID: 20180425055247eucas1p1cc4f48b73af46c0accfd2b6fc0fb6735
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180425055247eucas1p1cc4f48b73af46c0accfd2b6fc0fb6735
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180424173731epcas2p15cddb6a4ea379f6d1736a93961a9c913
X-RootMTR: 20180424173731epcas2p15cddb6a4ea379f6d1736a93961a9c913
References: <CGME20180424173731epcas2p15cddb6a4ea379f6d1736a93961a9c913@epcas2p1.samsung.com>
        <20180424173652.14735-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2018-04-24 19:36, Krzysztof Kozlowski wrote:
> Remove the address space mapping between root and soc nodes to fix
> DTC warnings in Exynos5433 and Exynos7 like:
>
>      arch/arm64/boot/dts/exynos/exynos5433-tm2.dtb:
>          Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Works fine on Samsung Exynos5433-based TM2e board.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>
> Not tested.
> ---
>   arch/arm64/boot/dts/exynos/exynos5433.dtsi | 6 +++---
>   arch/arm64/boot/dts/exynos/exynos7.dtsi    | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index 828996a06610..ba8157ceaa56 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -18,8 +18,8 @@
>   
>   / {
>   	compatible = "samsung,exynos5433";
> -	#address-cells = <2>;
> -	#size-cells = <2>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
>   
>   	interrupt-parent = <&gic>;
>   
> @@ -235,7 +235,7 @@
>   		compatible = "simple-bus";
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> -		ranges = <0x0 0x0 0x0 0x18000000>;
> +		ranges;
>   
>   		arm_a53_pmu {
>   			compatible = "arm,cortex-a53-pmu", "arm,armv8-pmuv3";
> diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> index 0b98d2334cad..93a84338938a 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> @@ -12,8 +12,8 @@
>   / {
>   	compatible = "samsung,exynos7";
>   	interrupt-parent = <&gic>;
> -	#address-cells = <2>;
> -	#size-cells = <2>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
>   
>   	aliases {
>   		pinctrl0 = &pinctrl_alive;
> @@ -70,7 +70,7 @@
>   		compatible = "simple-bus";
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> -		ranges = <0 0 0 0x18000000>;
> +		ranges;
>   
>   		chipid@10000000 {
>   			compatible = "samsung,exynos4210-chipid";

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
