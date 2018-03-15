Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbeCOLsw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:48:52 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:32393 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeCOLst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:48:49 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180315114847epoutp01923b1359bbf8552b47f7841d6107029e~cFZqIl32i2781027810epoutp01M
X-AuditID: b6c32a46-3a9ff70000001029-d4-5aaa5d9e6026
Subject: Re: [PATCH 1/6] mmc: dw_mmc: remove the deprecated
 "clock-freq-min-max" property
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Joachim Eastwood <manabian@gmail.com>, dinguyen@kernel.org,
        Will Deacon <will.deacon@arm.com>, Wei Xu <xuwei5@hisilicon.com>
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <32ad854d-f464-7aab-c765-fe49bdacd8e3@samsung.com>
Date: Thu, 15 Mar 2018 20:48:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
        Thunderbird/52.5.0
MIME-version: 1.0
In-reply-to: <CAPDyKFp2TCBfBvA53+UTJYYRrn2x_Szwb92x_2ahHhOKWdvntw@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmme682FVRBntfmFvMP3KO1eLo+d1M
        Fpd3zWGzOPK/n9Fi9/VzjBZLr19ksmjde4Td4vjacIuXH0+wWDw5OoXZgctjzbw1jB47Z91l
        93g8dyO7x6ZVnWwed67tYfP4vEkugC0q1SYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ
        0sJcSSEvMTfVVsnFJ0DXLTMH6DIlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1StKGhkZ6h
        gbmekZGRnolxrJWRKVBJQmrGkiuzmAveSVW8b97E2MDYINLFyMkhIWAisX3fQ/YuRi4OIYEd
        jBLtx88zQTjfGSXOvd/ADFO1+coHqKoNjBLfN32EqrrLKPF/4z8WkCphgWiJw1P/sYPYIgIa
        EnsenmcFKWIWeMAkMWnjHbAiNgEdie3fjgN1c3DwCthJdK2yAQmzCKhKnJ+5HaxXVCBM4ujM
        T4wgNq+AoMSPyffAWjkFgiWWLJ/IBmIzC2hKvPgyiQXCFpdobr0JZctLbF7zlhlkr4TAZzaJ
        pgW32SFecJG41NUDZQtLvDq+BcqWlni2aiMjhN3OKHF2tjBE8xRGiRUzupkgEsYSzxZ2MUFs
        4JPoOPyXHeQBCQFeiY42IYgSD4kvbUtZIMKOEmuOQ0PrGqPErOsvWScwys1C8s8sJD/MQvLD
        LCQ/LGBkWcUollpQnJueWmxUYKRXnJhbXJqXrpecn7uJEZwytdx2MC4553OIUYCDUYmH10Bt
        ZZQQa2JZcWXuIUYJDmYlEd77hUAh3pTEyqrUovz4otKc1OJDjKbA8J7ILCWanA9M53kl8YYm
        lgYmZmZG5mYWwOQmztsa4BIlJJCeWJKanZpakFoE08fEwSnVwMhW+29rv8cbAYnlNvMO9Bo7
        yUabq7F/f6byZ8Gv31X39RKmiRZ6rPjq+HH365QTUTUex8673WKX+T+dybWDb5rJB/FXq/00
        Nfg0ct/OeupouaJpz8WJZ1k3L9xplaX7+YP++w0sz/YXvu2dfOWXuPhDJr7lPXq+MdNDmeVT
        btes3NB4/mnjIkslluKMREMt5qLiRAB6PnJZrwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsVy+t9jQd15sauiDM78kLOYf+Qcq8XR87uZ
        LC7vmsNmceR/P6PF7uvnGC2WXr/IZNG69wi7xfG14RYvP55gsXhydAqzA5fHmnlrGD12zrrL
        7vF47kZ2j02rOtk87lzbw+bxeZNcAFsUl01Kak5mWWqRvl0CV8aSK7OYC95JVbxv3sTYwNgg
        0sXIySEhYCKx+coH9i5GLg4hgXWMEl87LrFAOPcZJRad3sYIUiUsEC1xeOo/dhBbREBDYs/D
        86wgRcwCD5gkztw9yAjRcYNRYt+aRywgVWwCOhLbvx1n6mLk4OAVsJPoWmUDEmYRUJU4P3M7
        2CBRgTCJnk2XwRbwCghK/Jh8D6yVUyBYYtejySwgrcwC6hJTpuSChJkFxCWaW2+yQNjyEpvX
        vGWewCgwC0n3LISOWUg6ZiHpWMDIsopRMrWgODc9t9iowCgvtVyvODG3uDQvXS85P3cTIzBW
        th3W6t/B+HhJ/CFGAQ5GJR5eA7WVUUKsiWXFlbmHGCU4mJVEeO8XAoV4UxIrq1KL8uOLSnNS
        iw8xSnOwKInz8ucfixQSSE8sSc1OTS1ILYLJMnFwSjUwtt42viPF9XKSdsNhhnZPR8WTUo6v
        RBuNLx/LWqG6i/cq2zkvbVFrp/VKR+Nqg574+66O3+GjpcN4219vZmKQrtJ36fU9confTn8V
        kn2ZaBKsl5G067x6os+eVNkf0nN05+7oW2V4NflB0aX37O9sHLZ9nPlZrZDBdMd7llmxa+Z6
        ZzcH1j5VYinOSDTUYi4qTgQADf9vw5ECAAA=
X-CMS-MailID: 20180315114846epcas2p3c0f182279786330389cf500f05235f29
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180223064140epcas2p104fe6cca431ec24f2b09a6f5a45ed342
X-RootMTR: 20180223064140epcas2p104fe6cca431ec24f2b09a6f5a45ed342
References: <CGME20180223064140epcas2p104fe6cca431ec24f2b09a6f5a45ed342@epcas2p1.samsung.com>
        <20180223064138.18401-1-jh80.chung@samsung.com>
        <CAPDyKFp2TCBfBvA53+UTJYYRrn2x_Szwb92x_2ahHhOKWdvntw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 07:22 PM, Ulf Hansson wrote:
> On 23 February 2018 at 07:41, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> 'clock-freq-min-max' property had already deprecated.
>> Remove the 'clock-freq-min-max' property that is kept to maintain
>> the compatibility.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> 
> Thanks, applied for next!

Sorry. Thanks for applying this. :)

Best Regards,
Jaehoon Chung

> 
> Kind regards
> Uffe
> 
>> ---
>>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt          |  4 ----
>>  drivers/mmc/host/dw_mmc.c                                 | 15 ++++-----------
>>  2 files changed, 4 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> index ef3e5f14067a..75c9fdca4aaf 100644
>> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> @@ -59,10 +59,6 @@ Optional properties:
>>    is specified and the ciu clock is specified then we'll try to set the ciu
>>    clock to this at probe time.
>>
>> -* clock-freq-min-max (DEPRECATED): Minimum and Maximum clock frequency for card output
>> -  clock(cclk_out). If it's not specified, max is 200MHZ and min is 400KHz by default.
>> -         (Use the "max-frequency" instead of "clock-freq-min-max".)
>> -
>>  * num-slots (DEPRECATED): specifies the number of slots supported by the controller.
>>    The number of physical slots actually used could be equal or less than the
>>    value specified by num-slots. If this property is not specified, the value
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 0aa39975f33b..38e0e7c4ffd9 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2784,7 +2784,6 @@ static int dw_mci_init_slot(struct dw_mci *host)
>>         struct dw_mci_slot *slot;
>>         const struct dw_mci_drv_data *drv_data = host->drv_data;
>>         int ctrl_id, ret;
>> -       u32 freq[2];
>>
>>         mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
>>         if (!mmc)
>> @@ -2798,16 +2797,6 @@ static int dw_mci_init_slot(struct dw_mci *host)
>>         host->slot = slot;
>>
>>         mmc->ops = &dw_mci_ops;
>> -       if (device_property_read_u32_array(host->dev, "clock-freq-min-max",
>> -                                          freq, 2)) {
>> -               mmc->f_min = DW_MCI_FREQ_MIN;
>> -               mmc->f_max = DW_MCI_FREQ_MAX;
>> -       } else {
>> -               dev_info(host->dev,
>> -                       "'clock-freq-min-max' property was deprecated.\n");
>> -               mmc->f_min = freq[0];
>> -               mmc->f_max = freq[1];
>> -       }
>>
>>         /*if there are external regulators, get them*/
>>         ret = mmc_regulator_get_supply(mmc);
>> @@ -2846,6 +2835,10 @@ static int dw_mci_init_slot(struct dw_mci *host)
>>         if (ret)
>>                 goto err_host_allocated;
>>
>> +       mmc->f_min = DW_MCI_FREQ_MIN;
>> +       if (!mmc->f_max)
>> +               mmc->f_max = DW_MCI_FREQ_MAX;
>> +
>>         /* Process SDIO IRQs through the sdio_irq_work. */
>>         if (mmc->caps & MMC_CAP_SDIO_IRQ)
>>                 mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
>> --
>> 2.15.1
>>
> 
> 
> 
