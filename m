Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeERCo3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 22:44:29 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:38942 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeERCo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 22:44:26 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180518024424epoutp0186b7eab097047e22fc7eeeadfe0d58c4~vnQnU2GeI1394113941epoutp01b
X-AuditID: b6c32a35-9cbff70000001024-7d-5afe3e041f72
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5AFE3E04.6060801@samsung.com>
Date: Fri, 18 May 2018 11:44:20 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, Will Deacon <will.deacon@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>, linux-clk@vger.kernel.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Lin Huang <hl@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [RFC PATCH 04/10] devfreq: rk3399_dmc / rockchip: pm_domains:
 Register notify to DMC driver.
In-reply-to: <20180514211610.26618-5-enric.balletbo@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUxTVxzNfe/1tZAVnxX0hiWuvmTJbELltVbuCCVzY9uLEtNs2UbYFvYC
        b0BKW9LXurFks8OhtqLIx/wDkH2hcaRLGMhkhsos3VTMY6F8dRKKG4aBMoxDpcIKa/tY5l/3
        nN8955eck3sVuGqFTFeUWx283cpV0GQy8cPATm0GkbtWmBn0InRi6DqG7nT3kWj04T0SeSf9
        AJ1paQBo/Y+7MnSm4WMU6RzE0XJIJFH3UK0MidULctQ1My5D92vDMjRyqZVESycCAP19ax1H
        w4Mvo8lPz5No5vxfclTjC8jR2vj3BJrqFAGav3+NQDfrf8NegKy3zQvYe6EaOdviGibY3ql2
        wNaLGew3ffMY29XhJtmLj27J2OnjVzG2u/0QG23uJ9iTFzoAe3G8DWeXurabUgr5nDKeK+Ht
        at5abCspt5Ya6f2vF71UZNiTyWQwz6MsWm3lLLyRzss3ZbxSXhErgVYf5CqcsZGJEwR6V26O
        3eZ08Ooym+Aw0m8zjE7LZGZpdbrYqX83W2eISd7jywK+22RltebDy56bwAV6aQ9QKCC1G9bM
        5nlAskJF9QK4HB0gJLIM4AP/SIwkJUTBu+6Ni04AG3tWsPiFktoMI41hIr4Jp56BgaA5Psap
        nXDuQcOGfgrAnmgkoVFSGjgwvS+uIahn4enD5+RxTMbG/XMhMo43UTvgWGQGxHEaVQB//OKR
        PL4nlarD4ZL7MBYnOOUiYNNCS8K9hTLD1cXTCUcS9SL8fPhrMi6ClFsBR8+JuBQhDzaN1QMJ
        b4F3rl6QS/mfhsGfjZL+KIBHfW24RJoAHJoIY5JBD2e/8mBSthS4+LBWJpmV8NgRlSRh4YTo
        2ahrL2yd827EFwH8rvVb8hTY3vxEY83/N9b8RGNfArwDbOUrBUspLzCVjFbgLILTWqottlm6
        QOLdawy9oGko3w8oBaCfUp6qixaqZNxBocriB1CB06nKbMNaoUpZwlV9xNttRXZnBS/4gSHW
        eD2enlZsi/0iq6OIMej0ej3azewxMAy9TXkkK2aiSjkHb+b5St7+nw9TJKW7gDHwzuBe8Zex
        xcixQ59cCVb9mvP+Z5sxZfJ0qPqDbNPW1AJxJZyeO/G4YG3HKNUykl+7q/9s30Laq7P/vOW/
        dvuka9XH6Nvf4I7/dMBrHtyvA45w3Z+rNy5NiM68szc2vWnQrruuzKFJ8+Xfq6caTT3PXXdP
        P07RzPtCr9Vta1Dvi9KEUMYxGtwucP8CX7LlNQ0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t9jQV0Wu39RBtMeKVr0njvJZPFq8x42
        iytf37NZrLl9iNFi7uxJjBb/H71mtZg7qdbix4ZTzBbfb5xls9h8rofV4mzTG3aLTY+vsVp8
        7LnHanF51xw2i8+9RxgtPj34z2xx8ZSrxe3GFWwWj1e8Zbdo3XuE3eLftY0sFnc3nGW0ePnx
        BIvFrYk3mRwkPNbMW8Po8f5GK7vH7IaLLB477i5h9Jh4Vtdj8Z6XTB6bVnWyeWz/9oDV4373
        cSaPzUvqPf7O2s/i0bdlFaPH9mvzmD0+b5IL4IvisklJzcksSy3St0vgyjiy9wlbQZNWxb6u
        W4wNjDuUuhg5OSQETCQuve5k6WLk4hASWMcosfb8W0aQBK+AoMSPyfeAEhwczALyEkcuZUOY
        6hJTpuRClN9nlFj4uocRJM4roCVx+L4XSCeLgKrEtOZl7CA2G1B4/4sbbCA2v4CixNUfj8HK
        RQUiJLpPVIKMERHoZ5aYdu0MI4jDLNDEIvGtv4sZpEFYIFvi97tpjBDLzjJKXN58FGwSp4CT
        xNSLi9gmMArMQnLqLIRTZyGcuoCReRWjZGpBcW56brFRgWFearlecWJucWleul5yfu4mRmCU
        bzus1beD8f6S+EOMAhyMSjy8Lyb+jRJiTSwrrsw9xCjBwawkwmtl+i9KiDclsbIqtSg/vqg0
        J7X4EKM0B4uSOO/tvGORQgLpiSWp2ampBalFMFkmDk6pBsb6P66LyzymH9hz/oRl+5LvjCn7
        83b/mWwYfM89NOD4PE1hiW9ClZz9eY9KDb+7ZIlefX5786wobob5WwNvLrW6nH/jn7Bp1jT3
        VUvjljJZMYVaKMTqdGZoaWuFGxZmzL7lotPx1MLa2+jT0Wbpe64zP/7xe67AKfimNe3cYr5N
        vyzCnBKqapVYijMSDbWYi4oTAXgxbY7uAgAA
X-CMS-MailID: 20180518024420epcas1p189df156d3518d29fa00373fde1a3b6d4
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180514211809epcas3p47e2f67ad346dc2fc35c46465381fbffa
X-RootMTR: 20180514211809epcas3p47e2f67ad346dc2fc35c46465381fbffa
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
        <CGME20180514211809epcas3p47e2f67ad346dc2fc35c46465381fbffa@epcas3p4.samsung.com>
        <20180514211610.26618-5-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As I already commented[1], I think that it is not proper in order to pass
the devfreq instance to power_domain driver by separate defined function
(rockchip_pm_register_dmcfreq_notifier()).
[1] https://patchwork.kernel.org/patch/10349571/

Maybe, you could check the 'OF graph[1]' or 'device connection[2]'
for the device connection. Unfortunately, I'm not sure what is
best solution for this issue.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/graph.txt
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f2d9b66d84f3ff5ea3aff111e6a403e04fa8bf37


On 2018년 05월 15일 06:16, Enric Balletbo i Serra wrote:
> From: Lin Huang <hl@rock-chips.com>
> 
> The DMC (Dynamic Memory Interface) controller does a SiP call to the
> Trusted Firmware-A (TF-A) to change the DDR clock frequency. When this
> happens the TF-A writes to the PMU bus idle request register
> (PMU_BUS_IDLE_REQ) but at the same time it is possible that the Rockchip
> power domain driver writes to the same register. So, add a notification
> mechanism to ensure that the DMC and the PD driver does not access to this
> register at the same time.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> [rewrite commit message]
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> As I explained in the cover letter I have doubts regarding this patch
> but I did not find another way to do it. So I will appreciate any
> feedback on this.
> 
>  drivers/devfreq/rk3399_dmc.c      |  7 ++++++
>  drivers/soc/rockchip/pm_domains.c | 36 +++++++++++++++++++++++++++++++
>  include/soc/rockchip/rk3399_dmc.h | 14 ++++++++++++
>  3 files changed, 57 insertions(+)
>  create mode 100644 include/soc/rockchip/rk3399_dmc.h
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index cc1bbca3fb15..2c4985a501cb 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -28,6 +28,7 @@
>  #include <linux/rwsem.h>
>  #include <linux/suspend.h>
>  
> +#include <soc/rockchip/rk3399_dmc.h>
>  #include <soc/rockchip/rk3399_grf.h>
>  #include <soc/rockchip/rockchip_sip.h>
>  
> @@ -443,6 +444,12 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  	data->dev = dev;
>  	platform_set_drvdata(pdev, data);
>  
> +	rockchip_pm_register_dmcfreq_notifier(data->devfreq);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to register dmcfreq notifier\n");
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
> index 53efc386b1ad..b0e66f24b3e3 100644
> --- a/drivers/soc/rockchip/pm_domains.c
> +++ b/drivers/soc/rockchip/pm_domains.c
> @@ -8,6 +8,7 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/devfreq.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/err.h>
> @@ -76,9 +77,13 @@ struct rockchip_pmu {
>  	const struct rockchip_pmu_info *info;
>  	struct mutex mutex; /* mutex lock for pmu */
>  	struct genpd_onecell_data genpd_data;
> +	struct devfreq *devfreq;
> +	struct notifier_block dmc_nb;
>  	struct generic_pm_domain *domains[];
>  };
>  
> +static struct rockchip_pmu *dmc_pmu;
> +
>  #define to_rockchip_pd(gpd) container_of(gpd, struct rockchip_pm_domain, genpd)
>  
>  #define DOMAIN(pwr, status, req, idle, ack, wakeup)	\
> @@ -601,6 +606,35 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
>  	return error;
>  }
>  
> +static int rk3399_dmcfreq_notify(struct notifier_block *nb,
> +				 unsigned long event, void *data)
> +{
> +	if (event == DEVFREQ_PRECHANGE)
> +		mutex_lock(&dmc_pmu->mutex);
> +	else if (event == DEVFREQ_POSTCHANGE)
> +		mutex_unlock(&dmc_pmu->mutex);
> +
> +	return NOTIFY_OK;
> +}
> +
> +int rockchip_pm_register_dmcfreq_notifier(struct devfreq *devfreq)
> +{
> +	int ret;
> +
> +	if (!dmc_pmu)
> +		return -EPROBE_DEFER;
> +
> +	dmc_pmu->devfreq = devfreq;
> +	dmc_pmu->dmc_nb.notifier_call = rk3399_dmcfreq_notify;
> +	ret = devm_devfreq_register_notifier(devfreq->dev.parent,
> +					     dmc_pmu->devfreq,
> +					     &dmc_pmu->dmc_nb,
> +					     DEVFREQ_TRANSITION_NOTIFIER);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(rockchip_pm_register_dmcfreq_notifier);
> +
>  static int rockchip_pm_domain_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -694,6 +728,8 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
>  		goto err_out;
>  	}
>  
> +	dmc_pmu = pmu;
> +
>  	return 0;
>  
>  err_out:
> diff --git a/include/soc/rockchip/rk3399_dmc.h b/include/soc/rockchip/rk3399_dmc.h
> new file mode 100644
> index 000000000000..031a62607f61
> --- /dev/null
> +++ b/include/soc/rockchip/rk3399_dmc.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2016-2018, Fuzhou Rockchip Electronics Co., Ltd
> + * Author: Lin Huang <hl@rock-chips.com>
> + */
> +
> +#ifndef __SOC_RK3399_DMC_H
> +#define __SOC_RK3399_DMC_H
> +
> +#include <linux/devfreq.h>
> +
> +int rockchip_pm_register_dmcfreq_notifier(struct devfreq *devfreq);
> +
> +#endif
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
