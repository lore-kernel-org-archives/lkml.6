Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbeEDLVh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 07:21:37 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35240 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeEDLVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 07:21:34 -0400
X-Google-Smtp-Source: AB8JxZoKXT7aE2KSQ7QxLDL5zC9G9SkAyUT3zmiJLd8RdmJm6NmGzfQbD+69M8goOT19zcWGYhTqhw==
Subject: Re: [PATCH v2 4/4] ARM: dts: tegra20: Revert "Fix ULPI regression on
 Tegra20"
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marcel Ziswiler <marcel@ziswiler.com>, Marc Dietrich <marvin24@gmx.de>,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180503225537.20748-1-digetx@gmail.com>
 <20180503225537.20748-6-digetx@gmail.com> <20180504104051.GL13459@ulmo>
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
Message-ID: <5013e8c6-a56a-38ad-2a25-d18bf0a1e014@gmail.com>
Date: Fri, 4 May 2018 14:21:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504104051.GL13459@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.05.2018 13:40, Thierry Reding wrote:
> On Fri, May 04, 2018 at 01:55:37AM +0300, Dmitry Osipenko wrote:
>> Commit 4c9a27a6c66d ("ARM: tegra: Fix ULPI regression on Tegra20") changed
>> "ulpi-link" clock from CDEV2 to PLL_P_OUT4. Turned out that PLL_P_OUT4 is
>> the parent of CDEV2 clock and original clock setup of "ulpi-link" was
>> correct. The reverted patch was fixing USB for one board and broke the
>> other, now Tegra's clk driver correctly sets parent for the CDEV2 clock
>> and hence patch could be reverted safely, restoring USB for all of the
>> boards.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> Reviewed-by: Marcel Ziswiler <marcel@ziswiler.com>
>> Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
>> Tested-by: Marc Dietrich <marvin24@gmx.de>
>> ---
>>  arch/arm/boot/dts/tegra20.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Is it still true that this patch alone fixes the known regression? I'm
> just asking because the remainder of the series, even though it sounds
> to be the right thing to do, is fairly big for a fix against v4.17.

Yes, Marcel says that reverting just this patch works for him now.

> So if this alone fixes the regression I think it'd be best to queue it
> up for v4.17 and get the rest of the patches into v4.18.

Sounds good.
