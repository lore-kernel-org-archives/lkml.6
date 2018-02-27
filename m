Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753195AbeB0Lgn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 06:36:43 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:55736 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752160AbeB0Lgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 06:36:41 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180227113639epoutp01001161abc47c19281a4524dfcaa2f1fc~XK6fwvEMQ0169701697epoutp01P
X-AuditID: b6c32a39-47fff70000000fc5-c3-5a9542c74cab
Subject: Re: [PATCH] mmc: dw_mmc: update kernel-doc comments for dw_mci
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
        Alexey Roslyakov <alexey.roslyakov@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <8d86b6a2-dbc8-a8d5-7859-bea73e9b7746@samsung.com>
Date: Tue, 27 Feb 2018 20:36:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
        Thunderbird/52.5.0
MIME-version: 1.0
In-reply-to: <CAPDyKFp7Aik0U49cFZGMamw8xe+=yakGjfuMgbvgFrQA-t=VXQ@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2zm7SauvqflhsMahSCPnzpy1RYqW1SJ/DCKjWayDHuZwN3Y2
        SSMTuplFVlrqUdMQRFO7KWmiiEubf2piaJQlZRYWFaWp3bS2nYL9e77nfZ73/Z6XV4RJ5/nR
        IrPNRTttlIUQhOH3HsQq47zbrhiUn3qh5uN4K6550l0j0Az8KQWaF1O3+Bpv2/4Uvu4++1Ko
        ezHWI9Atsn24bvauTI8b6K05NJVNO+W0LcuebbaZkog9e43bjYmblGQcqdVsJuQ2ykonEWnp
        +ridZot/LCHPoyxuP6WnGIaIT97qtLtdtDzHzriSiEySVClI5WaFSqVSqBMObVEl+iWH6ZyK
        zizHL/GRmvp6YRFYEpYAsQhBNZpovyooAWEiKewCaHbukZB7LABUPd2GlQBRUDX2k+H4237R
        8Ml/jgmA7veOYoFW4XAX+lpzM9g2Asagntc+fkCEwWGAlsbv4IGCAG5EnfNeXgBLYDLq+TYZ
        xDhch9iOuqA5EmagwaoZwGlWou9lE0GvGO5Fs413gjwGY9H0t8s4h6PQiVPP/uE1qL31E8Zl
        6xKgCs8+DqchXynnRTAcffB2CLlkq9HIYBJHnwHoUXV44M8IlgPUVHmOxxUS0LvrJTyu/3L0
        ee48n/NKUPFpKQd1qLrKxKlT0dvuIT63Hy8PNd+awS8CGRuShg1JwIYkYEMS1AP8BlhFOxir
        iWZIR6KCoayM22ZSZNmtd0Hw5jZou8DDx+keAEWAWCaplJUbpHwqj8m3egASYUSEpLmhzCCV
        ZFP5BbTTbnS6LTTjAYn+bV/CoiOz7P4LtrmMpFqrVG9S+S9NS5JElESvTzNIoYly0bk07aCd
        /308kTi6COQ1nPHJJMkrY+0LQ6QhtZZ9Glf0o/3oYlvLYt9U93NxceGx196q36XY+7MHDmU2
        7Oq/vGT+TuWSxV213tq5EZ59tSDf6Ct8FbPe86eMjd95MOV4X66sKfJCsxd+sc7UPdZmFDUP
        FKyNXHjjGh3JZCeZ3cLGlvIdA/3X1tStKMwmcCaHIjdgTob6C17fhxKJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsVy+t9jQd3jTlOjDDqULd7cXsNicXnXHDaL
        I//7GS3uPFnPanF8bbgDq8fOWXfZPe5c28Pm8XfWfhaPz5vkAliiuGxSUnMyy1KL9O0SuDKm
        b08u+M1ZMWfBAvYGxn/sXYwcHBICJhLXfhV3MXJxCAmsY5Q4+PIwE4TzgFGi+9lj1i5GTg5h
        AXeJj3PWsYPYIgIaEnsenmcFKWIWuMAocfLuYxaIjuNMEovermICqWIT0JHY/u04mM0rYCex
        58sjMJtFQFVi1pb5YJNEBcIkejZdZoSoEZT4MfkeC4jNKRAscbhvBwvIecwC6hJTpuSChJkF
        xCWaW2+yQNjyEpvXvGWewCgwC0n3LISOWUg6ZiHpWMDIsopRMrWgODc9t9iowDAvtVyvODG3
        uDQvXS85P3cTIzDAtx3W6tvBeH9J/CFGAQ5GJR7eGXJTooRYE8uKK3MPMUpwMCuJ8K5cPDlK
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOO/tvGORQgLpiSWp2ampBalFMFkmDk6pBsakTclSPz+X
        /Ug3/jLhEJN0MANri1FSjbY1//6NCayqIp7eFXsdXA4ym9hZvjMK+OXzMcPr9tl6y3XXNmtq
        c/g8nyMZFZ4nZ78urvPUdRnVp4Udz5Y5MXgkLGk0mVATuHqplklPYWWJ+mp14etF/l0nNJ7a
        zRR3vyAXali3i32F4TOXpmh3JZbijERDLeai4kQA8V1b72wCAAA=
X-CMS-MailID: 20180227113639epcas1p4bd4fee93f67d059bf6b87bd0b71e641f
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180223014048epcas5p293b090a79d10de2653428d6fec57a203
X-RootMTR: 20180223014048epcas5p293b090a79d10de2653428d6fec57a203
References: <20180222194525.28947-1-alexey.roslyakov@gmail.com>
        <CGME20180223014048epcas5p293b090a79d10de2653428d6fec57a203@epcas5p2.samsung.com>
        <f87c7d91-8b26-bf63-5323-5c60b00c81e4@rock-chips.com>
        <a3f948c2-f443-63d1-ff3e-51751bc83982@samsung.com>
        <CAPDyKFp7Aik0U49cFZGMamw8xe+=yakGjfuMgbvgFrQA-t=VXQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 08:28 PM, Ulf Hansson wrote:
> On 23 February 2018 at 07:30, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> On 02/23/2018 10:40 AM, Shawn Lin wrote:
>>> Hi Alexey,
>>>
>>> On 2018/2/23 3:45, Alexey Roslyakov wrote:
>>>> cur_slot and num_slots has been removed from struct dw_mci in 42f989c002f2.
>>>> Unfortunately, inline documentation was not updated so far.
>>>>
>>>> Fix @lock field documentation in Locking section.
>>>> Move @mrq field of struct dw_mci_slot mention closer to it
>>>> description, so no one could miss this slightest detail.
>>>>
>>>> Couple of code style fixes as a bonus.
>>>>
>>>
>>> Thanks for updating these.
>>>
>>> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> Thanks! Will apply this with Shawn's Reveiwed-by tag.
> 
> Dear Jaehoon, I picked this up for next and by adding your ack. Tell
> me if you have objections!

Sure! No problem!

Acekd-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> 
> [...]
> 
> Thanks and kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
