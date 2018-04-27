Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757887AbeD0KOT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 06:14:19 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36832 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757807AbeD0KN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 06:13:58 -0400
X-Google-Smtp-Source: AB8JxZpw37xD1d6ul3kqDJWRQ2giZk8BeTn8Tc5qpZ2lVmqrXW1CdcXgrrAEv74xVRoZ8Ro8W++0tQ==
Subject: Re: [PATCH v4 09/15] memory: tegra: Squash tegra20-mc into common
 tegra-mc driver
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1523301400.git.digetx@gmail.com>
 <675f74f82378b5f7d8f61d35e929614a0e156141.1523301400.git.digetx@gmail.com>
 <20180427093435.GB30388@ulmo>
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
Message-ID: <882f14b8-78c8-95bb-326e-3917c9736faf@gmail.com>
Date: Fri, 27 Apr 2018 13:13:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427093435.GB30388@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.04.2018 12:34, Thierry Reding wrote:
> On Mon, Apr 09, 2018 at 10:28:31PM +0300, Dmitry Osipenko wrote:
> [...]
>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> [...]
>> +#define MC_GART_ERROR_REQ		0x30
>> +#define MC_DECERR_EMEM_OTHERS_STATUS	0x58
>> +#define MC_SECURITY_VIOLATION_STATUS	0x74
> [...]
>> diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
> [...]
>> @@ -21,19 +21,30 @@
>>  #define MC_INT_INVALID_SMMU_PAGE (1 << 10)
>>  #define MC_INT_ARBITRATION_EMEM (1 << 9)
>>  #define MC_INT_SECURITY_VIOLATION (1 << 8)
>> +#define MC_INT_INVALID_GART_PAGE (1 << 7)
>>  #define MC_INT_DECERR_EMEM (1 << 6)
>>  
>>  static inline u32 mc_readl(struct tegra_mc *mc, unsigned long offset)
>>  {
>> +	if (mc->regs2 && offset >= 0x24)
>> +		return readl(mc->regs2 + offset - 0x3c);
> 
> I'm still not sure how this is supposed to work. If we pass in
> MC_GART_ERROR_REQ as offset into mc_readl(), then the condition above
> will be true (0x30 >= 0x24) but then the new offset will be computed
> and we end up with:
> 
> 	return readl(mc->regs2 + 0x30 - 0x3c);
> 
> which means we'll be adding a negative offset (or rather a very large
> offset because it will wrap around).

Indeed! Thank you for pointing at it again, now I see the issue. It probably
works because actual registers mapping is aligned to page(?) size and adding the
large offset with wraparound is equal to subtraction.

That register belongs to the GART and we can't simply move interrupt handling to
the GART driver because status register is within the MC in device tree. We can
omit reading of MC_GART_ERROR_REQ and simply report GART page fault for the
starter and then reorganize drivers by making MC driver MFD and GART its
sub-device, what do you think?
