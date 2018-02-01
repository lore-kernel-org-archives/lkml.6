Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeBAVWR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 16:22:17 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:18193 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbeBAVWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 16:22:08 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180201212206epoutp0358d644ce416b33ad78c7c09ac8f90e72~PUIPNvtyy0845808458epoutp03Y
X-AuditID: b6c32a37-44bff70000001029-1b-5a7384fdda33
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A7384FC.8030400@samsung.com>
Date: Fri, 02 Feb 2018 06:22:04 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert
 "extcon: axp288: Redo charger type detection a couple of seconds after probe()"
In-reply-to: <20180125171010.11169-1-hdegoede@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTmt7td76TVr/nosKjmDSHFrd05c5pKkcQgg0GEMQu96Y9pukf3
        TunhH73IWNLLwBhqTyIqaNmSylJbpX/0pLICa5aV9CIle2hRtust6r/vnPN953x8HIbSvlbp
        mAq3jwhuvoqlY5Vt11IMhp/bRIepvi7R+qGnUWF9cKmJtvZtPkFbx8J3FQuUtuDAKZVtqKOX
        tu0KnUS2kdaZdqWD5JQTvowIeuIu9ZRVuJ257JJlxYuKM+aZOAOXZc1k9W7eRXLZ/AK7YXFF
        VfQkq6/hq6qjLTsviuzcvBzBU+0j+nKP6MtlizjObORMmUaz2Wy0pK/KNmdEKSWkfPzTVso7
        qF/3tvsztQmFdH6kZgBbYPxZA/KjWEaLLyBoa+xWSAMt/obg1nDhX1JwaJdKJrUjONp4AEkD
        DZ4Kow0RpR8xDIVnwfX7lVKbwilwvv1MjMyPIGj+PkxJHA1OhR9Pl0scJU6G5qvtKgnT0Xbn
        mye0hKfgJOgdfTmxPgGvgIsHv8ZIOB57YfNoGy3v18P3SOuENg674MflLxOe1TgLxpr6lbLn
        EA29n5NlnA+Dj9ppGcfBu55QjGQH8HS4fyNXsgm4DkHdlRZKLvYjuPM4opAF6TB42K+QD0+G
        j1/qVbJYAzu2a2WKDV71bVPJeCHcazj7J9B6BM9Gb6v2oJmB/+IK/Isr8F9chxB1EiUSr+hy
        EpHzphtF3iVWu53GUo+rFU28WGrmBRS8UxBGmEHsJE3JDNGhVfE14npXGAFDsfGaDx2CQ6sp
        49dvIIKnWKiuImIYZUTj3kvpEko90Yd1+4o5S5bJMs8cfa4sjmOnaez2fIcWO3kfqSTES4S/
        OgWj1m1CdufxAm9XuMg3ktPfXXSO3DAGqGlL87YsGc/emVj5KgIJvzz7C1erDTvmpwR+mnbO
        jvMFXyzq3l6TPkLv3lc6dXnX6p61x5JuDjw8XXjk+VDf1pbbte8+rtN1xmfnlTQmh4pCY0Hj
        mpB6Y4MlzX9JjB3WpJwIv0+r4Gqdc2qFlWOsUiznuVRKEPnfp/CYkngDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsVy+t9jAd0/LcVRBi3z2C3eHJ/OZHF51xw2
        i9uNK9gsfh46z+TA4rHh0WpWj/f7rrJ59G1ZxejxeZNcAEsUl01Kak5mWWqRvl0CV8b/T83M
        Bc8UKl4e+8LcwLhFqouRk0NCwERiw/s+1i5GLg4hgZ2MEpM7FrOCJHgFBCV+TL7H0sXIwcEs
        IC9x5FI2SJhZQF1i0rxFzBD1Dxglrm5exwZSwyugJfH7TihIDYuAqsTcg7vBxrABhfe/uMEG
        YvMLKEpc/fGYEaRcVCBCovtEJYgpIlAg0fetEmK6gsSve5vAOoUFciV+7/nKBLGpj1Fi7YSf
        7CAJTgFLiZ9z7rNMYBSYheTQWQiHzkJy6AJG5lWMkqkFxbnpucVGBYZ5qeV6xYm5xaV56XrJ
        +bmbGIHhu+2wVt8OxvtL4g8xCnAwKvHwJsgWRwmxJpYVV+YeYpTgYFYS4X2zryhKiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOO/tvGORQgLpiSWp2ampBalFMFkmDk6pBsZ83/JHs2Z2ZOktK7p4
        ZMc5HlfuNLGKVxVZ528tytRynL9K8cvEGK9lP+ZvzqlJ1p3BePSKd8f9X9ElR7ssj03e1MtR
        GOG/M9ZkymW5qRd5lldteLpTICp8cTfbI5b3d/bpLzitPYl1d7w6+9Pit22rtlZ+W/eo9Pr2
        kPVFlS8ytwY6lyvlyE5SYinOSDTUYi4qTgQAin8AylsCAAA=
X-CMS-MailID: 20180201212204epcas1p100da53f7f908c919b49d5ea94332cc2a
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180125171023epcas4p2d0c38963b1155fd6bba3cdad3620fb46
X-RootMTR: 20180125171023epcas4p2d0c38963b1155fd6bba3cdad3620fb46
References: <CGME20180125171023epcas4p2d0c38963b1155fd6bba3cdad3620fb46@epcas4p2.samsung.com>
        <20180125171010.11169-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Why don't modify the extcon-axp288.c after revert it?
Instead, you sent the patch[1]. Are you going to send other patch for extcon-axp288.c?
[1] [PATCH] extcon: int3496: process id-pin first so that we start with the right status


On 2018년 01월 26일 02:10, Hans de Goede wrote:
> Redoing the charger type detection to give the usb-role-switch code time
> to properly set the role-switch is no good for mainline, since the
> usb-role-switch code is not yet in mainline (my bad, sorry).
> 
> Also once we've that code there are better ways to fix this which are
> not prone to racing as doing a retry after 2 seconds is.
> 
> This reverts commit 50082c17bb1455acacd376ae30dff92f2e1addbd.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/extcon/extcon-axp288.c | 32 ++------------------------------
>  1 file changed, 2 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index 9abc99e8c0a5..901eddd3994b 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -1,7 +1,6 @@
>  /*
>   * extcon-axp288.c - X-Power AXP288 PMIC extcon cable detection driver
>   *
> - * Copyright (C) 2016-2017 Hans de Goede <hdegoede@redhat.com>
>   * Copyright (C) 2015 Intel Corporation
>   * Author: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
>   *
> @@ -98,11 +97,9 @@ struct axp288_extcon_info {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	struct regmap_irq_chip_data *regmap_irqc;
> -	struct delayed_work det_work;
>  	int irq[EXTCON_IRQ_END];
>  	struct extcon_dev *edev;
>  	unsigned int previous_cable;
> -	bool first_detect_done;
>  };
>  
>  /* Power up/down reason string array */
> @@ -140,25 +137,6 @@ static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
>  	regmap_write(info->regmap, AXP288_PS_BOOT_REASON_REG, clear_mask);
>  }
>  
> -static void axp288_chrg_detect_complete(struct axp288_extcon_info *info)
> -{
> -	/*
> -	 * We depend on other drivers to do things like mux the data lines,
> -	 * enable/disable vbus based on the id-pin, etc. Sometimes the BIOS has
> -	 * not set these things up correctly resulting in the initial charger
> -	 * cable type detection giving a wrong result and we end up not charging
> -	 * or charging at only 0.5A.
> -	 *
> -	 * So we schedule a second cable type detection after 2 seconds to
> -	 * give the other drivers time to load and do their thing.
> -	 */
> -	if (!info->first_detect_done) {
> -		queue_delayed_work(system_wq, &info->det_work,
> -				   msecs_to_jiffies(2000));
> -		info->first_detect_done = true;
> -	}
> -}
> -
>  static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>  {
>  	int ret, stat, cfg, pwr_stat;
> @@ -223,8 +201,6 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>  		info->previous_cable = cable;
>  	}
>  
> -	axp288_chrg_detect_complete(info);
> -
>  	return 0;
>  
>  dev_det_ret:
> @@ -246,11 +222,8 @@ static irqreturn_t axp288_extcon_isr(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static void axp288_extcon_det_work(struct work_struct *work)
> +static void axp288_extcon_enable(struct axp288_extcon_info *info)
>  {
> -	struct axp288_extcon_info *info =
> -		container_of(work, struct axp288_extcon_info, det_work.work);
> -
>  	regmap_update_bits(info->regmap, AXP288_BC_GLOBAL_REG,
>  						BC_GLOBAL_RUN, 0);
>  	/* Enable the charger detection logic */
> @@ -272,7 +245,6 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>  	info->regmap = axp20x->regmap;
>  	info->regmap_irqc = axp20x->regmap_irqc;
>  	info->previous_cable = EXTCON_NONE;
> -	INIT_DELAYED_WORK(&info->det_work, axp288_extcon_det_work);
>  
>  	platform_set_drvdata(pdev, info);
>  
> @@ -315,7 +287,7 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Start charger cable type detection */
> -	queue_delayed_work(system_wq, &info->det_work, 0);
> +	axp288_extcon_enable(info);
>  
>  	return 0;
>  }
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
