Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeB0LjD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 06:39:03 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:63589 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752300AbeB0LjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 06:39:01 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180227113857epoutp046871d5f6e623109b1c0b4f54ea4cafa7~XK8ggu9bs0842008420epoutp04c
X-AuditID: b6c32a46-3a9ff70000001029-aa-5a954351d4b1
Subject: Re: [PATCH] mmc: dw_mmc: update kernel-doc comments for dw_mci
From: Jaehoon Chung <jh80.chung@samsung.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
        Alexey Roslyakov <alexey.roslyakov@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <ef3874e3-9bb8-9d9c-3ad7-c51269c4721a@samsung.com>
Date: Tue, 27 Feb 2018 20:38:56 +0900
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
        Thunderbird/52.5.0
MIME-version: 1.0
In-reply-to: <8d86b6a2-dbc8-a8d5-7859-bea73e9b7746@samsung.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmuW6g89Qogw3HVS3e3F7DYnF51xw2
        iyP/+xkt7jxZz2pxfG24A6vHzll32T3uXNvD5vF31n4Wj8+b5AJYolJtMlITU1KLFFLzkvNT
        MvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DWKimUJeaUAoUCEouLlfTtbIry
        S0tSFTLyi0tslaINDY30DA3M9YyMjPRMjGOtjEyBShJSM65O28pS8JWnYtXCbcwNjJu5uhg5
        OCQETCROvcnqYuTkEBLYwShx659gFyMXkP2dUeLG7A5mkARITcOffkaIxG5GieZDc9ggOu4x
        SnS1hYHYwgLuEh/nrGMHsdkEdCS2fzvOBGKLCGhI7Hl4nhWkmVngAqPEv9sbWUASvAJ2Ensf
        zwdrYBFQlVjfshisQVQgTOLozE+MEDWCEj8m3wOr5xSwl9j5oR2snllAU+LFl0ksELa4RHPr
        TShbXmLzmrfMIMskBPawSZx8t5wd4gUXiSt9d1ghbGGJV8e3QMWlJZ6t2sgIYbczSpydLQzR
        PIVRYsWMbiaIhLHEs4VdTBAb+CQ6Dv9lh4Qdr0RHmxCE6SExe2Y6RLWjxNNdJ1ghofWHSeLF
        pQUsExjlZiH5ZxaSH2Yh+WEWkh8WMLKsYhRLLSjOTU8tNiow0itOzC0uzUvXS87P3cQITnRa
        bjsYl5zzOcQowMGoxMM7Q25KlBBrYllxZe4hRgkOZiUR3pWLJ0cJ8aYkVlalFuXHF5XmpBYf
        YjQFhvdEZinR5HxgEs4riTc0sTQwMTMzMjezACY2cd7WAJcoIYH0xJLU7NTUgtQimD4mDk6p
        BsbWYJWvRZHbi9/liGxKfS6Z96fGKeFnllGW4q2NOQpbmj2fyhx9cPWM/sOKt4WfhXmPTt3j
        yfPdbNdPlUXe/9YnxB9dkyfjnhuof/z9u19llmlPri99JGr3zyV8bm1q8v6VTtxfVtf+Xr3z
        stp/67kTzyixhD802+78lKP80Tb3xb+3364InmqsxFKckWioxVxUnAgAJ+3j2IoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsVy+t9jAd0A56lRBut2Wlm8ub2GxeLyrjls
        Fkf+9zNa3HmyntXi+NpwB1aPnbPusnvcubaHzePvrP0sHp83yQWwRHHZpKTmZJalFunbJXBl
        XJ22laXgK0/FqoXbmBsYN3N1MXJySAiYSDT86WfsYuTiEBLYySix7P8VdpCEkMADRonlU5RA
        bGEBd4mPc9aBxdkEdCS2fzvOBGKLCGhI7Hl4nhWkmVngAqPEybuPWSAm/WGSmPh6AlgVr4Cd
        xN7H88G6WQRUJda3LAaLiwqESfRsuswIUSMo8WPyPRYQm1PAXmLnh3ageg6gqeoSU6bkgoSZ
        BcQlmltvskDY8hKb17xlnsAoMAtJ9yyEjllIOmYh6VjAyLKKUTK1oDg3PbfYqMAoL7Vcrzgx
        t7g0L10vOT93EyMwyLcd1urfwfh4SfwhRgEORiUe3hlyU6KEWBPLiitzDzFKcDArifCuXDw5
        Sog3JbGyKrUoP76oNCe1+BCjNAeLkjgvf/6xSCGB9MSS1OzU1ILUIpgsEwenVAPjhIkOTpfV
        rxt2TmltXyhmZvGQcdJeiab2zxN/LK5a4P3pwtdbJUHyvYtCM+4zRJ0/xHfs6EGX3kk3Djey
        L7326wnvlHm3Zqcp/DiqcnrXDO4vTA/P880JVlYu/m+33S535ovfW1fyJUdPqlVPnZO8Yv9/
        tT4XoYr2nbsnt8xaxaugYLRxt8JCKyWW4oxEQy3mouJEAIfMoHpuAgAA
X-CMS-MailID: 20180227113857epcas2p1455a8bc89f9df0529e9776c748d7074c
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180223014048epcas5p293b090a79d10de2653428d6fec57a203
X-RootMTR: 20180223014048epcas5p293b090a79d10de2653428d6fec57a203
References: <20180222194525.28947-1-alexey.roslyakov@gmail.com>
        <CGME20180223014048epcas5p293b090a79d10de2653428d6fec57a203@epcas5p2.samsung.com>
        <f87c7d91-8b26-bf63-5323-5c60b00c81e4@rock-chips.com>
        <a3f948c2-f443-63d1-ff3e-51751bc83982@samsung.com>
        <CAPDyKFp7Aik0U49cFZGMamw8xe+=yakGjfuMgbvgFrQA-t=VXQ@mail.gmail.com>
        <8d86b6a2-dbc8-a8d5-7859-bea73e9b7746@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 08:36 PM, Jaehoon Chung wrote:
> On 02/27/2018 08:28 PM, Ulf Hansson wrote:
>> On 23 February 2018 at 07:30, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> On 02/23/2018 10:40 AM, Shawn Lin wrote:
>>>> Hi Alexey,
>>>>
>>>> On 2018/2/23 3:45, Alexey Roslyakov wrote:
>>>>> cur_slot and num_slots has been removed from struct dw_mci in 42f989c002f2.
>>>>> Unfortunately, inline documentation was not updated so far.
>>>>>
>>>>> Fix @lock field documentation in Locking section.
>>>>> Move @mrq field of struct dw_mci_slot mention closer to it
>>>>> description, so no one could miss this slightest detail.
>>>>>
>>>>> Couple of code style fixes as a bonus.
>>>>>
>>>>
>>>> Thanks for updating these.
>>>>
>>>> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>
>>> Thanks! Will apply this with Shawn's Reveiwed-by tag.
>>
>> Dear Jaehoon, I picked this up for next and by adding your ack. Tell
>> me if you have objections!
> 
> Sure! No problem!
> 
> Acekd-by: Jaehoon Chung <jh80.chung@samsung.com>

Typo..

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

> 
> Best Regards,
> Jaehoon Chung
> 
>>
>> [...]
>>
>> Thanks and kind regards
>> Uffe
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
