Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeECL7e (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:59:34 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45465 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbeECL7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:59:30 -0400
X-Google-Smtp-Source: AB8JxZp1/FJigrpOnCb7WuAtHr5dQgJQ+LEj5UISPtijvqrC3iMWl6L1sSDvteNmiYiQBatdGC+UEg==
Subject: Re: [PATCH v1 1/4] clk: tegra20: Add DEV1/DEV2 OSC dividers
To: Marcel Ziswiler <marcel@ziswiler.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Dietrich <marvin24@gmx.de>
Cc: linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180426235818.10018-1-digetx@gmail.com>
 <20180426235818.10018-2-digetx@gmail.com>
 <1524832404.6979.9.camel@ziswiler.com>
 <a8fc30b9-42ce-b29a-abc6-2867ebf4a9ac@gmail.com>
 <1524834018.6979.13.camel@ziswiler.com>
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
Message-ID: <7c4e96ea-8bcf-1643-1b0f-29dc85b62b7b@gmail.com>
Date: Thu, 3 May 2018 14:59:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524834018.6979.13.camel@ziswiler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.04.2018 16:00, Marcel Ziswiler wrote:
> On Fri, 2018-04-27 at 15:54 +0300, Dmitry Osipenko wrote:
>> Hi Marcel,
>>
>> On 27.04.2018 15:33,  Ziswiler wrote:
>>> Hi Dmitry
>>>
>>> Isn't the CLK_RST_CONTROLLER_MISC_CLK_ENB_0 the other way around
>>> e.g.
>>> DEV1_OSC_DIV_SEL at bit 23:22 and DEV2_OSC_DIV_SEL at 21:20?
>>>
>>> On Fri, 2018-04-27 at 02:58 +0300, Dmitry Osipenko wrote:
>>>> CDEV1/CDEV2 clocks could have corresponding oscillator clock
>>>> divider
>>>> as
>>>> a parent. Add these dividers in order to be able to provide that
>>>> parent
>>>> option.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/clk/tegra/clk-tegra20.c | 12 ++++++++++++
>>>>  1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/tegra/clk-tegra20.c
>>>> b/drivers/clk/tegra/clk-
>>>> tegra20.c
>>>> index 0ee56dd04cec..16cf4108f2ff 100644
>>>> --- a/drivers/clk/tegra/clk-tegra20.c
>>>> +++ b/drivers/clk/tegra/clk-tegra20.c
>>>> @@ -26,6 +26,8 @@
>>>>  #include "clk.h"
>>>>  #include "clk-id.h"
>>>>  
>>>> +#define MISC_CLK_ENB 0x48
>>>> +
>>>>  #define OSC_CTRL 0x50
>>>>  #define OSC_CTRL_OSC_FREQ_MASK (3<<30)
>>>>  #define OSC_CTRL_OSC_FREQ_13MHZ (0<<30)
>>>> @@ -831,6 +833,16 @@ static void __init
>>>> tegra20_periph_clk_init(void)
>>>>  				    periph_clk_enb_refcnt);
>>>>  	clks[TEGRA20_CLK_PEX] = clk;
>>>>  
>>>> +	/* cdev1 OSC divider */
>>>> +	clk_register_divider(NULL, "cdev1_osc_div", "clk_m",
>>>> +			     0, clk_base + MISC_CLK_ENB, 20, 2,
>>>
>>> So it would be:
>>>
>>> +			     0, clk_base + MISC_CLK_ENB, 22, 2,
>>>
>>>> +			     CLK_DIVIDER_POWER_OF_TWO, NULL);
>>>> +
>>>> +	/* cdev2 OSC divider */
>>>> +	clk_register_divider(NULL, "cdev2_osc_div", "clk_m",
>>>> +			     0, clk_base + MISC_CLK_ENB, 22, 2,
>>>
>>> And:
>>>
>>> +			     0, clk_base + MISC_CLK_ENB, 20, 2,
>>>
>>>> +			     CLK_DIVIDER_POWER_OF_TWO, NULL);
>>>> +
>>>>  	/* cdev1 */
>>>>  	clk = clk_register_fixed_rate(NULL, "cdev1_fixed", NULL,
>>>> 0,
>>>> 26000000);
>>>>  	clk = tegra_clk_register_periph_gate("cdev1",
>>>> "cdev1_fixed",
>>>> 0,
>>
>> Indeed, good catch! I'll wait for more comments and then re-spin
>> patchset with
>> the fix. Thank you.
> 
> You are very welcome. Thank you!
> 
> Other than that it all looks proper and works fine at least in the
> configuration we use on Colibri T20. So you may add my reviewed and
> tested bys to the whole series:
> 
> Reviewed-by: Marcel Ziswiler <marcel@ziswiler.com>
> Tested-by: Marcel Ziswiler <marcel@ziswiler.com>

Marcel, you previously mentioned that reverting of your DT patch works for the
Colibri now. Does that reverting also work for the 4.17 kernel? If yes, I may
add stable tag to the revert-patch to get back paz00 working with 4.17. If it's
not working, we should figure out why pll_p_out4 is getting disabled as it
should be a distinct issue.
