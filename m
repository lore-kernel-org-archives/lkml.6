Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbeEDLb1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 07:31:27 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34633 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeEDLbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 07:31:25 -0400
X-Google-Smtp-Source: AB8JxZpk+bs07tgp4JSfAAp256NHGN7UtUtBG+OrZgXTZeZeKFHNxjw9PpyFUzKYnv4ebNc8fmivMw==
Subject: Re: [PATCH v1 2/5] drm/tegra: gr2d: Add IOMMU support
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180503234723.4368-1-digetx@gmail.com>
 <20180503234723.4368-3-digetx@gmail.com> <20180504105416.GN13459@ulmo>
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
Message-ID: <56f36af6-6113-9b96-4bd3-b386d31c6b5b@gmail.com>
Date: Fri, 4 May 2018 14:31:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504105416.GN13459@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.05.2018 13:54, Thierry Reding wrote:
> On Fri, May 04, 2018 at 02:47:20AM +0300, Dmitry Osipenko wrote:
>> Attach GR2D to the display IOMMU group in order to provide GR2D access
>> to BO's IOVA.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/gpu/drm/tegra/gr2d.c | 31 +++++++++++++++++++++++++++++--
>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
>> index 9a8ea93016a9..8eb530a85dd0 100644
>> --- a/drivers/gpu/drm/tegra/gr2d.c
>> +++ b/drivers/gpu/drm/tegra/gr2d.c
>> @@ -7,12 +7,14 @@
>>   */
>>  
>>  #include <linux/clk.h>
>> +#include <linux/iommu.h>
>>  
>>  #include "drm.h"
>>  #include "gem.h"
>>  #include "gr2d.h"
>>  
>>  struct gr2d {
>> +	struct iommu_group *group;
>>  	struct tegra_drm_client client;
>>  	struct host1x_channel *channel;
>>  	struct clk *clk;
>> @@ -30,7 +32,9 @@ static int gr2d_init(struct host1x_client *client)
>>  	struct tegra_drm_client *drm = host1x_to_drm_client(client);
>>  	struct drm_device *dev = dev_get_drvdata(client->parent);
>>  	unsigned long flags = HOST1X_SYNCPT_HAS_BASE;
>> +	struct tegra_drm *tegra = dev->dev_private;
>>  	struct gr2d *gr2d = to_gr2d(drm);
>> +	int err;
>>  
>>  	gr2d->channel = host1x_channel_request(client->dev);
>>  	if (!gr2d->channel)
>> @@ -42,23 +46,46 @@ static int gr2d_init(struct host1x_client *client)
>>  		return -ENOMEM;
>>  	}
>>  
>> -	return tegra_drm_register_client(dev->dev_private, drm);
>> +	if (tegra->domain) {
>> +		gr2d->group = iommu_group_get(client->dev);
>> +
>> +		if (gr2d->group) {
>> +			err = iommu_attach_group(tegra->domain, gr2d->group);
>> +			if (err < 0) {
>> +				dev_err(client->dev,
>> +					"failed to attach to domain: %d\n",
>> +					err);
>> +				host1x_syncpt_free(client->syncpts[0]);
>> +				host1x_channel_put(gr2d->channel);
>> +				iommu_group_put(gr2d->group);
>> +				return err;
>> +			}
>> +		}
>> +	}
> 
> This is almost identical to the code in DC, perhaps we should factor
> this out into a separate helper? Nothing that needs to be done right
> now, I'll take a look at it and see if I can come up with something
> good in a follow-up patch.

Sounds good.
