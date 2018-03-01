Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967698AbeCALGn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:06:43 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40108 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966703AbeCALGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:06:34 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180301110631euoutp01378e64e7907014848aa6230eb4cf0f7a~XxywpwkY72794027940euoutp01K
X-AuditID: cbfec7f2-1dbff70000011644-e0-5a97deb627f2
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"; format="flowed"
Subject: Re: [PATCH v3 00/43] DRM Rockchip rk3399 (Kevin)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Thierry Escande <thierry.escande@collabora.com>,
        Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, Tomasz Figa <tfiga@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Cc: Zain Wang <wzz@rock-chips.com>, Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, Yakir Yang <ykk@rock-chips.com>,
        =?UTF-8?Q?=c3=98rjan_Eide?= <orjan.eide@arm.com>,
        Mark Yao <mark.yao@rock-chips.com>, Haixia Shi <hshi@chromium.org>,
        "'Linux Samsung SOC'" <linux-samsung-soc@vger.kernel.org>
Message-id: <91b1714e-fe63-9b06-7f90-2fc85f4ed5e7@samsung.com>
Date: Thu, 01 Mar 2018 12:06:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
In-reply-to: <a2331b65-2a3c-e8f4-6db2-31d53d1bddd6@samsung.com>
Content-transfer-encoding: 8bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzH931+3PNcOXtccp+FtNuizK82s68fC5vxmDWMf1yho2eFutpd
        IUYtOum3q2Sn8qM0P0LS6jSVOnPTj2t1kUplSIkmJWojejyx/nt9v+/3vp/3570vSyp/0G7s
        IV2koNdpQ9UyJ6rs2bh9aVl3tmbF/bZFuOOencYp9ucEjksYpHFjYY0Mt45+keGizlqEc02n
        8FhxHYnPlb4lsKknncKOihwZHn7zm8SXmqoIbMl8QuCqh1YKdxU3IjwSPyHDaS9aZHi8Io/C
        xrY52B6bwWxw5YvyihB/ObaZ4h2pKQRv6SpA/CNzF8OXf39D8z1JNoJ/WBDD/zJXU3xq6W3E
        j5S473DWOK0LEkIPHRX0y30DnULulOOIpHx0/E7DNyYWjSShRCRngVsJ142fCZGV3E0EQ1f8
        EpHTJI8guDaU/9+U2prGSEIhguSec5QoKLhZMJbR/ZdJbg18mIinJVMfgk7rN1oUXLjV8O5Z
        /1+WcT6QOJgoE02zuSwSUvKNpHgguZskVF6/SkjP+kLvVwcjMsV5QnZx/eQIlnXlAuDTz83i
        tZxbD3nv20lp8gKoae2bSqGCM/HtlBT7JQNnOnQSb4KxV120xC4wYCtlJJ4HjoykKX8MpP54
        Soh5gEtGUHk2i5CEtWC1NdPSgJlgKssmxTzAKSDBqJQsPGTUPZiqayPYvw5MNVGPwFT9nklH
        7uZpjZmnNWaetoN52g5XEXUbqYQoQ1iwYPDRCceWGbRhhihd8LKD4WElaPI71k/Yhi1otOVA
        LeJYpJ6h8Bq9qFHS2qOG6LBaBCypnq2oL5+8UgRpo08I+vD9+qhQwVCL5rKUWqXY53Vao+SC
        tZHCEUGIEPT/VIKVu8WikoVbzXtz4lbs2p0T6ju316Jq+pC2M6BoTtyeRv8WLyHy5L4Gq4MZ
        0Fx4bQpvTYn3894Sc6VjoTzTtJ0+7/c9e3Bt7nzPyiUeqsOaoRsTt9rnB2c6XK0VH4lL/HBg
        xYUAb/8Fxibb8h77KmeH/DHtNu5BsAnOtP/d5KBtTf0ulmY1ZQjR+iwm9QbtH7VyLu2KAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xy7rb7k2PMmh5y2Rxa905VovecyeZ
        LJo63rJanF12kM3iytf3bBZrbh9itJg7qdbix4ZTzBbtWx4xWUy6P4HF4vKuOWwWnx78Z7aY
        cX4fk8WOKQeYLPZtPsxicXfDWUaLz63/2Cz6r15is/i5ax6LRdt1MYtzDZPZHUQ91sxbw+gx
        u+Eii8flvl4mjx13lzB67Jx1l91j+7cHrB73u48zeWxeUu/xd9Z+Fo++LasYPT5vkgvgjuKy
        SUnNySxLLdK3S+DKWL3doqB7MWPF6jNf2BsYP3czdjFyckgImEj0XelnB7GFBJYwSrz44Api
        8woISvyYfI8FxGYWMJP48vIwK0TNc0aJpr1gNcIClhKPj70Ai7MJGEp0ve1i62Lk4hARmM4s
        sWzuJzCHWWAVs8TzD70sII6QwFlGiQmnlrFDrLCTePrxMpjNIqAqMX3DabB1ogIxElM/bgQb
        yylgLzHvyU1miDPkJQ5eeQ51krhEc+tNlgmMArOQXDsLybWzkLTMQtKygJFlFaNIamlxbnpu
        sZFecWJucWleul5yfu4mRmAMbzv2c8sOxq53wYcYBTgYlXh4HfZPixJiTSwrrsw9xCjBwawk
        wnt6O1CINyWxsiq1KD++qDQntfgQozQHi5I473mDyighgfTEktTs1NSC1CKYLBMHp1QD48ww
        ky4exkdiwa/Tooubk+oYjIJ2XbN/cVnkbCXHQu+d87a8vCa771VP+IJG7ctWDPGRzxIdSh+d
        y1uw4dvKe1MMT5/W7550wn0yBwM3S8qx2J/SVvO/h3d1ZVx4eaf5wsJZZVUVFfkmk3pXuN/+
        I9wk2fTGc4fI1kgx9bIJ4tPLZt36vinhmhJLcUaioRZzUXEiADdFRx/dAgAA
X-CMS-MailID: 20180301110630eucas1p2784d6f4cc8084145323ebd97e0c2cda0
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180131083447epcas3p3633663f2f88e637ffe54ab8307ce5d14
X-RootMTR: 20180131083447epcas3p3633663f2f88e637ffe54ab8307ce5d14
References: <CGME20180131083447epcas3p3633663f2f88e637ffe54ab8307ce5d14@epcas3p3.samsung.com>
        <20180130202913.28724-1-thierry.escande@collabora.com>
        <a2331b65-2a3c-e8f4-6db2-31d53d1bddd6@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All again,

On 2018-03-01 09:50, Marek Szyprowski wrote:
> Hi All,
>
>
> On 2018-01-30 21:28, Thierry Escande wrote:
>> This patchset includes cleanups, improvements, and bug fixes for
>> Rockchip DRM driver and PSR support.
>>
>> this patchset depends and needs to be applied on top of Rockchip rk3399
>> eDP support [1].
>>
>> [1] https://lkml.org/lkml/2018/1/10/682
>
> I've applied this patchset on vanilla v4.16-rc1 and check how it works on
> Exynos5250-based Chromeboo Snow and Exynos5420-based Chromebook2 
> Peach-Pit
> boards. Sadly it breaks exynos_dp drm driver.
>
> Here is the log:
>
> [    3.540955] [drm] Exynos DRM: using 14400000.fimd device for DMA 
> mapping operations
> [    3.548810] exynos-drm exynos-drm: bound 14400000.fimd (ops 
> fimd_component_ops)
> [    3.555350] exynos-drm exynos-drm: bound 14450000.mixer (ops 
> mixer_component_ops)
> [    3.564622] Unable to handle kernel NULL pointer dereference at 
> virtual address 000007d8
> [    3.571465] pgd = 28ffa2e4
> [    3.573977] [000007d8] *pgd=00000000
> [    3.577543] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> [    3.582817] Modules linked in:
> [    3.585846] CPU: 6 PID: 69 Comm: kworker/6:1 Not tainted 
> 4.16.0-rc1-00062-ge25751974ba8 #3622
> [    3.594369] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [    3.600437] Workqueue: events deferred_probe_work_func
> [    3.605547] PC is at analogix_dp_resume+0x8/0xc0
> [    3.610144] LR is at pm_generic_runtime_resume+0x2c/0x38
> [    3.615434] pc : [<c0531b98>]    lr : [<c0543fec>] psr: a0000113
> [    3.621684] sp : ee13fbd8  ip : 0000001a  fp : 00000001
> [    3.626885] r10: ee0eb080  r9 : c0552bd8  r8 : c0fb1d98
> [    3.632090] r7 : eebb1010  r6 : eeae9808  r5 : 00000000  r4 : d4850415
> [    3.638602] r3 : ee0ed010  r2 : b2d05e00  r1 : 00000000  r0 : 00000000
> [    3.645109] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
> Segment none
> [    3.652224] Control: 10c5387d  Table: 2000406a  DAC: 00000051
> [    3.657944] Process kworker/6:1 (pid: 69, stack limit = 0x913205b4)
> [    3.664192] Stack: (0xee13fbd8 to 0xee140000)
> [    3.668523] fbc0: d4850415 00000000
> [    3.676698] fbe0: eeae9808 c0543fec c0543fc0 c054ffb4 00000000 
> c0552d24 00000001 ee10b400
> [    3.684852] fc00: c09d1500 eebb1010 eebb10b8 eebad810 00000000 
> 00000004 c0552bd8 00000000
> [    3.693007] fc20: c016f5c4 c0547798 00000000 eebb1010 c0f05900 
> eebad810 c0552bd8 00000004
> [    3.701163] fc40: 00000000 00000000 c016f5c4 c0547898 00000000 
> eebb1010 c0f05900 c0546ff4
> [    3.709315] fc60: 60000113 c05475dc 00000001 eebb1010 00000000 
> c1711b78 eebb10b8 eebb1010
> [    3.717470] fc80: 00000004 eebb10b8 60000113 eebb1010 00000000 
> c1711b78 c0f75ce0 c05475ec
> [    3.725624] fca0: 00000000 ecc59458 ecc5948c c0f75d4c 00000001 
> c053b95c ecc59458 00000001
> [    3.733779] fcc0: 00000001 ecc59458 ecc59458 c0f75d4c c0f08448 
> c053ad08 ecc59458 ecc59460
> [    3.741934] fce0: 00000000 c05390d0 ecc595a4 c1711c3c c0c7310c 
> ecc61000 000001ff d186fc33
> [    3.750088] fd00: ecc59458 ecc59398 c1715440 ecc59458 ecc61000 
> 000001ff 00000001 c0fb1738
> [    3.758242] fd20: 00000000 c06764c4 c0fb1738 c0678130 ecc59010 
> eebb1010 00000000 ecc61000
> [    3.766397] fd40: 000001ff c05321c8 00000003 c0c70b70 ecc59010 
> eebb1010 ee0ed010 eebb1010
> [    3.774551] fd60: 00000000 00000000 ecc50b7c c0528e90 00000000 
> c053fa60 ed99b080 00000002
> [    3.782706] fd80: 00000028 ee0ec340 ecc61000 c0535bc4 00000000 
> 00000000 ffffffff 00000000
> [    3.790860] fda0: c0f62f80 ee0eb280 ecc61000 c0f63c80 ee031410 
> eebb0c10 c0fb1738 c0522ee8
> [    3.799015] fdc0: c0522d8c ee0e82c0 00000050 00000004 ed99b050 
> ed99b080 c0f6375c c0536378
> [    3.807169] fde0: 00000001 c0f63710 c0522b70 ee0ec340 ee0ec340 
> ed99b080 00000000 c0f63754
> [    3.815324] fe00: ee0ec340 c1711bc0 c0f6333c 00000000 00000007 
> c05364fc ecc50b7c eebb1000
> [    3.823479] fe20: ee0ed010 eebb1010 c0f6333c c0528fe4 ee13fe3c 
> 00000000 00000000 ecc50b7c
> [    3.831633] fe40: 00000000 eebb1010 fffffdfb c053debc c053de6c 
> eebb1010 c1711bbc 00000000
> [    3.839787] fe60: c0fb19f0 c053bd18 00000001 c053e4d4 c0f6333c 
> 00000000 ee13feb0 c053c054
> [    3.847942] fe80: 00000001 c0f63bb4 c0fb19f0 c0fc50a0 c1711bbc 
> c0539e4c ee8a3ad4 ed996a54
> [    3.856096] fea0: eebb1010 eebb1044 c0f63c80 c053b970 eebb1010 
> 00000001 00000001 ee0d4100
> [    3.864251] fec0: eebb1010 c0f63c80 c0f63b68 c053ad08 ee0d4100 
> eefa50c0 eebb1010 c053b258
> [    3.872405] fee0: c053b21c ee0d4100 eefa50c0 ee13ff28 eefa8300 
> c0f63bd8 00000000 c0fa8ae5
> [    3.880560] ff00: c0f0846c c014352c 00000001 00000000 c014347c 
> 60000193 c09cb114 eefa50c0
> [    3.888714] ff20: c0143c38 00000000 c0f63bd8 c110ef34 00000000 
> c0c71fdc c0f05900 ee0d4100
> [    3.896869] ff40: eefa50c0 eefa50f4 c0143bfc c0fa9a27 00000008 
> ee0d4118 c0f05900 c0143b84
> [    3.905024] ff60: c09d14d4 eeae7280 ee0d5000 eeae7280 ee0d5000 
> 00000000 eeae72b8 ee0d4100
> [    3.913178] ff80: ee9b5eb0 c0143b50 00000000 c014a30c ee0d5000 
> c014a1e4 00000000 00000000
> [    3.921332] ffa0: 00000000 00000000 00000000 c01010b4 00000000 
> 00000000 00000000 00000000
> [    3.929486] ffc0: 00000000 00000000 00000000 00000000 00000000 
> 00000000 00000000 00000000
> [    3.937641] ffe0: 00000000 00000000 00000000 00000000 00000013 
> 00000000 00000000 00000000
> [    3.945800] [<c0531b98>] (analogix_dp_resume) from [<c0543fec>] 
> (pm_generic_runtime_resume+0x2c/0x38)
> [    3.955001] [<c0543fec>] (pm_generic_runtime_resume) from 
> [<c054ffb4>] (__genpd_runtime_resume+0x2c/0x8c)
> [    3.964543] [<c054ffb4>] (__genpd_runtime_resume) from [<c0552d24>] 
> (genpd_runtime_resume+0x14c/0x258)
> [    3.973824] [<c0552d24>] (genpd_runtime_resume) from [<c0547798>] 
> (__rpm_callback+0x134/0x214)
> [    3.982409] [<c0547798>] (__rpm_callback) from [<c0547898>] 
> (rpm_callback+0x20/0x80)
> [    3.990126] [<c0547898>] (rpm_callback) from [<c0546ff4>] 
> (rpm_resume+0x3a0/0x734)
> [    3.997672] [<c0546ff4>] (rpm_resume) from [<c05475ec>] 
> (__pm_runtime_resume+0x64/0x9c)
> [    4.005654] [<c05475ec>] (__pm_runtime_resume) from [<c053b95c>] 
> (__device_attach+0x8c/0x134)
> [    4.014157] [<c053b95c>] (__device_attach) from [<c053ad08>] 
> (bus_probe_device+0x88/0x90)
> [    4.022314] [<c053ad08>] (bus_probe_device) from [<c05390d0>] 
> (device_add+0x3a8/0x580)
> [    4.030209] [<c05390d0>] (device_add) from [<c06764c4>] 
> (i2c_register_adapter+0xd4/0x3ec)
> [    4.038360] [<c06764c4>] (i2c_register_adapter) from [<c05321c8>] 
> (analogix_dp_bind+0x2a0/0x410)
> [    4.047128] [<c05321c8>] (analogix_dp_bind) from [<c0528e90>] 
> (exynos_dp_bind+0x9c/0x12c)
> [    4.055277] [<c0528e90>] (exynos_dp_bind) from [<c0535bc4>] 
> (component_bind_all+0xfc/0x258)
> [    4.063605] [<c0535bc4>] (component_bind_all) from [<c0522ee8>] 
> (exynos_drm_bind+0x15c/0x28c)
> [    4.072107] [<c0522ee8>] (exynos_drm_bind) from [<c0536378>] 
> (try_to_bring_up_master+0x1b8/0x29c)
> [    4.080957] [<c0536378>] (try_to_bring_up_master) from [<c05364fc>] 
> (component_add+0xa0/0x170)
> [    4.089545] [<c05364fc>] (component_add) from [<c0528fe4>] 
> (exynos_dp_probe+0x64/0xb8)
> [    4.097437] [<c0528fe4>] (exynos_dp_probe) from [<c053debc>] 
> (platform_drv_probe+0x50/0xb0)
> [    4.105766] [<c053debc>] (platform_drv_probe) from [<c053bd18>] 
> (driver_probe_device+0x2b8/0x4a0)
> [    4.114615] [<c053bd18>] (driver_probe_device) from [<c0539e4c>] 
> (bus_for_each_drv+0x44/0x8c)
> [    4.123115] [<c0539e4c>] (bus_for_each_drv) from [<c053b970>] 
> (__device_attach+0xa0/0x134)
> [    4.131355] [<c053b970>] (__device_attach) from [<c053ad08>] 
> (bus_probe_device+0x88/0x90)
> [    4.139509] [<c053ad08>] (bus_probe_device) from [<c053b258>] 
> (deferred_probe_work_func+0x3c/0x168)
> [    4.148536] [<c053b258>] (deferred_probe_work_func) from 
> [<c014352c>] (process_one_work+0x1d0/0x7bc)
> [    4.157644] [<c014352c>] (process_one_work) from [<c0143b84>] 
> (worker_thread+0x34/0x4dc)
> [    4.165710] [<c0143b84>] (worker_thread) from [<c014a30c>] 
> (kthread+0x128/0x164)
> [    4.173080] [<c014a30c>] (kthread) from [<c01010b4>] 
> (ret_from_fork+0x14/0x20)
> [    4.180274] Exception stack(0xee13ffb0 to 0xee13fff8)
> [    4.185295] ffa0:                                     00000000 
> 00000000 00000000 00000000
> [    4.193466] ffc0: 00000000 00000000 00000000 00000000 00000000 
> 00000000 00000000 00000000
> [    4.201620] ffe0: 00000000 00000000 00000000 00000000 00000013 
> 00000000
> [    4.208207] Code: e2800e37 eafee601 e92d4070 e1a05000 (e59067d8)
> [    4.214370] ---[ end trace bf6046013df7cab2 ]---
>
> This oops happens, because analogix_dp_bind() calls drm_dp_aux_register()
> which registers i2c adapter. I2C core tries to runtime get i2c host
> device during registration. This ends in analogix_dp_resume(), but dp
> context is NULL there. dp context is set in exynos_dp_bind() after
> executing analogix_dp_bind().
>
> A quick workaround of this issue is to postpone enabling runtime PM
> on analogix device:
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c 
> b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 8217c106c72b..db5a6b82815d 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1621,8 +1621,6 @@ analogix_dp_bind(struct device *dev, struct 
> drm_device *drm_dev,
>                 return ERR_PTR(-ENODEV);
>         }
>
> -       pm_runtime_enable(dev);
> -
>         ret = devm_request_threaded_irq(&pdev->dev, dp->irq,
>                                         analogix_dp_hardirq,
>                                         analogix_dp_irq_thread,
> @@ -1642,7 +1640,9 @@ analogix_dp_bind(struct device *dev, struct 
> drm_device *drm_dev,
>
>         ret = drm_dp_aux_register(&dp->aux);
>         if (ret)
> -               goto err_disable_pm_runtime;
> +               return ERR_PTR(ret);
> +
> +       pm_runtime_enable(dev);
>
>         ret = analogix_dp_create_bridge(drm_dev, dp);
>         if (ret) {
>
> With such patch Exynos based boards boot, but there is significant delay
> related to i2c/aux channel timeout:
>
> [    3.510610] [drm] Exynos DRM: using 14400000.fimd device for DMA 
> mapping operations
> [    3.517733] exynos-drm exynos-drm: bound 14400000.fimd (ops 
> fimd_component_ops)
> [    3.524483] exynos-drm exynos-drm: bound 14450000.mixer (ops 
> mixer_component_ops)
> [    3.533743] exynos-drm exynos-drm: bound 145b0000.dp-controller 
> (ops exynos_dp_ops)
> [    3.540074] exynos-drm exynos-drm: bound 14530000.hdmi (ops 
> hdmi_component_ops)
> [    3.547262] [drm] Supports vblank timestamp caching Rev 2 
> (21.10.2013).
> [    3.553899] [drm] No driver support for vblank timestamp query.
> [    3.580467] exynos-dp 145b0000.dp-controller: AUX CH cmd reply 
> timeout!
> [    4.085814] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    4.590904] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    5.095930] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    5.601022] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    6.106031] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    6.611095] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    7.116112] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    7.621150] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    8.126191] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    8.638389] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    9.138537] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    9.638613] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [   10.138698] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [   10.638784] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [   11.138939] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [   11.639025] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [   12.139186] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [   12.639281] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [   13.139368] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [   13.216585] exynos-dp 145b0000.dp-controller: Link Training Clock 
> Recovery success
> [   13.218846] exynos-dp 145b0000.dp-controller: Link Training success!
> [   13.333502] Console: switching to colour frame buffer device 170x48
> [   13.446186] exynos-drm exynos-drm: fb0:  frame buffer device
> [   13.456751] [drm] Initialized exynos 1.0.0 20110530 for exynos-drm 
> on minor 0
>
> I've added some debugs and they reveal that AUX CH timeouts happen 
> until DP
> PHY is powered on:
>
> [    3.511022] [drm] Exynos DRM: using 14400000.fimd device for DMA 
> mapping operations
> [    3.518137] exynos-drm exynos-drm: bound 14400000.fimd (ops 
> fimd_component_ops)
> [    3.524900] exynos-drm exynos-drm: bound 14450000.mixer (ops 
> mixer_component_ops)
> [    3.533944] exynos-drm exynos-drm: bound 145b0000.dp-controller 
> (ops exynos_dp_ops)
> [    3.540231] exynos-drm exynos-drm: bound 14530000.hdmi (ops 
> hdmi_component_ops)
> [    3.547447] [drm] Supports vblank timestamp caching Rev 2 
> (21.10.2013).
> [    3.554077] [drm] No driver support for vblank timestamp query.
> [    3.580511] exynos-dp 145b0000.dp-controller: AUX CH cmd reply 
> timeout!
> [    4.085882] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    4.590979] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    5.095986] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    5.601057] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    6.106110] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    6.611168] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    7.116212] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    7.621290] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    8.126331] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    8.638578] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    9.138715] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [    9.638872] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [   10.138963] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [   10.639057] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [   11.139208] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [   11.639374] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [   12.139451] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [   12.639553] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [   13.139636] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
> [   13.211826] analogix_dp_set_bridge line 1270 phy_power_on
> [   13.216999] exynos-dp 145b0000.dp-controller: Link Training Clock 
> Recovery success
> [   13.219235] exynos-dp 145b0000.dp-controller: Link Training success!
> [   13.333802] Console: switching to colour frame buffer device 170x48
> [   13.453198] exynos-drm exynos-drm: fb0:  frame buffer device
> [   13.462463] [drm] Initialized exynos 1.0.0 20110530 for exynos-drm 
> on minor 0
>
> It looks that handling of DDC i2c over DP AUX chanel (get_modes 
> callback) is
> not synchronized with enabling bridge in analogix_dp_set_bridge().
>
> I'm surprised that you didn't observe similar issues on rk3399.
>

I've investigated this issue further and it turned out that the DDC/I2C AUX
channel timeout issue is related to the fact, that exynos_dp driver creates
additional connector for the display pipeline on Exynos5420 Chromebook2
Peach-PIT.

One connector is created by analogix_dp core, the second (the one which is
in fact operational) is created by parade_ps eDP/LVDS bridge. The DDC/I2C
AUX channel timeouts happens when DRM core tries to get mode from the
connector object created by analogix_dp core.

This patch fixes this issue:

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c 
b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index db5a6b82815d..46b704adb2ae 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1195,27 +1195,30 @@ static int analogix_dp_bridge_attach(struct 
drm_bridge *bridge)
  {
      struct analogix_dp_device *dp = bridge->driver_private;
      struct drm_encoder *encoder = dp->encoder;
-    struct drm_connector *connector = &dp->connector;
-    int ret;
+    struct drm_connector *connector = NULL;
+    int ret = 0;

      if (!bridge->encoder) {
          DRM_ERROR("Parent encoder object not found");
          return -ENODEV;
      }

-    connector->polled = DRM_CONNECTOR_POLL_HPD;
+    if (!dp->plat_data->skip_connector) {
+        connector = &dp->connector;
+        connector->polled = DRM_CONNECTOR_POLL_HPD;

-    ret = drm_connector_init(dp->drm_dev, connector,
-                 &analogix_dp_connector_funcs,
-                 DRM_MODE_CONNECTOR_eDP);
-    if (ret) {
-        DRM_ERROR("Failed to initialize connector with drm\n");
-        return ret;
-    }
+        ret = drm_connector_init(dp->drm_dev, connector,
+                     &analogix_dp_connector_funcs,
+                     DRM_MODE_CONNECTOR_eDP);
+        if (ret) {
+            DRM_ERROR("Failed to initialize connector with drm\n");
+            return ret;
+        }

-    drm_connector_helper_add(connector,
-                 &analogix_dp_connector_helper_funcs);
-    drm_mode_connector_attach_encoder(connector, encoder);
+        drm_connector_helper_add(connector,
+                     &analogix_dp_connector_helper_funcs);
+        drm_mode_connector_attach_encoder(connector, encoder);
+    }

      /*
       * NOTE: the connector registration is implemented in analogix
diff --git a/drivers/gpu/drm/exynos/exynos_dp.c 
b/drivers/gpu/drm/exynos/exynos_dp.c
index b316249a3f89..86330f396784 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -244,6 +244,7 @@ static int exynos_dp_probe(struct platform_device *pdev)

      /* The remote port can be either a panel or a bridge */
      dp->plat_data.panel = panel;
+    dp->plat_data.skip_connector = !!bridge;
      dp->ptn_bridge = bridge;

  out:
diff --git a/include/drm/bridge/analogix_dp.h 
b/include/drm/bridge/analogix_dp.h
index b384f7e8d14a..475b706b49de 100644
--- a/include/drm/bridge/analogix_dp.h
+++ b/include/drm/bridge/analogix_dp.h
@@ -31,6 +31,7 @@ struct analogix_dp_plat_data {
      struct drm_panel *panel;
      struct drm_encoder *encoder;
      struct drm_connector *connector;
+    bool skip_connector;

      int (*power_on_start)(struct analogix_dp_plat_data *);
      int (*power_on_end)(struct analogix_dp_plat_data *);
-- 

I'm still not convinced that the get_modes callback implementation and real
DDC/I2C AUX transfers are correctly handled in ExynosDP case, but I 
don't have
access to the hardware which would use them. Both Chromebook2 Peach-PIT and
Chromebook Snow have additional bridge between analogix_dp and the panel.

Frankly speaking, this issue reveals that the whole bridge-to-bridge,
connector, panel pipeline handling in the DRM drivers is a over-complicated
(over-engineered?) and there is a mess in the drivers.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
