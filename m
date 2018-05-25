Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936295AbeEYVSj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:18:39 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39421 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030216AbeEYVSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:18:37 -0400
X-Google-Smtp-Source: ADUXVKIMnmjmWiQHS4qWGabnX78sjsuaYIn5Z2aUzwKIA88DuesOsZqKkt3njB/MQk05KPLcuQP93Q==
Subject: Re: [PATCH] memory: tegra: include linux/spinlock.h
To: Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180525211155.1928474-1-arnd@arndb.de>
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
Message-ID: <11dbcb7d-4aa8-90c2-83b2-66e0d6e8bb10@gmail.com>
Date: Sat, 26 May 2018 00:18:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180525211155.1928474-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.05.2018 00:11, Arnd Bergmann wrote:
> The newly added code in this file causes a build error unless
> we include linux/spinlock.h, at least in some configurations:
> 
> In file included from drivers/memory/tegra/mc.h:15,
>                  from drivers/memory/tegra/tegra20.c:11:
> include/soc/tegra/mc.h:159:2: error: unknown type name 'spinlock_t'
>   spinlock_t lock;
>   ^~~~~~~~~~
> drivers/memory/tegra/tegra20.c: In function 'terga20_mc_hotreset_assert':
> drivers/memory/tegra/tegra20.c:207:2: error: implicit declaration of function 'spin_lock_irqsave'; did you mean 'arch_local_irq_save'? [-Werror=implicit-function-declaration]
>   spin_lock_irqsave(&mc->lock, flags);
>   ^~~~~~~~~~~~~~~~~
> 
> Fixes: cb557757e1aa ("memory: tegra: Add Tegra20 memory controller hot resets")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/memory/tegra/tegra20.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/memory/tegra/tegra20.c b/drivers/memory/tegra/tegra20.c
> index 7119e532471c..8853e21b773f 100644
> --- a/drivers/memory/tegra/tegra20.c
> +++ b/drivers/memory/tegra/tegra20.c
> @@ -6,6 +6,7 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/spinlock.h>
>  #include <dt-bindings/memory/tegra20-mc.h>
>  
>  #include "mc.h"

Yes, the spinlock header was getting included indirectly.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
