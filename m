Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeENKZ3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:25:29 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:35787 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752011AbeENKZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:25:26 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180514102524epoutp031e9fbd22ca7e55013377b4b4e4e0be1a~ue9-GOV9v3133631336epoutp03C
X-AuditID: b6c32a38-70fff7000000105c-cc-5af96411c9fd
Mime-Version: 1.0
Subject: RE: [PATCH v4 3/6] devfreq: rk3399_dmc: remove wait for dcf irq
 event.
Reply-To: myungjoo.ham@samsung.com
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dbasehore@chromium.org" <dbasehore@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dianders@google.com" <dianders@google.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "hl@rock-chips.com" <hl@rock-chips.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180509125749.31318-4-enric.balletbo@collabora.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180514102520epcms1p86d14eee975eb6b048580c6390e673367@epcms1p8>
Date: Mon, 14 May 2018 19:25:20 +0900
X-CMS-MailID: 20180514102520epcms1p86d14eee975eb6b048580c6390e673367
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
X-MTR: 20180514102520epcms1p86d14eee975eb6b048580c6390e673367
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmnq5gys8og73LFCxeHtK0uP7lOavF
        q8172CzmHznHarFg+0omizW3DzFanHq1jNni/6PXrBY/Npxitth8rofV4mzTG3aLy7vmsFl8
        7j3CaNG69wi7xfG14Q78HrMbLrJ47Li7hNFjwaZSj02rOtk87lzbw+bxd9Z+Fo++LasYPbZf
        m8fs8XmTXABnVKpNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+A
        rltmDtD9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpWhDQyM9QwNzPSMjIG0ca2VkClSS
        kJqxsv0uY8ES1oozpy8zNTBuYOli5OSQEDCRmPu+g7mLkYtDSGAHo8SKvVuYuhg5OHgFBCX+
        7hAGqREWCJR49ew6E4gtJKAk0XBzHzNEXF+i48E2RhCbTUBXYuuGuywgc0QEJjJKHLvcxgri
        MAssY5E4ue0M1DZeiRntT6FsaYnty7eCdXMKOEnse/KXGSIuKnFz9Vt2GPv9sfmMELaIROu9
        s1A1ghIPfu6GiktJPHm7EKq+XuL650VMIIslBCYwSvy+8R8qoS/x6MpsNhCbV8BXYtnUP6wg
        NouAqsTs9u1sEDUuEm/e3ASLMwvIS2x/O4cZFBLMApoS63fpw9zfsPE3OyqbA8i2lXi9ixmi
        k0/i3dceVpiSHfOeMEHYahKHdi+BapWROD19IfMERuVZiKCehWTvLIS9CxiZVzGKpRYU56an
        FhsWmOgVJ+YWl+al6yXn525iBKdiLYsdjHvO+RxiFOBgVOLhDVj+I0qINbGsuDL3EKMEB7OS
        CO9uo59RQrwpiZVVqUX58UWlOanFhxhNgd6fyCwlmpwPzBN5JfGGpkbGxsYWJoZmpoaGSuK8
        c5S+RgkJpCeWpGanphakFsH0MXFwSjUwTtiwSU0xeyFjOQfHSp33TsuMp5Tqz5vu2nIrIzv2
        o8LFSYIly1nZOLqeBFSWtDSs5vwzK+Lrzt2vVjLw5d9tZ4w+4iG+Z8Opnt8iO9zmROcuLFgi
        +v4K+3/nuSUvP07XNAs4MOPJHr0PJzR5udaUTvlRNuPKhndz4//P7PCPz7dO/57cu8+lWYml
        OCPRUIu5qDgRAC9tTQvbAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180509125824epcas5p4e1901ff605ec187eeb2adcd6a34365ae
X-RootMTR: 20180509125824epcas5p4e1901ff605ec187eeb2adcd6a34365ae
References: <20180509125749.31318-4-enric.balletbo@collabora.com>
        <20180509125749.31318-1-enric.balletbo@collabora.com>
        <CGME20180509125824epcas5p4e1901ff605ec187eeb2adcd6a34365ae@epcms1p8>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>We have already wait dcf done in ATF, so don't need wait dcf irq
>in kernel, besides, clear dcf irq in kernel will import competiton
>between kernel and ATF, only handle dcf irq in ATF is a better way.
>
>Signed-off-by: Lin Huang <hl@rock-chips.com>
>Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>---
>
>Changes in v4: None
>Changes in v3: None
>Changes in v2:
>- [3/6] Add Reviewed-by Chanwoo Choi
>
> drivers/devfreq/rk3399_dmc.c | 53 +-----------------------------------
> 1 file changed, 1 insertion(+), 52 deletions(-)
>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
