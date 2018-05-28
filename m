Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753531AbeE1GxV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 02:53:21 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53095 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752949AbeE1GxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 02:53:15 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180528065313euoutp01279b3d9e6499e09e0c2d665d5bb44eb0~yvGuBma_Z2793327933euoutp01C
X-AuditID: cbfec7f5-b45ff700000028a9-a1-5b0ba7579cb6
Subject: Re: [PATCH v2 7/8] iommu: Remove IOMMU_OF_DECLARE
To: Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux-foundation.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Mon, 28 May 2018 08:53:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180524175024.19874-8-robh@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se1BMURzH5+y59+5tWXNt6OfNGsZj8jbOeA3jMfcPjHczZWJxVbTFbkUY
        mimPduQVqZU2YhZFVJJQWmprVpaW5DVi17PyTDRl1+5ej/77fH/n+z2/8505LFacYXqxYRFR
        giZCFa5kZFRhRavVP8DYKWi0qbUvqXzgRMRS+pEibR9eYnLkpYMhhtt3aZLW6GJIfFYuQ1yv
        GmiSWTqZJB67KCX77Q2YvM63S4jV6paH240SkmevpcnB0mopsRWnM+RrvQuTVGuJhNyx1NDk
        7YmfmLiuF0lJ2WcHTcznA8j7L5XU9J68oyxDwudk5CD+qv65lM87l8jwz2qvM3zp8Rwpn39q
        B//Uacd8cp0R8QUPd1P8ldoMzOdbtvLf8votkAfKpqwRwsNiBM2oaStloUl7a9GG6imbbTtb
        mDj0eqwO+bDAjYdntrO0hxXcGQS5KUE6JHNzM4LyndUSUXxD0FLUzPxNnKx5gcQDI4L6NCcW
        xScEJ8pcEo/Ll5sE+psOb7wb9xBDirGO8gjMVWDI/JzgdTHcGNA16bz3UtxgOFBvoDzcnVsO
        hbZ6L8u5rlCV5vCyDzcBTje0eRlz/eFKUzoW2Q+eOAzebcA5WKhKTJWK4Ri4fVMMAzcLTI9T
        /5TwhQ/mAqnIfcCSvNftYd28CZyV68RxAoLzLaNEngy3zPdpjwVzwyC3+M94BiRcKqbFZBeo
        a+oqvqYLHCo8isWxHPbsUojuIaA3X/i3s+xeDT6AlPoOHfUdeuk79NL/35uJqHPIT4jWqkME
        7bgIYdNIrUqtjY4IGbk6Up2H3P/X4jR/L0Il7atMiGORsrM8rk0WpKBVMdpYtQkBi5Xd5DJ/
        90i+RhW7RdBErtBEhwtaE+rNUko/efDQ7YEKLkQVJawXhA2C5u+phPXpFYceRSUtXrIo6deI
        5vnNIe09Gv0N77IzFs5bdnmrHdYXpWX7DlhK93FmxS9olUcGJpc8WDJ4rXVRenwP7Lp1TD91
        mt/Rt8evVcluXByaciH5x8rANzOvmsvfGGYYY9UTG6k9SydujKOnX563btDo2bZfirtnBwbf
        wAnddZZ9c+ccGpZ1acQ2JaUNVY0ZjjVa1W8QcP5huwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHObuP3VmL21I6WmRdiKJyeufrmKZF/nGhPxKCBK3WdBcnbU7u
        nZYZJD1xGam9dNrUsgZlVE7KSp1KZGE20Frlg7JNevigB0aRuTZX4H+f8/t+P+dw4EdhinYi
        jMrNM/FCnkbPkEF472zPSMRO24LMqGOVFHryYhagXscUjn5/HsXQ+VEPieoePSdQ9YSXREev
        3CKR9/04geodiai05rYUnXGPY2jM7pYgp9N3PDdjk6Bmt4tAFY4+KRp4UEuib++8GKpydkjQ
        s95+An1o+Ikhb1urFHV98RCo52Y6+vT1Cb45lPN0WSVck7UJcPctI1Ku+XopyQ272kjOcalJ
        ytkbD3NDs26MO/vaBriWlydx7p7LinH23mLue/OKNHmGMkkwFpj4lTqjaNrEZLJIpWQTkFIV
        k6Bko+N3b1TFMpHJSVpen1vIC5HJe5W602UukN+XdGDg+A+yBIypzEBGQToGXu5/C8wgiFLQ
        VwE84Z7GAsFy+PRCCRHgJXDGZSYDpUkAvSOP5kpL6I3Q0umR+INg+hUGL3Q6JP4Aox9jsGZm
        e8CwA3jkZ+VcQNIsNE/6r5JRcjoZTjT2S/2M06th+bs63M8h9C54486ANNBZDJ9We+bmMjoW
        Xh3/jQceiINW+ygW4HB4b7L2Hy+Fg546STlQWObplnmKZZ5imafUA/w6COYLREOOQVQpRY1B
        LMjLUWYbDc3Atzp3H/9qaQXmqR3dgKYAs1C+9ldQpoLQFIpFhm4AKYwJlgdF+EZyraboIC8Y
        1UKBnhe7QazvcxVYWEi20beIeSY1G8vGowQ2Pjo+Og4xS+XOqKIMBZ2jMfH7eD6fF/57EkoW
        VgKYhyWsIp+o/0GNTuaeWp+m1uanVn3Kqnou9GxYVWa3ZaU3BE+MtLZ3aPdvSvFEHSgOFRut
        06rIwmNb3bpkWWJquH2LDcnjVqeZEqz6maGU0HU1hz8KOsvg6zWHADOsarmi++PdM9azbNmi
        6IvD8kE1uJw1bd1ybeWbbdlvar8wuKjTsOswQdT8BU2VaHpQAwAA
Message-Id: <20180528065310eucas1p28dd65b510c09cda3c5f0f9bae023ab0e~yvGrLziVE1627616276eucas1p2T@eucas1p2.samsung.com>
X-CMS-MailID: 20180528065310eucas1p28dd65b510c09cda3c5f0f9bae023ab0e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180524175050epcas5p1ea3893bb828bcea8eeca35a26ed59736
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180524175050epcas5p1ea3893bb828bcea8eeca35a26ed59736
References: <20180524175024.19874-1-robh@kernel.org>
        <CGME20180524175050epcas5p1ea3893bb828bcea8eeca35a26ed59736@epcas5p1.samsung.com>
        <20180524175024.19874-8-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2018-05-24 19:50, Rob Herring wrote:
> Now that we use the driver core to stop deferred probe for missing
> drivers, IOMMU_OF_DECLARE can be removed.
>
> This is slightly less optimal than having a list of built-in drivers in
> that we'll now defer probe twice before giving up. This shouldn't have a
> significant impact on boot times as past discussions about deferred
> probe have given no evidence of deferred probe having a substantial
> impact.
>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

For Exynos IOMMU:

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/iommu/arm-smmu-v3.c    |  2 --
>   drivers/iommu/arm-smmu.c       |  7 -------
>   drivers/iommu/exynos-iommu.c   |  2 --
>   drivers/iommu/ipmmu-vmsa.c     |  3 ---
>   drivers/iommu/msm_iommu.c      |  2 --
>   drivers/iommu/of_iommu.c       | 19 +------------------
>   drivers/iommu/qcom_iommu.c     |  2 --
>   drivers/iommu/rockchip-iommu.c |  2 --
>   include/linux/of_iommu.h       |  4 ----
>   9 files changed, 1 insertion(+), 42 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 1d647104bccc..22bdabd3d8e0 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2915,8 +2915,6 @@ static struct platform_driver arm_smmu_driver = {
>   };
>   module_platform_driver(arm_smmu_driver);
>   
> -IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3");
> -
>   MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
>   MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 69e7c60792a8..9dd7cbaa3b0c 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2211,13 +2211,6 @@ static struct platform_driver arm_smmu_driver = {
>   };
>   module_platform_driver(arm_smmu_driver);
>   
> -IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1");
> -IOMMU_OF_DECLARE(arm_smmuv2, "arm,smmu-v2");
> -IOMMU_OF_DECLARE(arm_mmu400, "arm,mmu-400");
> -IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401");
> -IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500");
> -IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2");
> -
>   MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
>   MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 85879cfec52f..b128cb4372d3 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1390,5 +1390,3 @@ static int __init exynos_iommu_init(void)
>   	return ret;
>   }
>   core_initcall(exynos_iommu_init);
> -
> -IOMMU_OF_DECLARE(exynos_iommu_of, "samsung,exynos-sysmmu");
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 40ae6e87cb88..f026aa16d5f1 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -1108,9 +1108,6 @@ static void __exit ipmmu_exit(void)
>   subsys_initcall(ipmmu_init);
>   module_exit(ipmmu_exit);
>   
> -IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa");
> -IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795");
> -
>   MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
>   MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 0d3350463a3f..27377742600d 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -877,7 +877,5 @@ static void __exit msm_iommu_driver_exit(void)
>   subsys_initcall(msm_iommu_driver_init);
>   module_exit(msm_iommu_driver_exit);
>   
> -IOMMU_OF_DECLARE(msm_iommu_of, "qcom,apq8064-iommu");
> -
>   MODULE_LICENSE("GPL v2");
>   MODULE_AUTHOR("Stepan Moskovchenko <stepanm@codeaurora.org>");
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 2aac8387717c..1904ccf9fc4e 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -27,9 +27,6 @@
>   
>   #define NO_IOMMU	1
>   
> -static const struct of_device_id __iommu_of_table_sentinel
> -	__used __section(__iommu_of_table_end);
> -
>   /**
>    * of_get_dma_window - Parse *dma-window property and returns 0 if found.
>    *
> @@ -98,19 +95,6 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
>   }
>   EXPORT_SYMBOL_GPL(of_get_dma_window);
>   
> -static bool of_iommu_driver_present(struct device_node *np)
> -{
> -	/*
> -	 * If the IOMMU still isn't ready by the time we reach init, assume
> -	 * it never will be. We don't want to defer indefinitely, nor attempt
> -	 * to dereference __iommu_of_table after it's been freed.
> -	 */
> -	if (system_state >= SYSTEM_RUNNING)
> -		return false;
> -
> -	return of_match_node(&__iommu_of_table, np);
> -}
> -
>   static int of_iommu_xlate(struct device *dev,
>   			  struct of_phandle_args *iommu_spec)
>   {
> @@ -120,8 +104,7 @@ static int of_iommu_xlate(struct device *dev,
>   
>   	ops = iommu_ops_from_fwnode(fwnode);
>   	if ((ops && !ops->of_xlate) ||
> -	    !of_device_is_available(iommu_spec->np) ||
> -	    (!ops && !of_iommu_driver_present(iommu_spec->np)))
> +	    !of_device_is_available(iommu_spec->np))
>   		return NO_IOMMU;
>   
>   	err = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index 65b9c99707f8..fa0f6c39a144 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -947,7 +947,5 @@ static void __exit qcom_iommu_exit(void)
>   module_init(qcom_iommu_init);
>   module_exit(qcom_iommu_exit);
>   
> -IOMMU_OF_DECLARE(qcom_iommu_dev, "qcom,msm-iommu-v1");
> -
>   MODULE_DESCRIPTION("IOMMU API for QCOM IOMMU v1 implementations");
>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 0468acfa131f..90d37f29c24c 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1284,8 +1284,6 @@ static int __init rk_iommu_init(void)
>   }
>   subsys_initcall(rk_iommu_init);
>   
> -IOMMU_OF_DECLARE(rk_iommu_of, "rockchip,iommu");
> -
>   MODULE_DESCRIPTION("IOMMU API for Rockchip");
>   MODULE_AUTHOR("Simon Xue <xxm@rock-chips.com> and Daniel Kurtz <djkurtz@chromium.org>");
>   MODULE_ALIAS("platform:rockchip-iommu");
> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> index 4fa654e4b5a9..f3d40dd7bb66 100644
> --- a/include/linux/of_iommu.h
> +++ b/include/linux/of_iommu.h
> @@ -32,8 +32,4 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
>   
>   #endif	/* CONFIG_OF_IOMMU */
>   
> -extern struct of_device_id __iommu_of_table;
> -
> -#define IOMMU_OF_DECLARE(name, compat)	OF_DECLARE_1(iommu, name, compat, NULL)
> -
>   #endif /* __OF_IOMMU_H */

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
