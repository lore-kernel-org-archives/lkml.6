Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932869AbeDXDzx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 23:55:53 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:53633 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932729AbeDXDzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 23:55:48 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180424035545epoutp03b1a6ceb55d622a3041cd77c04a4848f1~oQwEbLb2Q1597115971epoutp031
X-AuditID: b6c32a39-8a5ff70000000fed-b2-5adeaabeace5
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5ADEAABE.7080201@samsung.com>
Date: Tue, 24 Apr 2018 12:55:42 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, heiko@sntech.de, linux-pm@vger.kernel.org,
        dbasehore@chromium.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Lin Huang <hl@rock-chips.com>
Subject: Re: [PATCH 3/6] devfreq: rk3399_dmc: remove wait for dcf irq event.
In-reply-to: <20180419104019.24406-4-enric.balletbo@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTNYzrTAa2ORfSJCcIYTWjCMi2FwVBXok2sCeqHWjU4wgiEbnZa
        4/ZRiQsiigYMpBIQd6pGpC51KUSsaAxUZXEjbdhUIkqMqECMYjuD0a9378m5951zcnFEegqL
        xPMMFtZsYHQkFia69TA2Ia7B4dcmVr1R0B+d9zG62uNF6StdTYAe7x1E6dG6pwjt9BajdGvB
        JzHdfrcSo4ePegDdte8SRh9we8SLJ6lP2V6I1C7fOaCudxzG1L/sjSL1sRsOoL79sgpRD9dH
        ZYi1bFouy2Sz5mjWkGXMzjPkqMiVazOXZSqTE6k4KpVOIaMNjJ5VkemajLjlebqASDJ6B6Oz
        BqAMhuPIhIVpZqPVwkbnGjmLitxIUfJ4KjElXi4PvIrNC+TKAGULm+u/WiY2DaM7rzscqA34
        REUgFIdEEiy/dTGkCIThUsIFYHlHESo0IwAW9PwONDjP6jxjEPA6AI82fwDBaQkxDY6W+kVB
        DkLMgZ62/CCMELHw5r1rYoHvA7D9/jNU4MtgRWGhOFiLiHnw+81+XgUWwBsHXmPBeioRAztH
        +/j9EcR6eKf6B79oOrEfwCH3L14qEpTaU9zHbwonNNDprOA3hRJLYffXkzwJEuMYfFvfgQpG
        0+GRn74QoQ6HHx/fEAvWZsO2RyqBfwjAQ+4qRGjKAPS+8k8MKOD7mqIQwdwUOPS9eCIXCSw8
        KBUoauh9MjTx1xLYO1Yy4b8VwBFHI3ocRNn/i8z+LzL7f5GdBogDzGBNnD6H5SiTMp5j9JzV
        kBOfZdTXA/4wZaku0OzVNAECB+Rkyekxn1aKMju4XfomAHGEnC5xR/m1Ukk2s2s3azZmmq06
        lmsCykDiJ5DIiCxj4MwNlkxKKVcoFHQSlaykKHKm5J2mRSslchgLm8+yJtb8dy4ED420gZpN
        F84mVxfKSgfemzxJiy9W5ju3lrRalHV7t1RWz/1mH2sYSnYtO5/4WV+14nKPfJFtzer53nXW
        2riCVTX4iE/mscdaw1Nb35WLHzQ8+kLdVe0plW1csq3UogeDV2Y1/Bz1VAz0u2tj8p6b0sb3
        dWfpN9hqdf2uQarluiOhV7OdFHG5DCVDzBzzB9S+RMCuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsVy+t9jQd19q+5FGTyeIWfxavMeNov5R86x
        Wqy5fYjR4v+j16wWPzacYrbYfK6H1eJs0xt2i8u75rBZfO49wmhxu3EFm0Xr3iPsDtwesxsu
        snjsuLuE0WPTqk42j7+z9rN49G1Zxeix/do8Zo/Pm+QC2KO4bFJSczLLUov07RK4Mu6tncJe
        8Jm1YuOqVawNjHdZuhg5OCQETCSuLsrrYuTiEBJYxygx/dJVxi5GTg5eAUGJH5PvgdUwC8hL
        HLmUDRJmFlCXmDRvETOILSRwn1Hi3eF4iHItiRkdHewgNouAqsTXrU9YQGw2oPj+FzfYQGx+
        AUWJqz8eM4KMFBWIkOg+UQkSFhFoYZQ4988F5ARmgR2MEn/2zgarFxbwkdi8eQYLxG1nGSX2
        Hl4HluAUcJJ48Gkq0wRGgVlITp2FcOosJKcuYGRexSiZWlCcm55bbFRgmJdarlecmFtcmpeu
        l5yfu4kRGCXbDmv17WC8vyT+EKMAB6MSD++Cn3ejhFgTy4orcw8xSnAwK4nw7pW7FyXEm5JY
        WZValB9fVJqTWnyIUZqDRUmc93besUghgfTEktTs1NSC1CKYLBMHp1QDY+VKzhMHlj4Qj5jm
        5LM+oGFVWdS6zZP/NifIdkpeKtxYKOpRO+XTXJ+Sp8mbDGSWftYUlHWsUuc4FzCpQWKLq9uN
        Zb8285Zv5O/2kjjLZlC9PqHIbdHhzZOaNm5K691+17NKwOJqTdb5L/xT6wvDVu62e/DzbpCn
        zc99jVJBd13a2h1Me5h8lFiKMxINtZiLihMBHaiL344CAAA=
X-CMS-MailID: 20180424035542epcas1p161d04c9f5db53acb3d1190d7847abfca
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180419104132epcas2p191448cac9aa785ce7da43dd31032ff90
X-RootMTR: 20180419104132epcas2p191448cac9aa785ce7da43dd31032ff90
References: <20180419104019.24406-1-enric.balletbo@collabora.com>
        <CGME20180419104132epcas2p191448cac9aa785ce7da43dd31032ff90@epcas2p1.samsung.com>
        <20180419104019.24406-4-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 04월 19일 19:40, Enric Balletbo i Serra wrote:
> We have already wait dcf done in ATF, so don't need wait dcf irq
> in kernel, besides, clear dcf irq in kernel will import competiton
> between kernel and ATF, only handle dcf irq in ATF is a better way.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

The dcf_irq depends on the architecture and device. It means that
the author or other people access the confidential document
have to guarantee this change. So, Lin Huang is one of author of this patch,
looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
