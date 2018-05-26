Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031696AbeEZKDI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 06:03:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51194 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031487AbeEZKDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 06:03:05 -0400
X-Google-Smtp-Source: AB8JxZqaemJKvaRBlaKNQ7tbYSksyDnTA5TlOmiESmtsE9MbkEE2DSh1Yt1c0nzyuM4Qpu2edpeXCA==
Subject: Re: [PATCH v1] media: staging: tegra-vde: Reset memory client
From: Dmitry Osipenko <digetx@gmail.com>
To: Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180520134846.31046-1-digetx@gmail.com>
 <20180520134846.31046-2-digetx@gmail.com>
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
Message-ID: <24810d9d-eede-f9dd-1dbe-e757cfa2e191@gmail.com>
Date: Sat, 26 May 2018 13:03:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180520134846.31046-2-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.05.2018 16:48, Dmitry Osipenko wrote:
> DMA requests must be blocked before resetting VDE HW, otherwise it is
> possible to get a memory corruption or a machine hang. Use the reset
> control provided by the Memory Controller to block DMA before resetting
> the VDE HW.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/staging/media/tegra-vde/tegra-vde.c | 42 +++++++++++++++++++--
>  1 file changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/tegra-vde/tegra-vde.c b/drivers/staging/media/tegra-vde/tegra-vde.c
> index 90177a59b97c..6dd3bf4481be 100644
> --- a/drivers/staging/media/tegra-vde/tegra-vde.c
> +++ b/drivers/staging/media/tegra-vde/tegra-vde.c
> @@ -73,6 +73,7 @@ struct tegra_vde {
>  	struct mutex lock;
>  	struct miscdevice miscdev;
>  	struct reset_control *rst;
> +	struct reset_control *rst_mc;
>  	struct gen_pool *iram_pool;
>  	struct completion decode_completion;
>  	struct clk *clk;
> @@ -850,9 +851,23 @@ static int tegra_vde_ioctl_decode_h264(struct tegra_vde *vde,
>  	 * We rely on the VDE registers reset value, otherwise VDE
>  	 * causes bus lockup.
>  	 */
> +	ret = reset_control_assert(vde->rst_mc);
> +	if (ret) {
> +		dev_err(dev, "DEC start: Failed to assert MC reset: %d\n",
> +			ret);
> +		goto put_runtime_pm;
> +	}
> +
>  	ret = reset_control_reset(vde->rst);
>  	if (ret) {
> -		dev_err(dev, "Failed to reset HW: %d\n", ret);
> +		dev_err(dev, "DEC start: Failed to reset HW: %d\n", ret);
> +		goto put_runtime_pm;
> +	}
> +
> +	ret = reset_control_deassert(vde->rst_mc);
> +	if (ret) {
> +		dev_err(dev, "DEC start: Failed to deassert MC reset: %d\n",
> +			ret);
>  		goto put_runtime_pm;
>  	}
>  
> @@ -880,9 +895,21 @@ static int tegra_vde_ioctl_decode_h264(struct tegra_vde *vde,
>  		ret = timeout;
>  	}
>  
> -	err = reset_control_assert(vde->rst);
> -	if (err)
> -		dev_err(dev, "Failed to assert HW reset: %d\n", err);
> +	/*
> +	 * At first reset memory client to avoid resetting VDE HW in the
> +	 * middle of DMA which could result into memory corruption or hang
> +	 * the whole system.
> +	 */
> +	err = reset_control_assert(vde->rst_mc);
> +	if (!err) {

It occurred to me that there is no need to skip the HW reset if MC resetting
fails. I'll make V2 to change that.

> +		err = reset_control_assert(vde->rst);
> +		if (err)
> +			dev_err(dev,
> +				"DEC end: Failed to assert HW reset: %d\n",
> +				err);
> +	} else {
> +		dev_err(dev, "DEC end: Failed to assert MC reset: %d\n", err);
> +	}
>  
>  put_runtime_pm:
>  	pm_runtime_mark_last_busy(dev);
> @@ -1074,6 +1101,13 @@ static int tegra_vde_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> +	vde->rst_mc = devm_reset_control_get_optional(dev, "mc");
> +	if (IS_ERR(vde->rst_mc)) {
> +		err = PTR_ERR(vde->rst_mc);
> +		dev_err(dev, "Could not get MC reset %d\n", err);
> +		return err;
> +	}
> +
>  	irq = platform_get_irq_byname(pdev, "sync-token");
>  	if (irq < 0)
>  		return irq;
> 
