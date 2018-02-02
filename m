Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeBBAbf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 19:31:35 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:38322 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeBBAb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 19:31:29 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180202003127epoutp018a74c0b50cb55196e31f080d21653d0b~PWtj3FFfN1705617056epoutp01N
X-AuditID: b6c32a45-3ebff70000001023-ba-5a73b15ec374
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5A73B15E.3050508@samsung.com>
Date: Fri, 02 Feb 2018 09:31:26 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert
 "extcon: axp288: Redo charger type detection a couple of seconds after probe()"
In-reply-to: <fde91a16-c9bc-236a-976c-d9011e66e8d9@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmuW7cxuIog18PLC3eHJ/OZHF51xw2
        i9uNK9gsfh46z+TA4rHh0WpWj/f7rrJ59G1ZxejxeZNcAEtUqk1GamJKapFCal5yfkpmXrqt
        kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0EolhbLEnFKgUEBicbGSvp1NUX5pSapC
        Rn5xia1StKGhkZ6hgbmekZGRnolxrJWRKVBJQmrGgxuTGAtWqFdMOtfD1MC4U66LkZNDQsBE
        4snPTexdjFwcQgI7GCWObXvEBOF8Z5S4uv08I0zV0z0LmSESG4ASfXdZQRK8AoISPybfY+li
        5OBgFpCXOHIpGyTMLKAp8eLLJBaI+nuMEi8bOqDqtSSefpsMZrMIqErMvPaUGcRmA4rvf3GD
        DcTmF1CUuPrjMdhiUYEIiZ3zv7GD2CICBRKNP7axQSxQkPh1bxPYHGGBXInfe74ygdzAKWAn
        MfOiL8heCYE1bBJnO1+zQTzgInFv0xUoW1ji1fEt7BC2tMSzVRsZIRraGSXa985jhnCmMEqc
        u36PCaLKWOLZwi4miM18Eh2H/7KDbJMQ4JXoaBOCKPGQeHK7hRXCdpS4MHkj2ANCAvcZJR5N
        spnAKDcLKbxmIcJrFlJ4LWBkXsUollpQnJueWmxUYKhXnJhbXJqXrpecn7uJEZzItFx3MM44
        53OIUYCDUYmHl0O6OEqINbGsuDL3EKMEB7OSCO+VbqAQb0piZVVqUX58UWlOavEhRlNgcE9k
        lhJNzgcm2bySeEMTSwMTMzMjczMLYAIT520LcIkSEkhPLEnNTk0tSC2C6WPi4JRqYJzu+Dl/
        /oXP385fXvd+d8MUo2SD23bZNU151ifnzDG805nEd+7XiqZ4rWPaYlcLy2ekLH39Ua898Zn0
        gvYEZoa9jncFfoU/nXy2uUB62pz7t+6caVzwjdv7uYn75YDKhTm8zNZesTuY9wu311/Ltin6
        cuIQt/hCE8mQo7Uez15pXBHd/OpZ+l4lluKMREMt5qLiRAANStPMegMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsVy+t9jQd24jcVRBhNOqVu8OT6dyeLyrjls
        FrcbV7BZ/Dx0nsmBxWPDo9WsHu/3XWXz6NuyitHj8ya5AJYoLpuU1JzMstQifbsErowHNyYx
        FqxQr5h0roepgXGnXBcjJ4eEgInE0z0LmbsYuTiEBNYxSuydsJoFJMErICjxY/I9IJuDg1lA
        XuLIpWwIU11iypRciPIHjBJ3N31mhSjXknj6bTKYzSKgKjHz2lNmEJsNKL7/xQ02EJtfQFHi
        6o/HjCBzRAUiJLpPVIKYIgIFEn3fKkEqmAUUJH7d2wQ2RVggV+L3nq9MILaQwENGib/H2EHK
        OQXsJGZe9J3AKDALyZmzEM6chXDmAkbmVYySqQXFuem5xUYFRnmp5XrFibnFpXnpesn5uZsY
        gYG77bBW/w7Gx0viDzEKcDAq8fBySBdHCbEmlhVX5h5ilOBgVhLh/boBKMSbklhZlVqUH19U
        mpNafIhRmoNFSZyXP/9YpJBAemJJanZqakFqEUyWiYNTqoHx5NkL/R8aJ9XovrWaemWmwbQJ
        a3omBM1lDhbOnMa44b7xTo6NbZM6+YTSf9cHe3FtnsuSb/38/P4TfazLdYI1GAtmLflydWPY
        K6Pd/S185yVLPzX2pSzWervh0KQP9ae/GDK1+y/0ntewJswrua5dw/DDzQWrZjg7Vj0/OuGu
        wS33ikk7jHYGK7EUZyQaajEXFScCAF9zjuNYAgAA
X-CMS-MailID: 20180202003126epcas2p4f2374c29b99b4af7e2a34087ebf268f3
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180125171023epcas4p2d0c38963b1155fd6bba3cdad3620fb46
X-RootMTR: 20180125171023epcas4p2d0c38963b1155fd6bba3cdad3620fb46
References: <CGME20180125171023epcas4p2d0c38963b1155fd6bba3cdad3620fb46@epcas4p2.samsung.com>
        <20180125171010.11169-1-hdegoede@redhat.com> <5A7384FC.8030400@samsung.com>
        <fde91a16-c9bc-236a-976c-d9011e66e8d9@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 02월 02일 08:48, Hans de Goede wrote:
> Hi,
> 
> On 01-02-18 22:22, Chanwoo Choi wrote:
>> Hi Hans,
>>
>> Why don't modify the extcon-axp288.c after revert it?
> 
> Fixing the axp288 extcon code properly requires usb-role-switch support
> which is not yet in the mainline kernel, I will submit the fix for it
> once usb-role-switch support is in the mainline.
> 
>> Instead, you sent the patch[1].
> 
> Yes this is a preparation patch for the pending extcon-axp288 fix.

OK. Applied it.

Thanks,
Chanwoo Choi

> 
> Regards,
> 
> Hans
> 
> 
> 
>  Are you going to send other patch for extcon-axp288.c?
>> [1] [PATCH] extcon: int3496: process id-pin first so that we start with the right status
>>
>>
>> On 2018년 01월 26일 02:10, Hans de Goede wrote:
>>> Redoing the charger type detection to give the usb-role-switch code time
>>> to properly set the role-switch is no good for mainline, since the
>>> usb-role-switch code is not yet in mainline (my bad, sorry).
>>>
>>> Also once we've that code there are better ways to fix this which are
>>> not prone to racing as doing a retry after 2 seconds is.
>>>
>>> This reverts commit 50082c17bb1455acacd376ae30dff92f2e1addbd.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>   drivers/extcon/extcon-axp288.c | 32 ++------------------------------
>>>   1 file changed, 2 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
>>> index 9abc99e8c0a5..901eddd3994b 100644
>>> --- a/drivers/extcon/extcon-axp288.c
>>> +++ b/drivers/extcon/extcon-axp288.c
>>> @@ -1,7 +1,6 @@
>>>   /*
>>>    * extcon-axp288.c - X-Power AXP288 PMIC extcon cable detection driver
>>>    *
>>> - * Copyright (C) 2016-2017 Hans de Goede <hdegoede@redhat.com>
>>>    * Copyright (C) 2015 Intel Corporation
>>>    * Author: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
>>>    *
>>> @@ -98,11 +97,9 @@ struct axp288_extcon_info {
>>>       struct device *dev;
>>>       struct regmap *regmap;
>>>       struct regmap_irq_chip_data *regmap_irqc;
>>> -    struct delayed_work det_work;
>>>       int irq[EXTCON_IRQ_END];
>>>       struct extcon_dev *edev;
>>>       unsigned int previous_cable;
>>> -    bool first_detect_done;
>>>   };
>>>     /* Power up/down reason string array */
>>> @@ -140,25 +137,6 @@ static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
>>>       regmap_write(info->regmap, AXP288_PS_BOOT_REASON_REG, clear_mask);
>>>   }
>>>   -static void axp288_chrg_detect_complete(struct axp288_extcon_info *info)
>>> -{
>>> -    /*
>>> -     * We depend on other drivers to do things like mux the data lines,
>>> -     * enable/disable vbus based on the id-pin, etc. Sometimes the BIOS has
>>> -     * not set these things up correctly resulting in the initial charger
>>> -     * cable type detection giving a wrong result and we end up not charging
>>> -     * or charging at only 0.5A.
>>> -     *
>>> -     * So we schedule a second cable type detection after 2 seconds to
>>> -     * give the other drivers time to load and do their thing.
>>> -     */
>>> -    if (!info->first_detect_done) {
>>> -        queue_delayed_work(system_wq, &info->det_work,
>>> -                   msecs_to_jiffies(2000));
>>> -        info->first_detect_done = true;
>>> -    }
>>> -}
>>> -
>>>   static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>>>   {
>>>       int ret, stat, cfg, pwr_stat;
>>> @@ -223,8 +201,6 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>>>           info->previous_cable = cable;
>>>       }
>>>   -    axp288_chrg_detect_complete(info);
>>> -
>>>       return 0;
>>>     dev_det_ret:
>>> @@ -246,11 +222,8 @@ static irqreturn_t axp288_extcon_isr(int irq, void *data)
>>>       return IRQ_HANDLED;
>>>   }
>>>   -static void axp288_extcon_det_work(struct work_struct *work)
>>> +static void axp288_extcon_enable(struct axp288_extcon_info *info)
>>>   {
>>> -    struct axp288_extcon_info *info =
>>> -        container_of(work, struct axp288_extcon_info, det_work.work);
>>> -
>>>       regmap_update_bits(info->regmap, AXP288_BC_GLOBAL_REG,
>>>                           BC_GLOBAL_RUN, 0);
>>>       /* Enable the charger detection logic */
>>> @@ -272,7 +245,6 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>>>       info->regmap = axp20x->regmap;
>>>       info->regmap_irqc = axp20x->regmap_irqc;
>>>       info->previous_cable = EXTCON_NONE;
>>> -    INIT_DELAYED_WORK(&info->det_work, axp288_extcon_det_work);
>>>         platform_set_drvdata(pdev, info);
>>>   @@ -315,7 +287,7 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>>>       }
>>>         /* Start charger cable type detection */
>>> -    queue_delayed_work(system_wq, &info->det_work, 0);
>>> +    axp288_extcon_enable(info);
>>>         return 0;
>>>   }
>>>
>>
> 
> 
> 
