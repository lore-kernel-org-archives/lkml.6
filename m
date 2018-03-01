Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030804AbeCANiH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 08:38:07 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53198 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030646AbeCANiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 08:38:05 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180301133802euoutp0136609d7e81350202e6a84e256db052e5~Xz3DdvGru0354103541euoutp01C
X-AuditID: cbfec7f4-713ff700000043e4-8f-5a980239e59c
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"; format="flowed"
Subject: Re: [PATCH v3 05/43] drm/bridge: analogix_dp: Don't power bridge in
 analogix_dp_bind
To: Thierry Escande <thierry.escande@collabora.com>,
        Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, Tomasz Figa <tfiga@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Zain Wang <wzz@rock-chips.com>, Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, Yakir Yang <ykk@rock-chips.com>,
        =?UTF-8?Q?=c3=98rjan_Eide?= <orjan.eide@arm.com>,
        Mark Yao <mark.yao@rock-chips.com>, Haixia Shi <hshi@chromium.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <9a8ee029-79cf-f07e-0a56-f5a0671588dc@samsung.com>
Date: Thu, 01 Mar 2018 14:37:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
In-reply-to: <20180130202913.28724-6-thierry.escande@collabora.com>
Content-transfer-encoding: 8bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjmO+fs7KitTlPzQ8twXUihzLT6uiBGEedHkEEgjmie7KSSM9m8
        ZJGOdFkzp3lvXiiwGTZk5F26eKmmU1emlhJLjcrSVNJKhWk5j4H/nvd5n/d73+fho3DxD4E7
        FRUTxyli2GgJ6UjUvZq37DyAFUl3p1b4o0xLB4au35wQoG59C4n6fk+RyPChFaDSnGtozmjG
        UXrNJwzlDGUTqLephETTw39x1JDXjKFn1W0Eshq7AZpRL5Ioq/8tieabygh04/0GZFHlCoOc
        GUOZATDFqh6C6dVmYkyDtRwwjTqrkKn/MyxghjJMGFNdnsIs6J4TjLamEjAzjz2DnaSOh89z
        0VEJnMI3MMwxsmteg8ea6cullkmhCnwUaYADBekAeL3FTGiAIyWmHwJY97JFwBczAOq1pqWC
        Wla13wnmef2SqKGbtE+L6PVwLvcjYcc4fRB+XVSvDI8CmG8wC+0NZ1oG2z7VC+zYhZ7EoHHh
        hF2E0xMYLCruXxaRtB/UTGhWXg2EA0WmZZ6gt8HxrDLCfoUrfQaO247baQf6KKyqasb4xZth
        S9/oyhFuMFU9uGwH0hYhtL2YFfI+j8Hu+18Aj53hmKlmhd8Ie3MzCB6nQO3sC4wfvg3g07R8
        jG8cgm2mHgG/YS3MqSvE+VhE8OYNMS9hYO2ImuTxEdjZNS/kk3gNYK1FTWYDT92qxHSrEtOt
        MqFbZeIeICqBGxevlEdwyj0xXOIuJStXxsdE7Aq/JH8Mlv5g56LpVwNosp1rBTQFJGtEA1mF
        UrGATVAmyVsBpHCJi6izvkAqFp1nk65wiksyRXw0p2wFHhQhcROd3ZEsFdMRbBx3keNiOcX/
        LkY5uKvAurzoN1fbXafU6hLXkjsaxsMrrV1zIXMwKaW0M9Fb9a2I2cR2PE9WFOwN6XDxx4PS
        p0JOPkHJFaPykZkHd30fbTd8Dh+zTcuMcSNW/Z+9jVsnvih8ImMbx8bDQ71dQ0emO1wWt2SG
        fffef7pufWqtzF0d23bqZ4DXrXf7nJDMnC4hlJGsnw+uULL/AF200HJ/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xa7qWTDOiDH6857DoPXeSyaKp4y2r
        xdllB9ksrnx9z2ax5vYhRou5k2otfmw4xWzRvuURk8Wk+xNYLC7vmsNm8enBf2aLHVMOMFns
        23yYxeLuhrOMFp9b/7FZ9F+9xGbxc9c8Fou262IW5xomszsIe6yZt4bRY3bDRRaPy329TB47
        7i5h9Ng56y67x/ZvD1g97ncfZ/LYvKTe4++s/SwefVtWMXp83iQXwB3FZZOSmpNZllqkb5fA
        lXHmZxdzwSmBirnn3rE3MN7j7WLk4JAQMJE4MTGgi5GLQ0hgCaPE0rPv2bsYOTl4BQQlfky+
        xwJiMwuYSXx5eZgVoug5o8ThbW+ZQBLCAvEShx9tB0uICHxgkpj25R0biMMs8J5JYtuxf4wQ
        LecZJf79nsAI0sImYCjR9baLDWKHncSNGcfB9rEIqEq87p8Htk9UIEZi6seNrCA2p4CzxLp1
        B5gg7pCXOHjlOdRN4hLNrTdZJjAKzEJy7iwk585C0jILScsCRpZVjCKppcW56bnFRnrFibnF
        pXnpesn5uZsYgfG67djPLTsYu94FH2IU4GBU4uF12D8tSog1say4MvcQowQHs5II7+ntQCHe
        lMTKqtSi/Pii0pzU4kOM0hwsSuK85w0qo4QE0hNLUrNTUwtSi2CyTBycUg2MDL9l2Y35vXbs
        2b5BreNEj9iOqtmdRVsmum2+/6S1yqo3Rc83VzGWKej/YRMt9i93c64oy731qc0+kD21TbGm
        oclip0rF9ZCMWYdb3D+XyB9nfXL06NJZk2d/Oy+6pf3JnQN7Pj+fJuytEpnJ39D+7YeBtFql
        konh7KZ7/EE39Vgd+x426u1UYinOSDTUYi4qTgQAynpPv9MCAAA=
X-CMS-MailID: 20180301133801eucas1p1efde80729bc074de6cd3e74840f5b576
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180131083515epcas4p25f260c10b610cdb92743cf2082c43ea9
X-RootMTR: 20180131083515epcas4p25f260c10b610cdb92743cf2082c43ea9
References: <20180130202913.28724-1-thierry.escande@collabora.com>
        <CGME20180131083515epcas4p25f260c10b610cdb92743cf2082c43ea9@epcas4p2.samsung.com>
        <20180130202913.28724-6-thierry.escande@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018-01-30 21:28, Thierry Escande wrote:
> From: zain wang <wzz@rock-chips.com>
>
> The bridge does not need to be powered in analogix_dp_bind(), so
> remove the calls to pm_runtime_get()/phy_power_on()/analogix_dp_init_dp()
> as well as their power-off counterparts.
>
> Cc: Stéphane Marchesin <marcheu@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> [the patch originally just removed the power_on portion, seanpaul removed
> the power off code as well as improved the commit message]
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> ---
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 10 ----------
>   1 file changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index cb5e18d6ba04..1477ea9ba85d 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1382,11 +1382,6 @@ analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
>   
>   	pm_runtime_enable(dev);
>   
> -	pm_runtime_get_sync(dev);
> -	phy_power_on(dp->phy);
> -
> -	analogix_dp_init_dp(dp);
> -
>   	ret = devm_request_threaded_irq(&pdev->dev, dp->irq,
>   					analogix_dp_hardirq,
>   					analogix_dp_irq_thread,
> @@ -1414,15 +1409,10 @@ analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
>   		goto err_disable_pm_runtime;
>   	}
>   
> -	phy_power_off(dp->phy);
> -	pm_runtime_put(dev);
> -
>   	return dp;
>   
>   err_disable_pm_runtime:
>   
> -	phy_power_off(dp->phy);
> -	pm_runtime_put(dev);
>   	pm_runtime_disable(dev);
>   
>   	return ERR_PTR(ret);

Once this change is applied, there is also no need to keep dp->clock
prepared & enabled between bind/unbind.

analogix_dp_set_bridge() and analogix_dp_bridge_disable() properly manage
dp->clock on their own.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
