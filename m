Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754891AbeDZKIT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:08:19 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36774 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753686AbeDZKIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:08:17 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180426100814euoutp012bb343cc3c5aa3798d33a2ee44a5677f~o9H3Gp4DG1186911869euoutp01a
X-AuditID: cbfec7f2-1c1ff70000011644-70-5ae1a50db0cb
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] video: fbdev-MMP: Delete an error message for a
 failed memory allocation in two functions
Date: Thu, 26 Apr 2018 12:08:12 +0200
Message-id: <1981428.zQfQG5i5U7@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <9aa9c376-22a3-f682-d9a4-5ee95cfd75a0@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7djPc7q8Sx9GGdxcp2hx5et7NovzncuZ
        LbbekrY40feB1eLyrjlsDqwe97uPM3k0nWpn9fi8SS6AOYrLJiU1J7MstUjfLoErY/qER+wF
        X1kqri/5yd7A+J+5i5GTQ0LARGLi6pdANheHkMAKRonN74+wQDifGSW+L9oCV3V6wWOoqmWM
        EodWfGeDcH4zSqx+t4EFpIpNwEpiYvsqxi5GDg4RAVOJPydCQGqYBToYJTYenwJWIyxQIjFj
        7SRmkBoWAVWJf299QMK8ApoSG1Z9YgKxRQW8JLbsawezOQU8JdYueM4OUSMo8WPyPbAxzALy
        Evv2T2WFsHUkzh5bxwiyS0JgBpvEpLPtUFe7SBw8u5kVwhaWeHV8CzuELSNxeXI3C0RDM6PE
        tx17oBomMErsWS8EYVtLHD5+EWoDn8SkbdPBjpYQ4JXoaIMq8ZDoaT4INdNRYtXP3ayQQLnN
        KHFyyV6mCYyys5AcPgvJ4bOQHL6AkXkVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYPyf
        /nf80w7Gr5eSDjEKcDAq8fD+mPcgSog1say4MvcQowQHs5IIb3zrwygh3pTEyqrUovz4otKc
        1OJDjNIcLErivHEadVFCAumJJanZqakFqUUwWSYOTqkGxtnaUm/seBPyzy80fchZFFM/XzRh
        emj0If53FVsSw0PVF6x1Zlf7J1Db1lHnemLGXKfETVJPmYInSz78/nhl6fFY7RU6/DeDXY6U
        GztONuq14i3K1+Z+IbY/maFp7etjAmub3AJVmJRT/lY+4+qO2Dzf9lDmt3max2SrphRJ5W9f
        wTYjmC9WiaU4I9FQi7moOBEAuBz5s/sCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsVy+t/xa7o8Sx9GGaybY2Vx5et7NovzncuZ
        LbbekrY40feB1eLyrjlsDqwe97uPM3k0nWpn9fi8SS6AOYrLJiU1J7MstUjfLoErY/qER+wF
        X1kqri/5yd7A+J+5i5GTQ0LAROL0gsdgtpDAEkaJ/+dSuxi5gOy/jBI7Zm1mBEmwCVhJTGxf
        BWRzcIgImEr8ORECUsMs0MEoMfHfErBmYYESiVn3GllBalgEVCX+vfUBCfMKaEpsWPWJCcQW
        FfCS2LKvHczmFPCUWLvgOTvErtuMEmtmt7FANAhK/Jh8D8xmFpCX2Ld/KiuErSWxfudxpgmM
        /LOQlM1CUjYLSdkCRuZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgQG67djPLTsYu94FH2IU
        4GBU4uH9Me9BlBBrYllxZe4hRgkOZiUR3vjWh1FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEec8b
        VEYJCaQnlqRmp6YWpBbBZJk4OKUaGKu3LGrOFu0Vymra+GS33fKre/jyWX7MLnHe+/GxwnzZ
        YydnmvrZP/laFzZjT1b8drY5P763xldHvm6KWqUb0M9aGPYnTK+xzd425GqbvaHcljNpYQLP
        Ge5F+L28+milT5Dilak5ocesPAxdt7OVtiQckztRKsW57vqeC0ofsmbNZDl0a53hJyWW4oxE
        Qy3mouJEAB/G9eBMAgAA
X-CMS-MailID: 20180426100813eucas1p1312529e6d5225a8dbbf2d660f187d5f0
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20171126204255epcas3p19d6324568d821993e2a4beb971907de6
X-RootMTR: 20171126204255epcas3p19d6324568d821993e2a4beb971907de6
References: <e2c5fe9e-8e01-7fef-a243-ff5d063787b0@users.sourceforge.net>
        <CGME20171126204255epcas3p19d6324568d821993e2a4beb971907de6@epcas3p1.samsung.com>
        <9aa9c376-22a3-f682-d9a4-5ee95cfd75a0@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, November 26, 2017 09:42:49 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 26 Nov 2017 21:16:30 +0100
> 
> Omit an extra message for a memory allocation failure in these functions.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

I've done requested audit regarding multiple fb devices support
myself now and it is okay to apply this patch.

Patch queued for 4.18, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
