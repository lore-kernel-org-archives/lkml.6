Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbeDXEWm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 00:22:42 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:41047 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751089AbeDXEWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 00:22:38 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180424042237epoutp01d73aa94b72538bdb6a98b078c36a5b25~oRHg_OKjH2077920779epoutp01G
X-AuditID: b6c32a36-b55ff70000001027-ee-5adeb10a44ab
Mime-Version: 1.0
Subject: RE: [PATCH 6/6] devfreq: rk3399_dmc: register devfreq notification
 to dmc driver.
Reply-To: myungjoo.ham@samsung.com
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dbasehore@chromium.org" <dbasehore@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dianders@google.com" <dianders@google.com>,
        "groek@google.com" <groek@google.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Lin Huang <hl@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180419104019.24406-7-enric.balletbo@collabora.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180424042233epcms1p7b27cb007b11ed467d773ce93d8bc7ed4@epcms1p7>
Date: Tue, 24 Apr 2018 13:22:33 +0900
X-CMS-MailID: 20180424042233epcms1p7b27cb007b11ed467d773ce93d8bc7ed4
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
X-MTR: 20180424042233epcms1p7b27cb007b11ed467d773ce93d8bc7ed4
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFJsWRmVeSWpSXmKPExsWy7bCmgS7XxntRBmu3c1u8PKRpcf3Lc1aL
        V5v3sFnMP3KO1WLB9pVMFmtuH2K0mDt7EqNF09vtLBb/H71mtfix4RSzxfcbZ9ksNp/rYbU4
        2/SG3WLT42usFpd3zWGz+Nx7hNHi04P/zBate4+wWxxfG25xa+JNJgcRj9kNF1k8dtxdwugx
        8ayux4JNpR6bVnWyedy5tofNY/OSeo+/s/azePRtWcXosf3aPGaPz5vkArijUm0yUhNTUosU
        UvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgB5UUihLzCkFCgUkFhcr
        6dvZFOWXlqQqZOQXl9gqRRsaGukZGpjrGRkBaeNYKyNToJKE1Ixzh9+zF6zhrdjy6A9rA+Nh
        7i5GTg4JAROJo1PmsnQxcnEICexglOi+sI69i5GDg1dAUOLvDmGQGmGBGIkNPUtZQWwhASWJ
        hpv7mCHi+hIdD7YxgthsAroSWzfcBZsjIjCRUeLY5TZWEIdZYBWbxLOmm6wQ23glZrQ/ZYGw
        pSW2L98K1s0p4CQx9eheqLioxM3Vb9lh7PfH5jNC2CISrffOMkPYghIPfu6GiktJPHm7EKq+
        XuL650VMIIslBCYwSvy+8R8qoS/x6MpsNhCbV8BXovvOJrA4i4CqRNNikAaQGheJjdO2gcWZ
        BeQltr+dwwwKCWYBTYn1u/Rh7m/Y+Jsdk20rMXHuTyaIVj6Jd1974P7dMe8J1Hg1iUO7l0DV
        y0icnr6QeQKj8ixEWM9CsngWwuIFjMyrGMVSC4pz01OLDQuM9IoTc4tL89L1kvNzNzGC07mW
        2Q7GRed8DjEKcDAq8fAu+Hk3Sog1say4MvcQowQHs5II7165e1FCvCmJlVWpRfnxRaU5qcWH
        GE2B/p/ILCWanA/MNXkl8YamRsbGxhYmhmamhoZK4rxPfc5ECQmkJ5akZqemFqQWwfQxcXBK
        NTAuFnkgO/t/07p40c9rTfu1BL/7214N8bNy5Wq7fvnCi/2n8zn4ud8can/acm3m/UqpFXGp
        RxZfEWSaV5Xrv/xRvcWB1xnsf43avQpmbT7/2ojTO9vK+WVqfIbp6tUGTd6/Y9fyTVnIsX4G
        Q+/Hgtd2M511SxLdLD5KGr5L27foc9jvcpPVG3OVWIozEg21mIuKEwF4rAAd/QMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180419104059epcas2p3fe5aba95859e02307556200a42bc1ac2
X-RootMTR: 20180419104059epcas2p3fe5aba95859e02307556200a42bc1ac2
References: <20180419104019.24406-7-enric.balletbo@collabora.com>
        <20180419104019.24406-1-enric.balletbo@collabora.com>
        <CGME20180419104059epcas2p3fe5aba95859e02307556200a42bc1ac2@epcms1p7>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Lin Huang <hl@rock-chips.com>
>
>Because dmc may also access the PMU_BUS_IDLE_REQ register, we need to
>ensure that the pd driver and the dmc driver will not access at this
>register at the same time.
>
>Signed-off-by: Lin Huang <hl@rock-chips.com>
>Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>---
>
> drivers/devfreq/rk3399_dmc.c      | 47 +----------------------
> drivers/soc/rockchip/pm_domains.c | 31 +++++++++++++++
> include/soc/rockchip/rk3399_dmc.h | 63 +++++++++++++++++++++++++++++++
> 3 files changed, 96 insertions(+), 45 deletions(-)
> create mode 100644 include/soc/rockchip/rk3399_dmc.h
>
>diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
>index 5bfca028eaaf..a1f320634d69 100644
>--- a/drivers/devfreq/rk3399_dmc.c
>+++ b/drivers/devfreq/rk3399_dmc.c
[]
>diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
>index 53efc386b1ad..7acc836e7eb7 100644
>--- a/drivers/soc/rockchip/pm_domains.c
>+++ b/drivers/soc/rockchip/pm_domains.c
[]
>+static int dmc_notify(struct notifier_block *nb, unsigned long event,
>+		      void *data)
>+{
>+	if (event == DEVFREQ_PRECHANGE)
>+		mutex_lock(&dmc_pmu->mutex);
>+	else if (event == DEVFREQ_POSTCHANGE)
>+		mutex_unlock(&dmc_pmu->mutex);
>+
>+	return NOTIFY_OK;
>+}
>+

Doesn't this incur a deadlock?

1. devfreq.c:update_freq calls devfreq_notify_transition(DEVFREQ_PRECHANGE)
2. pm_domain.c:dmc_notify calls mutex_lock(dmc_pmu->mutex)
3. devfreq.c:update_freq calls target callback
4. rk3399_dmc.c:rk3399_dmcfreq_target calls mutex_lock(&dmcfreq->lock)
   >>>>>> update_freq cannot proceed. <<<<


Cheers,
MyungJoo
