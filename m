Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753557AbeENMvg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:51:36 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46270 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753284AbeENMvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:51:32 -0400
X-Google-Smtp-Source: AB8JxZoenv9V+9Cpl9MpZQCW0tiHixNB3nMSXaJMHCeFATCs4a0j5F9cWnY5ngMf9qIxZoP6ljad+w==
Subject: Re: [PATCH v1] i2c: tegra: Remove suspend-resume
To: Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Shardar Shariff Md <smohammed@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180513211347.7187-1-digetx@gmail.com>
 <20180514115933.GH18312@ulmo>
 <d83fc1f7-d5e5-4211-1cd8-babcabdd9c4b@nvidia.com>
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
Message-ID: <5949e650-8ab5-b4bb-196d-5a0705383141@gmail.com>
Date: Mon, 14 May 2018 15:51:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d83fc1f7-d5e5-4211-1cd8-babcabdd9c4b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.05.2018 15:21, Laxman Dewangan wrote:
> 
> 
> On Monday 14 May 2018 05:29 PM, Thierry Reding wrote:
>> * PGP Signed by an unknown key
>>
>> On Mon, May 14, 2018 at 12:13:47AM +0300, Dmitry Osipenko wrote:
>>> Nothing prevents I2C clients to access I2C while Tegra's driver is being
>>> suspended, this results in -EBUSY error returned to the clients and that
>>> may have unfortunate consequences. In particular this causes problems
>>> for the TPS6586x MFD driver which emits hundreds of "failed to read
>>> interrupt status" error messages on resume from suspend. This happens if
>>> TPS6586X is used to wake system from suspend by the expired RTC alarm
>>> timer because TPS6586X is an I2C device driver and its IRQ handler reads
>>> the status register while Tegra's I2C driver is suspended, i.e. just after
>>> kernel enabled IRQ's during of resume-from-suspend process.
>>>
>>> Note that the removed tegra_i2c_resume() invoked tegra_i2c_init() which
>>> performs HW reset. That seems was also not entirely correct because moving
>>> tegra_i2c_resume to an earlier stage of resume-from-suspend process causes
>>> I2C transfer to fail in the case of TPS6586X. It is fine to remove the
>>> HW-reinitialization for now because it should be only needed in a case of
>>> using lowest power-mode during suspend, which upstream kernel doesn't
>>> support.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>>   drivers/i2c/busses/i2c-tegra.c | 33 ---------------------------------
>>>   1 file changed, 33 deletions(-)
>> Shardar, Laxman, any thoughts on this? The is_suspended thing looks to
>> me like a workaround of some sort that may not be needed if clients have
>> proper suspend/resume implementations. Even without suspend/resume
>> support in client drivers, the driver core should resume devices in the
>> right order (I2C adapter before any of the clients), so I don't see any
>> cases where the is_suspended logic would be useful.
>>
> 
> Our I2C driver is based on the interrupt. So we have converted the
> suspend/resume to suspend_noirq and reseume_noirq so that we will not allow the
> transfer when system interrupt disabled in downstream.
>           SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(tegra_i2c_suspend, tegra_i2c_resume)
> 
> In shutdown path, where interrupt disabled and still need i2c, we use the
> bit-bang method via GPIO for i2c transfer.
In the current upstream kernel suspend/resume can't be simply moved to the
'noirq' stage because resume invokes tegra_i2c_init() which uses runtime PM and
that doesn't work with the IRQ's being disabled. But things do not work even
with the tegra_i2c_init() changed to work with the disabled IRQ's, like I wrote
above the I2C transfer fails (due to timeout) and a "fix" for that failure was
to remove reset_control_assert/deassert from the tegra_i2c_init(). So I'd go for
a complete suspend/resume removal for now as it is causes problem.
