Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753003AbeERJRB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:17:01 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35807 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbeERISL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:18:11 -0400
X-Google-Smtp-Source: AB8JxZoyZoA4nrOd8pFJ8Yy1yqiuyr9VnpwaeUnxjWCWeEiat1cqsjQ4mDeNdmfs+bOa7sJKP7YTvw==
Subject: Re: [PATCH v1 00/11] Clean up Tegra20 cpufreq driver
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
References: <20180517180056.13336-1-digetx@gmail.com>
 <33210093.0R9M0pnSOk@aspire.rjw.lan>
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
Message-ID: <9c4a31e5-4f32-c951-6d9e-82798d6500bf@gmail.com>
Date: Fri, 18 May 2018 11:18:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <33210093.0R9M0pnSOk@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.05.2018 10:30, Rafael J. Wysocki wrote:
> On Thursday, May 17, 2018 8:00:45 PM CEST Dmitry Osipenko wrote:
>> Hello,
>>
>> Recently Peter Geis (who is working on Tegra30 cpufreq driver) asked me how
>> tegra20-cpufreq driver is getting loaded. After taking a look at the code
>> it became apparent that the drivers code has been rusted a tad and so this
>> series is intended to refresh the drivers code by disallowing module to be
>> loaded on non-Tegra20 machines, by cleaning whitespaces in the code, removing
>> dead EMC code and in the end by allowing tegra20-cpufreq to be built as a
>> loadable module.
>>
>> Please review, thanks.
>>
>> Dmitry Osipenko (11):
>>   cpufreq: tegra20: Change module description
>>   cpufreq: tegra20: Clean up whitespaces in the code
>>   cpufreq: tegra20: Remove EMC clock usage
>>   cpufreq: tegra20: Release clocks properly
>>   cpufreq: tegra20: Clean up included headers
>>   cpufreq: tegra20: Remove unneeded check in tegra_cpu_init
>>   cpufreq: tegra20: Check if this is Tegra20 machine
>>   cpufreq: tegra20: Remove unneeded variable initialization
>>   cpufreq: tegra20: Allow cpufreq driver to be built as loadable module
>>   cpufreq: tegra20: Wrap cpufreq into platform driver
>>   ARM: tegra: Create platform device for tegra20-cpufreq driver
>>
>>  arch/arm/mach-tegra/tegra.c       |   4 +
>>  drivers/cpufreq/Kconfig.arm       |   2 +-
>>  drivers/cpufreq/tegra20-cpufreq.c | 172 +++++++++++++++++-------------
>>  3 files changed, 101 insertions(+), 77 deletions(-)
>>
>>
> 
> It looks like Viresh has ACKed the majority of the patches in this series,
> but there are a few where he had comments.
> 
> Please fix up these and resend the entire series with the Acked-by tags from
> Viresh added where applicable.

Sure, I'll address the Viresh's review comments in the v2 that I'll probably
prepare and send out later today. I'll also add another minor-cleanup patch to
the series that removes unnecessary brackets in the code.

Thierry / Jon, please let me if there is anything you disagree-with in the
series as I'd like to avoid re-sending multiple times.

Thanks.
