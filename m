Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759668AbeD1ISq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 04:18:46 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46267 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759553AbeD1ISm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 04:18:42 -0400
X-Google-Smtp-Source: AB8JxZoTNMuxfAsSwHQkSQagrfFUnUH9f6wMobMQXxKJzEfnXCtLGsldPOc4O7lsaXz5cqG1U4yvMg==
Subject: Re: [PATCH v4 11/15] memory: tegra: Add Tegra210 memory controller
 hot resets
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1523301400.git.digetx@gmail.com>
 <f064d034477537bfb5473c1277da07d772b0d4b5.1523301400.git.digetx@gmail.com>
 <20180427093927.GK30388@ulmo>
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
Message-ID: <935ad30c-1ade-3380-ad4d-f5ffbbe63a66@gmail.com>
Date: Sat, 28 Apr 2018 11:18:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427093927.GK30388@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.04.2018 12:39, Thierry Reding wrote:
> On Fri, Apr 13, 2018 at 02:33:50PM +0300, Dmitry Osipenko wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> Define the table of memory controller hot resets for Tegra210.
>>
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
>>  drivers/memory/tegra/tegra210.c | 45 +++++++++++++++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>
>> diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra210.c
>> index b729f49ffc8f..d00a77160407 100644
>> --- a/drivers/memory/tegra/tegra210.c
>> +++ b/drivers/memory/tegra/tegra210.c
>> @@ -1080,6 +1080,48 @@ static const struct tegra_smmu_soc tegra210_smmu_soc = {
>>  	.num_asids = 128,
>>  };
>>  
>> +#define TEGRA210_MC_RESET(_name, _control, _status, _bit)	\
>> +	{							\
>> +		.name = #_name,					\
>> +		.id = TEGRA210_MC_RESET_##_name,		\
>> +		.control = _control,				\
>> +		.status = _status,				\
>> +		.bit = _bit,					\
>> +	}
>> +
>> +static const struct tegra_mc_reset tegra210_mc_resets[] = {
>> +	TEGRA210_MC_RESET(AFI,       0x200, 0x204,  0),
>> +	TEGRA210_MC_RESET(AVPC,      0x200, 0x204,  1),
>> +	TEGRA210_MC_RESET(DC,        0x200, 0x204,  2),
>> +	TEGRA210_MC_RESET(DCB,       0x200, 0x204,  3),
>> +	TEGRA210_MC_RESET(HC,        0x200, 0x204,  6),
>> +	TEGRA210_MC_RESET(HDA,       0x200, 0x204,  7),
>> +	TEGRA210_MC_RESET(ISP2,      0x200, 0x204,  8),
>> +	TEGRA210_MC_RESET(MPCORE,    0x200, 0x204,  9),
>> +	TEGRA210_MC_RESET(NVENC,     0x200, 0x204, 11),
>> +	TEGRA210_MC_RESET(PPCS,      0x200, 0x204, 14),
>> +	TEGRA210_MC_RESET(SATA,      0x200, 0x204, 15),
>> +	TEGRA210_MC_RESET(VI,        0x200, 0x204, 17),
>> +	TEGRA210_MC_RESET(VIC,       0x200, 0x204, 18),
>> +	TEGRA210_MC_RESET(XUSB_HOST, 0x200, 0x204, 19),
>> +	TEGRA210_MC_RESET(XUSB_DEV,  0x200, 0x204, 20),
>> +	TEGRA210_MC_RESET(A9AVP,     0x200, 0x204, 21),
>> +	TEGRA210_MC_RESET(TSEC,      0x200, 0x204, 22),
>> +	TEGRA210_MC_RESET(SDMMC1,    0x200, 0x204, 29),
>> +	TEGRA210_MC_RESET(SDMMC2,    0x200, 0x204, 30),
>> +	TEGRA210_MC_RESET(SDMMC3,    0x200, 0x204, 31),
>> +	TEGRA210_MC_RESET(SDMMC4,    0x970, 0x974,  0),
>> +	TEGRA210_MC_RESET(ISP2B,     0x970, 0x974,  1),
>> +	TEGRA210_MC_RESET(GPU,       0x970, 0x974,  2),
>> +	TEGRA210_MC_RESET(NVDEC,     0x970, 0x974,  5),
>> +	TEGRA210_MC_RESET(APE,       0x970, 0x974,  6),
>> +	TEGRA210_MC_RESET(SE,        0x970, 0x974,  7),
>> +	TEGRA210_MC_RESET(NVJPG,     0x970, 0x974,  8),
>> +	TEGRA210_MC_RESET(AXIAP,     0x970, 0x974, 11),
>> +	TEGRA210_MC_RESET(ETR,       0x970, 0x974, 12),
>> +	TEGRA210_MC_RESET(TSECB,     0x970, 0x974, 13),
>> +};
> 
> Isn't this missing an include for the definitions? There is an include
> for dt-bindings/memory/tegra20-mc.h for the Tegra20 driver, but none of
> the others have it.

Those drivers already have dt-bindings included.

> No need to respin, though, I can add that when applying.
