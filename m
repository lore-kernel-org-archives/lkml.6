Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeDXEIr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 00:08:47 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:53275 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeDXEIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 00:08:43 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180424040840epoutp045acd91de5fbe92d417bf1404be1f69ec~oQ7V4-hZG1512615126epoutp04O
X-AuditID: b6c32a46-145ff70000001024-d4-5adeadc63950
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5ADEADC5.8000201@samsung.com>
Date: Tue, 24 Apr 2018 13:08:37 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, heiko@sntech.de, linux-pm@vger.kernel.org,
        dbasehore@chromium.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Lin Huang <hl@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 6/6] devfreq: rk3399_dmc: register devfreq notification
 to dmc driver.
In-reply-to: <20180419104019.24406-7-enric.balletbo@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGJsWRmVeSWpSXmKPExsWy7bCmqe6xtfeiDK595rZ4tXkPm8X8I+dY
        LdbcPsRoMXf2JEaL/49es1r82HCK2eL7jbNsFpvP9bBanG16w26x6fE1VovLu+awWXzuPcJo
        8enBf2aL240r2Cxa9x5htzi+Ntzi1sSbTA6CHrMbLrJ47Li7hNFj4lldj02rOtk87lzbw+ax
        eUm9x99Z+1k8+rasYvTYfm0es8fnTXIBXFGpNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaG
        uoaWFuZKCnmJuam2Si4+AbpumTlA7ygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJWiDQ2N
        9AwNzPWMjIC0cayVkSlQSUJqxtTXd5kLDmhWrHyzhbWB8Z9iFyMnh4SAicSRuxeYuxi5OIQE
        djBKLG98xwLhfGeUWL9gPRNMVee8u0wQiQ2MEn3NO9hAErwCghI/Jt8D6uDgYBaQlzhyKRsk
        zCygKbF193p2iPq7jBIn32xlh6jXklixah4LiM0ioCpx4eoiVhCbDSi+/8UNsJn8AooSV388
        ZgSxRQUiJHbO/wY2SESghVHi3d6/YFcwC6xllli74yvYJGGBGInJv64wg9icAk4Sc5Y+ZYM4
        +xC7RMfVQAjbReL2ig5WCFtY4tXxLewQtrTEs1UbGUGGSgi0M0q0753HDOFMYZQ4d/0eNACM
        JZ4t7GKCeI5PouPwX3aQnyUEeCU62oQgSjwkZiz5xAxhO0qs2LufDeL/s4wSO9c8ZpnAKDcL
        KchmIYJsFlKQLWBkXsUollpQnJueWmxUYKRXnJhbXJqXrpecn7uJEZyGtdx2MC4553OIUYCD
        UYmHd8HPu1FCrIllxZW5hxglOJiVRHj3yt2LEuJNSaysSi3Kjy8qzUktPsRoCgzxicxSosn5
        wByRVxJvaGpkbGxsYWpuaWxgqSTO2+B7JkpIID2xJDU7NbUgtQimj4mDU6qBkTeca8L0d0en
        v2vmXryN/dqpXf80zrOqyVvEijYIb0jO/qH//iO7xGmN8N7JEXOj3tktbH1sdWEpW01Qxe6c
        t/5PAqq/ili6LBQrazH1MXF9cUln442DZu9iOuJ1t5ldMS2cO2OJNJ/8Qe4CFQ0zg5CSRV1z
        Uq8nXX04z/Ddm41HxCbfmvHUQomlOCPRUIu5qDgRAOofAyrZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t9jQd2ja+9FGbRdVbd4tXkPm8X8I+dY
        LdbcPsRoMXf2JEaL/49es1r82HCK2eL7jbNsFpvP9bBanG16w26x6fE1VovLu+awWXzuPcJo
        8enBf2aL240r2Cxa9x5htzi+Ntzi1sSbTA6CHrMbLrJ47Li7hNFj4lldj02rOtk87lzbw+ax
        eUm9x99Z+1k8+rasYvTYfm0es8fnTXIBXFFcNimpOZllqUX6dglcGVNf32UuOKBZsfLNFtYG
        xn+KXYycHBICJhKd8+4ydTFycQgJrGOUWP5vAjtIgldAUOLH5HssXYwcHMwC8hJHLmWDhJkF
        1CUmzVvEDFF/n1Hie+MXRoh6LYkVq+axgNgsAqoSF64uYgWx2YDi+1/cYAOx+QUUJa7+eMwI
        MlNUIEKi+0QlSFhEoIVR4tw/F4j5a5kldrxPB7GFBWIkTv64ygqx6yyjxNE1v5hBEpwCThJz
        lj5lm8AoMAvJqbMQTp2F5NQFjMyrGCVTC4pz03OLjQqM8lLL9YoTc4tL89L1kvNzNzECY2/b
        Ya3+HYyPl8QfYhTgYFTi4V3w826UEGtiWXFl7iFGCQ5mJRHevXL3ooR4UxIrq1KL8uOLSnNS
        iw8xSnOwKInz8ucfixQSSE8sSc1OTS1ILYLJMnFwSjUwsv1pmOZyeMOyJfMOrY7akHggp+O0
        0kUF/urW0nO+BcvTs17ufb/m98X8SPWgH/O6Jx8LPfN26Y/QyX/UVVcmVuz+ICeyhOnMp81h
        f3iaGk/43AhXXZnybcehS1cS7xkZbUg0L1g7t/Ke8pln59NL7G4dsrDYL/eKx+VTGdcMrR0L
        xGdpPribvE2JpTgj0VCLuag4EQBpxeoNuQIAAA==
X-CMS-MailID: 20180424040837epcas2p2a71c12f5346b3af23bc736bec388731e
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180419104130epcas2p4c40667908eb5aecbc80d7c19e4710065
X-RootMTR: 20180419104130epcas2p4c40667908eb5aecbc80d7c19e4710065
References: <20180419104019.24406-1-enric.balletbo@collabora.com>
        <CGME20180419104130epcas2p4c40667908eb5aecbc80d7c19e4710065@epcas2p4.samsung.com>
        <20180419104019.24406-7-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 04월 19일 19:40, Enric Balletbo i Serra wrote:
> From: Lin Huang <hl@rock-chips.com>
> 
> Because dmc may also access the PMU_BUS_IDLE_REQ register, we need to
> ensure that the pd driver and the dmc driver will not access at this
> register at the same time.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/devfreq/rk3399_dmc.c      | 47 +----------------------
>  drivers/soc/rockchip/pm_domains.c | 31 +++++++++++++++
>  include/soc/rockchip/rk3399_dmc.h | 63 +++++++++++++++++++++++++++++++
>  3 files changed, 96 insertions(+), 45 deletions(-)
>  create mode 100644 include/soc/rockchip/rk3399_dmc.h
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index 5bfca028eaaf..a1f320634d69 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -27,51 +27,7 @@
>  #include <linux/suspend.h>
>  
>  #include <soc/rockchip/rockchip_sip.h>
> -
> -struct dram_timing {
> -	unsigned int ddr3_speed_bin;
> -	unsigned int pd_idle;
> -	unsigned int sr_idle;
> -	unsigned int sr_mc_gate_idle;
> -	unsigned int srpd_lite_idle;
> -	unsigned int standby_idle;
> -	unsigned int auto_pd_dis_freq;
> -	unsigned int dram_dll_dis_freq;
> -	unsigned int phy_dll_dis_freq;
> -	unsigned int ddr3_odt_dis_freq;
> -	unsigned int ddr3_drv;
> -	unsigned int ddr3_odt;
> -	unsigned int phy_ddr3_ca_drv;
> -	unsigned int phy_ddr3_dq_drv;
> -	unsigned int phy_ddr3_odt;
> -	unsigned int lpddr3_odt_dis_freq;
> -	unsigned int lpddr3_drv;
> -	unsigned int lpddr3_odt;
> -	unsigned int phy_lpddr3_ca_drv;
> -	unsigned int phy_lpddr3_dq_drv;
> -	unsigned int phy_lpddr3_odt;
> -	unsigned int lpddr4_odt_dis_freq;
> -	unsigned int lpddr4_drv;
> -	unsigned int lpddr4_dq_odt;
> -	unsigned int lpddr4_ca_odt;
> -	unsigned int phy_lpddr4_ca_drv;
> -	unsigned int phy_lpddr4_ck_cs_drv;
> -	unsigned int phy_lpddr4_dq_drv;
> -	unsigned int phy_lpddr4_odt;
> -};
> -
> -struct rk3399_dmcfreq {
> -	struct device *dev;
> -	struct devfreq *devfreq;
> -	struct devfreq_simple_ondemand_data ondemand_data;
> -	struct clk *dmc_clk;
> -	struct devfreq_event_dev *edev;
> -	struct mutex lock;
> -	struct dram_timing timing;
> -	struct regulator *vdd_center;
> -	unsigned long rate, target_rate;
> -	unsigned long volt, target_volt;
> -};
> +#include <soc/rockchip/rk3399_dmc.h>
>  
>  static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>  				 u32 flags)
> @@ -394,6 +350,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  
>  	data->dev = dev;
>  	platform_set_drvdata(pdev, data);
> +	pd_register_notify_to_dmc(data->devfreq);
>  
>  	return 0;
>  }
> diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
> index 53efc386b1ad..7acc836e7eb7 100644
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
> @@ -601,6 +606,30 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
>  	return error;
>  }
>  
> +static int dmc_notify(struct notifier_block *nb, unsigned long event,
> +		      void *data)
> +{
> +	if (event == DEVFREQ_PRECHANGE)
> +		mutex_lock(&dmc_pmu->mutex);
> +	else if (event == DEVFREQ_POSTCHANGE)
> +		mutex_unlock(&dmc_pmu->mutex);
> +
> +	return NOTIFY_OK;
> +}
> +
> +int pd_register_notify_to_dmc(struct devfreq *devfreq)
> +{
> +	if (!dmc_pmu)
> +		return -EPROBE_DEFER;
> +
> +	dmc_pmu->devfreq = devfreq;
> +	dmc_pmu->dmc_nb.notifier_call = dmc_notify;
> +	devfreq_register_notifier(dmc_pmu->devfreq, &dmc_pmu->dmc_nb,
> +				  DEVFREQ_TRANSITION_NOTIFIER);
> +	return 0;
> +}
> +EXPORT_SYMBOL(pd_register_notify_to_dmc);

I think that it is not proper to define the nonstandard function
for only specific device driver. Maybe, It makes the code more complicated.
Between linux kernel frameworks, we have to use the defined function
by linux kernel frameworks.

If drivers/soc/rockchip/pm_domains.c is able to get the devfreq instance
through devicetree, the exported function is not necessary. Sorry for that
I'm not sure the alternative.

[snip]

> diff --git a/include/soc/rockchip/rk3399_dmc.h b/include/soc/rockchip/rk3399_dmc.h
> new file mode 100644
> index 000000000000..7ccdfff1a154
> --- /dev/null
> +++ b/include/soc/rockchip/rk3399_dmc.h
> @@ -0,0 +1,63 @@

[snip]

> +
> +int pd_register_notify_to_dmc(struct devfreq *devfreq);
> +
> +#endif
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
