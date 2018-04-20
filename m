Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754736AbeDTKuR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:50:17 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:43556 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754511AbeDTKuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:50:14 -0400
X-Google-Smtp-Source: AB8JxZqa7DsozSFDSDxif1RCdGL8jXSra1bdI3RWMOC3qJ0Oj3Ixtw0MtLNVJ1vORq87Q5Arln16Pw==
Subject: Re: [PATCH] ARM: tegra: fix ulpi regression on tegra20
To: Marc Dietrich <marvin24@gmx.de>, Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
References: <20180219151252.29289-1-marcel@ziswiler.com>
 <6600596.BijQW1iq1K@ax5200p>
From: Dmitry Osipenko <digetx@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=digetx@gmail.com; prefer-encrypt=mutual; keydata=
 xsBNBFpX5TwBCADQhg+lBnTunWSPbP5I+rM9q6EKPm5fu2RbqyVAh/W3fRvLyghdb58Yrmjm
 KpDYUhBIZvAQoFLEL1IPAgJBtmPvemO1XUGPxfYNh/3BlcDFBAgERrI3BfA/6pk7SAFn8u84
 p+J1TW4rrPYcusfs44abJrn8CH0GZKt2AZIsGbGQ79O2HHXKHr9V95ZEPWH5AR0UtL6wxg6o
 O56UNG3rIzSL5getRDQW3yCtjcqM44mz6GPhSE2sxNgqureAbnzvr4/93ndOHtQUXPzzTrYB
 z/WqLGhPdx5Ouzn0Q0kSVCQiqeExlcQ7i7aKRRrELz/5/IXbCo2O+53twlX8xOps9iMfABEB
 AAHNIkRtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT7CwJQEEwEIAD4WIQSczHcO
 3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRDTNNaPsNRzvFjTCACqAh1M9/YPq73/ai5h2ExDquTgJnjegL8KL2yHL3G+XINwzN5E
 nPI7esoYm+zVWDJbv3UuRqylpookLNSRA01yyvkaMcipB/B128UnqmUiGRqezj9QE20yIauo
 uHRuwHPE2q+UkfUhRX9iuOaEyQtZDiCa0myMjmRkJ+Z8ZetclEPG8dYZu47w04phuMlu1QAt
 a0gkZOaMKvXgj21ushALS6nYnvm7HiIPQXfnEXThartatRvFdmbG4PCn0IoICkQBizwJtXrL
 HEjELIFap0M8krVJlUoZTFaZnaZkGpUDWikeFtAuie2KuIxmVBYPM4X7pM3eP3AVvIPGS7EE
 UUFuzsBNBFpX5TwBCADFNDou220thijaLLGaQsebWjzc/gPRxMixIpk856MRyRaQin+IbGD6
 YskMb5ZSD3nS88LIKNfY4MMH0LwfYztI++ICG2vdFLkbBt78E+LqEa+kZ9072l4W5KO3mWQo
 +jMfxXbpgGlc7iuEReDgl8iyZ27r51kSW665CYvvu2YJhLqgdj6QM1lN2D1UnhEhkkU+pRAj
 1rJVOxdfJaQNQS4+204p3TrURovzNGkN/brqakpNIcqGOAGQqb8F0tuwwuP7ERq/BzDNkbdr
 qJOrVC/wkHRq1jfabQczWKf8MwYOvivR3HY8d3CpSQxmUXDtdOWfg0XGm1dxYnVfqPjuJaZt
 ABEBAAHCwHwEGAEIACYWIQSczHcO3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbDAUJA8JnAAAK
 CRDTNNaPsNRzvJzuB/9d+sxcwHbO8ZDcgaLX9N+bXFqN9fIRVmBUyWa+qqTSREA4uVAtYcRT
 lfPE2OQ7aMFxaYPwo+/z5SLpu8HcEhN/FG9uIkfYwK0mdCO0vgvlfvBJm4VHe7C6vyAeEPJQ
 DKbBvdgeqFqO+PsLkk2sawF/9sontMJ5iFfjNDj4UeAo4VsdlduTBZv5hHFvIbv/p7jKH6OT
 90FsgUSVbShh7SH5OzAcgqSy4kxuS1AHizWo6P3f9vei987LZWTyhuEuhJsOfivDsjKIq7qQ
 c5eR+JJtyLEA0Jt4cQGhpzHtWB0yB3XxXzHVa4QUp00BNVWyiJ/t9JHT4S5mdyLfcKm7ddc9
Message-ID: <4f2ac009-8618-4b4d-e137-a5fd4907a56f@gmail.com>
Date: Fri, 20 Apr 2018 13:50:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6600596.BijQW1iq1K@ax5200p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.2018 11:52, Marc Dietrich wrote:
> Hi Marcel,
> 
> Am Montag, 19. Februar 2018, 16:12:52 CEST schrieb Marcel Ziswiler:
>> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>
>> Since commit f8f8f1d04494 ("clk: Don't touch hardware when reparenting
>> during registration") ULPI has been broken on Tegra20 leading to the
>> following error message during boot:
>>
>> [    1.974698] ulpi_phy_power_on: ulpi write failed
>> [    1.979384] tegra-ehci c5004000.usb: Failed to power on the phy
>> [    1.985434] tegra-ehci: probe of c5004000.usb failed with error -110
>>
>> Debugging through the changes and finally also consulting the TRM
>> revealed that rather than the CDEV2 clock off OSC requiring such pin
>> muxing actually the PLL_P_OUT4 clock is in use. It looks like so far it
>> just worked by chance of that one having been enabled which Stephen's
>> commit now changed when reparenting sclk away from pll_p_out4 leaving
>> that one disabled. Fix this by properly assigning the PLL_P_OUT4 clock
>> as the ULPI PHY clock.
> 
> I booted 4.17-rc1 (which includes this fix) on an AC100 (T20 paz00 board) and 
> the error above is still there. Surprisingly the error vanishes when I revert 
> your patch. So this patch actually *causes* the problem above on my board. 
> Could it be, that we need all four clocks? Dimitry mentioned on IRC that it 
> could also be a problem in the clock init table. I don't have the technical 
> background myself to fix it, but I still wonder what could be so different 
> between TrimSlice and AC100.

I managed to find CDEV clocks in TRM this time. Seems assigning CDEV2 clock to
"ulpi-link" was correct and both CDEV2 and PLL_P_OUT4 should be enabled, CDEV2
should gate the PLL_P_OUT4 that feeds USB HW and PLL_P_OUT4 should be
always-enabled because it is enabled by init_table, but apparently it is getting
disabled erroneously.

Marcel, could you please revert your patch, add
"trace_event=clk_enable,clk_disable,clk_set_parent tp_printk" to kernels cmdline
and post the log?

It looks like there is some clk framework bug, but just in case please also try
to apply this patch:

diff --git a/drivers/clk/tegra/clk-tegra-periph.c
b/drivers/clk/tegra/clk-tegra-periph.c
index 2acba2986bc6..407bd0c0ac2f 100644
--- a/drivers/clk/tegra/clk-tegra-periph.c
+++ b/drivers/clk/tegra/clk-tegra-periph.c
@@ -1024,7 +1024,7 @@ static void __init init_pllp(void __iomem *clk_base, void
__iomem *pmc_base,
                if (dt_clk) {
                        clk = tegra_clk_register_pll_out("pll_p_out4",
                                        "pll_p_out4_div", clk_base + PLLP_OUTB,
-                                       17, 16, CLK_IGNORE_UNUSED |
+                                       17, 16, CLK_IS_CRITICAL |
                                        CLK_SET_RATE_PARENT, 0,
                                        &PLLP_OUTB_lock);
                        *dt_clk = clk;
