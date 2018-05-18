Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeERC2J (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 22:28:09 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:16850 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbeERC2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 22:28:07 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180518022804epoutp03726ef99c0642359d15f75c85429eef1b~vnCWsehK20924909249epoutp03K
X-AuditID: b6c32a46-145ff70000001024-be-5afe3a31f832
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AFE3A30.4040505@samsung.com>
Date: Fri, 18 May 2018 11:28:00 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Saravana Kannan <skannan@codeaurora.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: Add support for QCOM devfreq FW
In-reply-to: <1526536958-29419-1-git-send-email-skannan@codeaurora.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdljTXNfQ6l+Uwd1j2hbzj5xjtTjb9Ibd
        4vKuOWwWn3uPMFosvX6RyeJ24wo2i9a9R9gtDlycyObA4bFm3hpGj8t9vUwem1Z1snn0bVnF
        6PF5k1wAa1SqTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5b
        Zg7QLUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6VoQ0MjPUMDcz0jIyBtHGtlZApUkpCa
        8W/qMbaCxbkVLVuvsTUwbgnrYuTgkBAwkZjUqNHFyMUhJLCDUWLlnklsEM53Rol9e7aydjFy
        ghW1ne1jhkjsZpQ4+/gpE0iCV0BQ4sfkeywgk5gF5CWOXMoGCTMLaEps3b2eHaL+LqPE5S+n
        2UFqeAW0JBb98wapYRFQlZg6qZkNxGYDCu9/cQPM5hdQlLj64zEjiC0qECGxc/43sDkiAqcZ
        JWb0rmCGWBAh0XzqBJgtLOAkca/7KtihnALuEkfuTgA7VELgOpvEv6MzWSA+cJGYdHk9G4Qt
        LPHq+BZ2CFta4tmqjYwQDe2MEu1750F1T2GUOHf9HhNElbHEs4VdTBCr+SQ6Dv9lhwQer0RH
        mxBEiYfEj1vroBY4Ssy+28wI8f4sRonenm1MExjlZiGF2CxEiM1CCrEFjMyrGMVSC4pz01OL
        jQqM9IoTc4tL89L1kvNzNzGCk5+W2w7GJed8DjEKcDAq8fC+mPg3Sog1say4MvcQowQHs5II
        r5Xpvygh3pTEyqrUovz4otKc1OJDjKbAEJ/ILCWanA9MzHkl8YamRsbGxham5pbGBpZK4rw3
        zYCaBNITS1KzU1MLUotg+pg4OKUaGBdNyLha/HLhJ806039p2UuiLh2b3BfHvSxXXbLC5Pv6
        dVGH2q4rCX6+c+tc/j3/OcfuWyvJHvq1O1/FaF5FldYrydjVIc82zp1zQvnWSd2l0X0lBfOL
        RfZ8XtkcrPt0jY/IM6fybbJLD0l+U//p9MrH61zNs6833ouopNZsPdw5QabZrV06eZ4SS3FG
        oqEWc1FxIgD9RZvwlAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsVy+t9jAV1Dq39RBlcaRS3mHznHanG26Q27
        xeVdc9gsPvceYbRYev0ik8XtxhVsFq17j7BbHLg4kc2Bw2PNvDWMHpf7epk8Nq3qZPPo27KK
        0ePzJrkA1igum5TUnMyy1CJ9uwSujH9Tj7EVLM6taNl6ja2BcUtYFyMnh4SAiUTb2T7mLkYu
        DiGBnYwSsze1soEkeAUEJX5MvsfSxcjBwSwgL3HkUjZImFlAXWLSvEVQ9fcZJQ6c/sQGUsMr
        oCWx6J83SA2LgKrE1EnNYGPYgML7X9wAs/kFFCWu/njMCFIuKhAh0X2iEmSMiMBZRolZLfdZ
        IOZHSCyadJIRxBYWcJK4132VFWLXHEaJvl/bwBKcAu4SR+5OYJ7AKDALyamzEE6dheTUBYzM
        qxglUwuKc9Nzi40KjPJSy/WKE3OLS/PS9ZLzczcxAoN+22Gt/h2Mj5fEH2IU4GBU4uF9MfFv
        lBBrYllxZe4hRgkOZiURXivTf1FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEefnzj0UKCaQnlqRm
        p6YWpBbBZJk4OKUaGDdUiXm0iYU+mbWq1+Hi826DG8kff/QyZF1Z4eLzK/XF7vVdO4wu7Z0a
        eD+wJ019bvBOu9usnI1O+3pkD1nYZt+4PV1CfY9w/uTUh3dU324/IHDbqEXOtsc2y0pLdoOC
        TrnDlSM/JMu2/3L8IXtC8FG74337uxFejTNTjCdfunf5T3teX0ftMyWW4oxEQy3mouJEAOEJ
        9P12AgAA
X-CMS-MailID: 20180518022801epcas2p2618a82bc445d11d84b50d91c8dc725ec
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180517060257epcas2p1b42e6969c806473ccdf38ea52a74ca04
X-RootMTR: 20180517060257epcas2p1b42e6969c806473ccdf38ea52a74ca04
References: <CGME20180517060257epcas2p1b42e6969c806473ccdf38ea52a74ca04@epcas2p1.samsung.com>
        <1526536958-29419-1-git-send-email-skannan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 05월 17일 15:02, Saravana Kannan wrote:
> The firmware present in some QCOM chipsets offloads the steps necessary for
> changing the frequency of some devices (Eg: L3). This driver implements the
> devfreq interface for this firmware so that various governors could be used
> to scale the frequency of these devices.

The description doesn't include what kind of firmware. You have to explain
the type and role of firmware. And it doesn't contain the description of correlation
between 'qcom,devfreq-fw' and 'qcom,devfreq-fw-voter'.

> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  .../bindings/devfreq/devfreq-qcom-fw.txt           |  31 ++
>  drivers/devfreq/Kconfig                            |  14 +
>  drivers/devfreq/Makefile                           |   1 +
>  drivers/devfreq/devfreq_qcom_fw.c                  | 326 +++++++++++++++++++++
>  4 files changed, 372 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
>  create mode 100644 drivers/devfreq/devfreq_qcom_fw.c
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt b/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
> new file mode 100644
> index 0000000..5e1aecf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
> @@ -0,0 +1,31 @@
> +QCOM Devfreq FW device
> +
> +Some Qualcomm Technologies, Inc. (QTI) chipsets have a FW that offloads the

you better to change the FW for more readability.
- s/FW/firmware

> +steps for frequency switching. The qcom,devfreq-fw represents this FW as a
- s/FW/firmware

Usually, DVFS feature uses the 'frequency scaling' word.
- s/frequency switching/frequency scaling

> +device. Sometimes, multiple entities want to vote on the frequency request
> +that is sent to the FW. The qcom,devfreq-fw-voter represents these voters as

s/FW/firmware

> +child devices of the corresponding qcom,devfreq-fw device.
> +
> +Required properties:
> +- compatible:		Must be "qcom,devfreq-fw" or "qcom,devfreq-fw-voter"

The use of 'devfreq' word is not proper because 'devfreq' is framework name.
I think you have to use the specific SoC name for the compatible. In the future,
if you need to support the new SoC with this driver, just you can add the new compatible.

> +Only for qcom,devfreq-fw:
> +- reg:			Pairs of physical base addresses and region sizes of
> +			memory mapped registers.
> +- reg-names:		Names of the bases for the above registers. Expected
> +			bases are: "en-base", "lut-base" and "perf-base".

It is not possible to understand what are meaning of "en-base", "lut-base" and "perf-base".
because they depend on specific H/W specification. You have to add the detailed description
why they are necessary. Also, you should explain whether thery are mandatory or optional.

> +
> +Example:
> +
> +	qcom,devfreq-l3 {
> +		compatible = "qcom,devfreq-fw";
> +		reg-names = "en-base", "lut-base", "perf-base";
> +		reg = <0x18321000 0x4>, <0x18321110 0x600>, <0x18321920 0x4>;
> +
> +		qcom,cpu0-l3 {
> +			compatible = "qcom,devfreq-fw-voter";
> +		};
> +
> +		qcom,cpu4-l3 {
> +			compatible = "qcom,devfreq-fw-voter";
> +		};
> +	};
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 6a172d3..8503018 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -113,6 +113,20 @@ config ARM_RK3399_DMC_DEVFREQ
>            It sets the frequency for the memory controller and reads the usage counts
>            from hardware.
>  
> +config ARM_QCOM_DEVFREQ_FW
> +	bool "Qualcomm Technologies Inc. DEVFREQ FW driver"
> +	depends on ARCH_QCOM
> +	select DEVFREQ_GOV_PERFORMANCE
> +	select DEVFREQ_GOV_POWERSAVE
> +	select DEVFREQ_GOV_USERSPACE
> +	default n
> +	help
> +	  The firmware present in some QCOM chipsets offloads the steps
> +	  necessary for changing the frequency of some devices (Eg: L3). This
> +	  driver implements the devfreq interface for this firmware so that
> +	  various governors could be used to scale the frequency of these
> +	  devices.

As I commented, you need to add a description of what kind of firmwar.

> +
>  source "drivers/devfreq/event/Kconfig"
>  
>  endif # PM_DEVFREQ
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 32b8d4d..f1cc8990 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
> +obj-$(CONFIG_ARM_QCOM_DEVFREQ_FW)	+= devfreq_qcom_fw.o
>  
>  # DEVFREQ Event Drivers
>  obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
> diff --git a/drivers/devfreq/devfreq_qcom_fw.c b/drivers/devfreq/devfreq_qcom_fw.c
> new file mode 100644
> index 0000000..3e85f76
> --- /dev/null
> +++ b/drivers/devfreq/devfreq_qcom_fw.c
> @@ -0,0 +1,326 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.

Is it right? or Qualcomm?

> + */
> +
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/list.h>
> +#include <linux/devfreq.h>
> +#include <linux/pm_opp.h>
> +
> +#define INIT_RATE			300000000UL
> +#define XO_RATE				19200000UL
> +#define LUT_MAX_ENTRIES			40U
> +#define LUT_ROW_SIZE			32

I don't know what are the meaning of 'XO', 'LUT'.

> +
> +struct devfreq_qcom_fw {
> +	void __iomem *perf_base;
> +	struct devfreq_dev_profile dp;
> +	struct list_head ;
> +	struct list_head voter;
> +	unsigned int index;
> +};
> +
> +static DEFINE_SPINLOCK(voter_lock);
> +
> +static int devfreq_qcom_fw_target(struct device *dev, unsigned long *freq,
> +				  u32 flags)
> +{
> +	struct devfreq_qcom_fw *d = dev_get_drvdata(dev), *pd, *v;
> +	struct devfreq_dev_profile *p = &d->dp;
> +	unsigned int index;
> +	unsigned long lflags;
> +	struct dev_pm_opp *opp;
> +	void __iomem *perf_base = d->perf_base;
> +
> +	opp = devfreq_recommended_opp(dev, freq, flags);
> +	if (!IS_ERR(opp))
> +		dev_pm_opp_put(opp);
> +	else
> +		return PTR_ERR(opp);
> +
> +	for (index = 0; index < p->max_state; index++)
> +		if (p->freq_table[index] == *freq)
> +			break;
> +
> +	if (index >= p->max_state) {
> +		dev_err(dev, "Unable to find index for freq (%lu)!\n", *freq);
> +		return -EINVAL;
> +	}
> +
> +	d->index = index;
> +
> +	spin_lock_irqsave(&voter_lock, lflags);
> +	/* Voter */
> +	if (!perf_base) {
> +		pd = dev_get_drvdata(dev->parent);
> +		list_for_each_entry(v, &pd->voters, voter)
> +			index = max(index, v->index);
> +		perf_base = pd->perf_base;
> +	}
> +
> +	writel_relaxed(index, perf_base);
> +	spin_unlock_irqrestore(&voter_lock, lflags);
> +
> +	return 0;
> +}
> +
> +static int devfreq_qcom_fw_get_cur_freq(struct device *dev,
> +						 unsigned long *freq)
> +{
> +	struct devfreq_qcom_fw *d = dev_get_drvdata(dev);
> +	struct devfreq_dev_profile *p = &d->dp;
> +	unsigned int index;
> +
> +	/* Voter */
> +	if (!d->perf_base) {
> +		index = d->index;
> +	} else {
> +		index = readl_relaxed(d->perf_base);
> +		index = min(index, p->max_state - 1);
> +	}
> +	*freq = p->freq_table[index];
> +
> +	return 0;
> +}
> +
> +static int devfreq_qcom_populate_opp(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	u32 data, src, lval, i;
> +	unsigned long freq, prev_freq;
> +	struct resource *res;
> +	void __iomem *lut_base;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lut-base");
> +	if (!res) {
> +		dev_err(dev, "Unable to find lut-base!\n");
> +		return -EINVAL;
> +	}
> +
> +	lut_base = devm_ioremap(dev, res->start, resource_size(res));
> +	if (!lut_base) {
> +		dev_err(dev, "Unable to map lut-base\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> +		data = readl_relaxed(lut_base + i * LUT_ROW_SIZE);
> +		src = ((data & GENMASK(31, 30)) >> 30);
> +		lval = (data & GENMASK(7, 0));
> +		freq = src ? XO_RATE * lval : INIT_RATE;

You need to define the global definitions such as XXX_MASK, XXX_SHIFT
for the readability. And add the role of 'lval' and why have to multiply
'lavl' to 'XO_RATE'.

> +
> +		/*
> +		 * Two of the same frequencies with the same core counts means
> +		 * end of table.
> +		 */
> +		if (i > 0 && prev_freq == freq)
> +			break;
> +
> +		dev_pm_opp_add(&pdev->dev, freq, 0);
> +
> +		prev_freq = freq;
> +	}
> +
> +	devm_iounmap(dev, lut_base);
> +
> +	return 0;
> +}
> +
> +static int devfreq_qcom_init_hw(struct platform_device *pdev)
> +{
> +	struct devfreq_qcom_fw *d;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	int ret = 0;
> +	void __iomem *en_base;
> +
> +	d = devm_kzalloc(dev, sizeof(*d), GFP_KERNEL);
> +	if (!d)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "en-base");
> +	if (!res) {
> +		dev_err(dev, "Unable to find en-base!\n");
> +		return -EINVAL;
> +	}
> +
> +	en_base = devm_ioremap(dev, res->start, resource_size(res));
> +	if (!en_base) {
> +		dev_err(dev, "Unable to map en-base\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* FW should be enabled state to proceed */
> +	if (!(readl_relaxed(en_base) & 1)) {
> +		dev_err(dev, "FW not enabled\n");
> +		return -ENODEV;
> +	}
> +
> +	devm_iounmap(dev, en_base);
> +
> +	ret = devfreq_qcom_populate_opp(pdev);
> +	if (ret) {
> +		dev_err(dev, "Failed to read LUT\n");
> +		return ret;
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "perf-base");
> +	if (!res) {
> +		dev_err(dev, "Unable to find perf-base!\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	d->perf_base = devm_ioremap(dev, res->start, resource_size(res));
> +	if (!d->perf_base) {
> +		dev_err(dev, "Unable to map perf-base\n");
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	INIT_LIST_HEAD(&d->voters);
> +	dev_set_drvdata(dev, d);
> +
> +out:
> +	if (ret)
> +		dev_pm_opp_remove_table(dev);
> +	return ret;
> +}
> +
> +static int devfreq_qcom_copy_opp(struct device *src_dev, struct device *dst_dev)
> +{
> +	unsigned long freq;
> +	int i, cnt, ret = 0;
> +	struct dev_pm_opp *opp;
> +
> +	if (!src_dev)
> +		return -ENODEV;
> +
> +	cnt = dev_pm_opp_get_opp_count(src_dev);
> +	if (!cnt)
> +		return -EINVAL;
> +
> +	for (i = 0, freq = 0; i < cnt; i++, freq++) {
> +		opp = dev_pm_opp_find_freq_ceil(src_dev, &freq);
> +		if (IS_ERR(opp)) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +		dev_pm_opp_put(opp);
> +
> +		ret = dev_pm_opp_add(dst_dev, freq, 0);
> +		if (ret)
> +			break;
> +	}
> +
> +	if (ret)
> +		dev_pm_opp_remove_table(dst_dev);
> +	return ret;
> +}
> +
> +static int devfreq_qcom_init_voter(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device *par_dev = dev->parent;
> +	struct devfreq_qcom_fw *d, *pd = dev_get_drvdata(par_dev);
> +	int ret = 0;
> +
> +	d = devm_kzalloc(dev, sizeof(*d), GFP_KERNEL);
> +	if (!d)
> +		return -ENOMEM;
> +
> +	ret = devfreq_qcom_copy_opp(dev->parent, dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to copy parent OPPs\n");
> +		return ret;
> +	}
> +
> +	list_add(&d->voter, &pd->voters);
> +	dev_set_drvdata(dev, d);
> +
> +	return 0;
> +}
> +
> +static int devfreq_qcom_fw_driver_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret = 0;
> +	struct devfreq_qcom_fw *d;
> +	struct devfreq_dev_profile *p;
> +	struct devfreq *df;
> +
> +	if (!of_device_get_match_data(dev))
> +		ret = devfreq_qcom_init_voter(pdev);
> +	else
> +		ret = devfreq_qcom_init_hw(pdev);
> +	if (ret) {
> +		dev_err(dev, "Unable to probe device!\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * If device has voter children, do no register directly with devfreq
> +	 */
> +	if (of_get_available_child_count(dev->of_node)) {
> +		of_platform_populate(dev->of_node, NULL, NULL, dev);
> +		dev_info(dev, "Devfreq QCOM FW parent device initialized.\n");
> +		return 0;
> +	}
> +
> +	d = dev_get_drvdata(dev);
> +	p = &d->dp;
> +	p->polling_ms = 50;
> +	p->target = devfreq_qcom_fw_target;
> +	p->get_cur_freq = devfreq_qcom_fw_get_cur_freq;
> +
> +	df = devm_devfreq_add_device(dev, p, "performance", NULL);
> +	if (IS_ERR(df)) {
> +		dev_err(dev, "Unable to register Devfreq QCOM FW device!\n");
> +		return PTR_ERR(df);
> +	}
> +
> +	dev_info(dev, "Devfreq QCOM FW device registered.\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id match_table[] = {
> +	{ .compatible = "qcom,devfreq-fw", .data = (void *) 1 },
> +	{ .compatible = "qcom,devfreq-fw-voter", .data = (void *) 0 },
> +	{}
> +};
> +
> +static struct platform_driver devfreq_qcom_fw_driver = {
> +	.probe = devfreq_qcom_fw_driver_probe,
> +	.driver = {
> +		.name = "devfreq-qcom-fw",
> +		.of_match_table = match_table,
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +static int __init devfreq_qcom_fw_init(void)
> +{
> +	return platform_driver_register(&devfreq_qcom_fw_driver);
> +}
> +subsys_initcall(devfreq_qcom_fw_init);
> +
> +static void __exit devfreq_qcom_fw_exit(void)
> +{
> +	platform_driver_unregister(&devfreq_qcom_fw_driver);
> +}
> +module_exit(devfreq_qcom_fw_exit);
> +
> +MODULE_DESCRIPTION("Devfreq QCOM FW");
> +MODULE_LICENSE("GPL v2");
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
