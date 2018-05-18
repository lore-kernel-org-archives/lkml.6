Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752771AbeERJad (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:30:33 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38168 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeERJa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:30:29 -0400
X-Google-Smtp-Source: AB8JxZoh9S7X+VuZ+aHk1+fOBtcdTBwGJjNyQcgCr2NzHZOpF9LHV3Y//Hhqfrxx+zu0DsaO18+/jg==
Subject: Re: [PATCH v1 11/11] ARM: tegra: Create platform device for
 tegra20-cpufreq driver
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-12-digetx@gmail.com> <20180518091352.GK14500@ulmo>
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
Message-ID: <1ca8f874-40da-05b4-0b76-116164c85137@gmail.com>
Date: Fri, 18 May 2018 12:30:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518091352.GK14500@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.05.2018 12:13, Thierry Reding wrote:
> On Thu, May 17, 2018 at 09:00:56PM +0300, Dmitry Osipenko wrote:
>> Tegra20-cpufreq driver require a platform device in order to be loaded,
>> instantiate a simple platform device for the driver during of the machines
>> late initialization.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/mach-tegra/tegra.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
>> index 02e712d2ea30..f9587be48235 100644
>> --- a/arch/arm/mach-tegra/tegra.c
>> +++ b/arch/arm/mach-tegra/tegra.c
>> @@ -97,6 +97,10 @@ static void __init tegra_dt_init_late(void)
>>  	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
>>  	    of_machine_is_compatible("compal,paz00"))
>>  		tegra_paz00_wifikill_init();
>> +
>> +	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
>> +	    of_machine_is_compatible("nvidia,tegra20"))
>> +		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
>>  }
>>  
>>  static const char * const tegra_dt_board_compat[] = {
> 
> Tegra124 has a CPU frequency driver that is similar to this and it
> contains code that will instantiate the platform device from the CPU
> frequency driver's module_init function.
> 
> I think the primary reason for doing that was to not tie the code to
> 32-bit ARM, even though it never runs on anything but that, so it's
> slightly over-engineered.

The tegra124-cpufreq driver likely to be broken in regards to the module loading
as platform_device_register_simple() seem to be allowed invoked only from the
kernel itself.

Having platform_device_register_simple in the kernels module leads to a such
errors on the module loading:

# section 5 reloc 7 sym 'memset': relocation 10 out of range (0xbf805030 ->
0xc088c481)

Initially I wanted to make tegra124-cpufreq a module_platform_driver, but
decided to postpone that, as the driver is shared with ARM64 Tegra132 which
doesn't have machine-init code. Maybe we could move the devices instantiation to
something common like driver/soc/tegra/devices.c later.

> I don't mind either way, and it's easy enough to change this to
> something else later on if we want. I'll pick this up into the Tegra
> tree.
Okay, thanks.
