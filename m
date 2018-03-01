Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966595AbeCAIua (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:50:30 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56160 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965838AbeCAIu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:50:26 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180301085024euoutp01fee98756fa8719f576020fc41ad9c9e0~Xv76JhPZ42523225232euoutp01w
X-AuditID: cbfec7f4-6f9ff700000043e4-05-5a97bece6f9e
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"; format="flowed"
Subject: Re: [PATCH v3 00/43] DRM Rockchip rk3399 (Kevin)
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
        Mark Yao <mark.yao@rock-chips.com>, Haixia Shi <hshi@chromium.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <a2331b65-2a3c-e8f4-6db2-31d53d1bddd6@samsung.com>
Date: Thu, 01 Mar 2018 09:50:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
In-reply-to: <20180130202913.28724-1-thierry.escande@collabora.com>
Content-transfer-encoding: 8bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjmO7cdV8vjZvnixGgQlZRl9OPrYheMPD8KgqBoDPNUxws5kx3t
        imWGFxSnqGVMG2UiJpJXahlZTlJytFC7m2UXrKxV0ywlmzl3BP897/c8z/u878vHkuoROphN
        TE4VTclCko5RUjc7J5yrHreV6dc0xuFXN5w0LnA+JHBmrovGj6rbGfxk7AeD6/rtCF8uTsfj
        Dd0kzml5T+Dit0UU7mutYPDI4BSJbaX3CdzW3EHhgYZHCI9meRhc+LSXwROtVgpnP1+EnRkl
        iq2BfJ21DvHlGT0U32cuIHjbQBXib1sGFPyt34M0/za/i+Cbq87y/yz3KN7cUov40abQ3fP0
        yk2HxaTEY6Jp9eZYZcL3XkPKnfQTbz4OKjLQFWMe8mOBWwfdP6uYPKRk1VwNArO1ifYVowi+
        2froWdWzPxZZVY1g0mxjvISKC4DxkjeUF5PcBhjyZMnuTwjejXtm3BpuPXzo/DxDBHIXSCi4
        lk16C5JzEXCp/KnCq2K4CMhz5cltN0ONe4jwYopbCm6He9rAsgs5A3yd3OF99uOi4GOlS05e
        DO1PPsk4CM5nvaS8/YHrVUBlzjPk22E7fBv2ZQGngeGuFhmHQF9JvmwoROCZ+kL4iksI6t1Z
        smojdHT10L6IBVB8s2xmIuBUkJut9kl4KOlulMO2gdM9LN/iIoIb7UV0EQq1zLmZZc7NLHO2
        sMzZ4gqialGQmCYZ40VpbbJ4PFwSjFJacnz4oaPGJjT9Ex2erl821Dp50I44Funmq14UlunV
        tHBMOmm0I2BJXaDKceuiXq06LJw8JZqOHjClJYmSHWlZShekill+Rq/m4oVU8YgopoimWZZg
        /YIzUErCSjLRdX/MZt13XStFB9+Ne5DQQ+jthj1KZVi4puKLTgy4aqzf/1NTvWJXaf9nxqBV
        KZakDp/7Mb5s55Ypf+3lhir/AH/KoIhNZ6I0ajGqrDraelr4J7w+wUwGmP9SkZGpBTGRe0uP
        Z9YoOx3PN2pjrdmUPsW/wRFCBA7pKClBiAgjTZLwH0sblUqFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xa7rn9k2PMlg4Q8ni1rpzrBa9504y
        WTR1vGW1OLvsIJvFla/v2SzW3D7EaDF3Uq3Fjw2nmC3atzxisph0fwKLxeVdc9gsPj34z2yx
        Y8oBJot9mw+zWNzdcJbR4nPrPzaL/quX2Cx+7prHYtF2XcziXMNkdgcRjzXz1jB6zG64yOJx
        ua+XyWPH3SWMHjtn3WX32P7tAavH/e7jTB6bl9R7/J21n8Wjb8sqRo/Pm+QCuKO4bFJSczLL
        Uov07RK4Mt5diinYXVtx78kD9gbGBbldjJwcEgImEte+z2LrYuTiEBJYwiixb88yZpAEr4Cg
        xI/J91hAbGYBM4kvLw+zQhQ9Z5ToevSAESQhLGAp8fjYC7CEiMB0Zollcz+BjWIWeM8kse3Y
        P0aIlhmMEhMvrmQDaWETMJToetvFBrHDTmLFx2dMIDaLgKrEx9MfwXaLCsRITP24kRXE5hRw
        lniy6C3UHfISB688h7LFJZpbb7JMYBSYheTcWUjOnYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoT
        c4tL89L1kvNzNzECI3fbsZ9bdjB2vQs+xCjAwajEw+uwf1qUEGtiWXFl7iFGCQ5mJRHe09uB
        QrwpiZVVqUX58UWlOanFhxilOViUxHnPG1RGCQmkJ5akZqemFqQWwWSZODilGhgvsW8PuK6+
        4d2bwE3vVO/f/mfWcf1XdZJK0+yPux/t+1UutPKt8fOb/6pm7t1bZnRHh8fqQt9ZF5UVrcFc
        zaFiZSwffSYf+RB25ILqiiu74jl7krStBHbvUK/c1i1tcOuOlvB6XZkEDqY/Bjpziw5OK/5j
        cb3p+fuQnxx2Gls3JM8Nuzx/2TIdJZbijERDLeai4kQAjWPlqdgCAAA=
X-CMS-MailID: 20180301085022eucas1p2a9fec4738d884e9cea31bb565ba1f3d6
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180131083447epcas3p3633663f2f88e637ffe54ab8307ce5d14
X-RootMTR: 20180131083447epcas3p3633663f2f88e637ffe54ab8307ce5d14
References: <CGME20180131083447epcas3p3633663f2f88e637ffe54ab8307ce5d14@epcas3p3.samsung.com>
        <20180130202913.28724-1-thierry.escande@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,


On 2018-01-30 21:28, Thierry Escande wrote:
> This patchset includes cleanups, improvements, and bug fixes for
> Rockchip DRM driver and PSR support.
>
> this patchset depends and needs to be applied on top of Rockchip rk3399
> eDP support [1].
>
> [1] https://lkml.org/lkml/2018/1/10/682

I've applied this patchset on vanilla v4.16-rc1 and check how it works on
Exynos5250-based Chromeboo Snow and Exynos5420-based Chromebook2 Peach-Pit
boards. Sadly it breaks exynos_dp drm driver.

Here is the log:

[    3.540955] [drm] Exynos DRM: using 14400000.fimd device for DMA 
mapping operations
[    3.548810] exynos-drm exynos-drm: bound 14400000.fimd (ops 
fimd_component_ops)
[    3.555350] exynos-drm exynos-drm: bound 14450000.mixer (ops 
mixer_component_ops)
[    3.564622] Unable to handle kernel NULL pointer dereference at 
virtual address 000007d8
[    3.571465] pgd = 28ffa2e4
[    3.573977] [000007d8] *pgd=00000000
[    3.577543] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[    3.582817] Modules linked in:
[    3.585846] CPU: 6 PID: 69 Comm: kworker/6:1 Not tainted 
4.16.0-rc1-00062-ge25751974ba8 #3622
[    3.594369] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    3.600437] Workqueue: events deferred_probe_work_func
[    3.605547] PC is at analogix_dp_resume+0x8/0xc0
[    3.610144] LR is at pm_generic_runtime_resume+0x2c/0x38
[    3.615434] pc : [<c0531b98>]    lr : [<c0543fec>] psr: a0000113
[    3.621684] sp : ee13fbd8  ip : 0000001a  fp : 00000001
[    3.626885] r10: ee0eb080  r9 : c0552bd8  r8 : c0fb1d98
[    3.632090] r7 : eebb1010  r6 : eeae9808  r5 : 00000000  r4 : d4850415
[    3.638602] r3 : ee0ed010  r2 : b2d05e00  r1 : 00000000  r0 : 00000000
[    3.645109] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment none
[    3.652224] Control: 10c5387d  Table: 2000406a  DAC: 00000051
[    3.657944] Process kworker/6:1 (pid: 69, stack limit = 0x913205b4)
[    3.664192] Stack: (0xee13fbd8 to 0xee140000)
[    3.668523] 
fbc0:                                                       d4850415 
00000000
[    3.676698] fbe0: eeae9808 c0543fec c0543fc0 c054ffb4 00000000 
c0552d24 00000001 ee10b400
[    3.684852] fc00: c09d1500 eebb1010 eebb10b8 eebad810 00000000 
00000004 c0552bd8 00000000
[    3.693007] fc20: c016f5c4 c0547798 00000000 eebb1010 c0f05900 
eebad810 c0552bd8 00000004
[    3.701163] fc40: 00000000 00000000 c016f5c4 c0547898 00000000 
eebb1010 c0f05900 c0546ff4
[    3.709315] fc60: 60000113 c05475dc 00000001 eebb1010 00000000 
c1711b78 eebb10b8 eebb1010
[    3.717470] fc80: 00000004 eebb10b8 60000113 eebb1010 00000000 
c1711b78 c0f75ce0 c05475ec
[    3.725624] fca0: 00000000 ecc59458 ecc5948c c0f75d4c 00000001 
c053b95c ecc59458 00000001
[    3.733779] fcc0: 00000001 ecc59458 ecc59458 c0f75d4c c0f08448 
c053ad08 ecc59458 ecc59460
[    3.741934] fce0: 00000000 c05390d0 ecc595a4 c1711c3c c0c7310c 
ecc61000 000001ff d186fc33
[    3.750088] fd00: ecc59458 ecc59398 c1715440 ecc59458 ecc61000 
000001ff 00000001 c0fb1738
[    3.758242] fd20: 00000000 c06764c4 c0fb1738 c0678130 ecc59010 
eebb1010 00000000 ecc61000
[    3.766397] fd40: 000001ff c05321c8 00000003 c0c70b70 ecc59010 
eebb1010 ee0ed010 eebb1010
[    3.774551] fd60: 00000000 00000000 ecc50b7c c0528e90 00000000 
c053fa60 ed99b080 00000002
[    3.782706] fd80: 00000028 ee0ec340 ecc61000 c0535bc4 00000000 
00000000 ffffffff 00000000
[    3.790860] fda0: c0f62f80 ee0eb280 ecc61000 c0f63c80 ee031410 
eebb0c10 c0fb1738 c0522ee8
[    3.799015] fdc0: c0522d8c ee0e82c0 00000050 00000004 ed99b050 
ed99b080 c0f6375c c0536378
[    3.807169] fde0: 00000001 c0f63710 c0522b70 ee0ec340 ee0ec340 
ed99b080 00000000 c0f63754
[    3.815324] fe00: ee0ec340 c1711bc0 c0f6333c 00000000 00000007 
c05364fc ecc50b7c eebb1000
[    3.823479] fe20: ee0ed010 eebb1010 c0f6333c c0528fe4 ee13fe3c 
00000000 00000000 ecc50b7c
[    3.831633] fe40: 00000000 eebb1010 fffffdfb c053debc c053de6c 
eebb1010 c1711bbc 00000000
[    3.839787] fe60: c0fb19f0 c053bd18 00000001 c053e4d4 c0f6333c 
00000000 ee13feb0 c053c054
[    3.847942] fe80: 00000001 c0f63bb4 c0fb19f0 c0fc50a0 c1711bbc 
c0539e4c ee8a3ad4 ed996a54
[    3.856096] fea0: eebb1010 eebb1044 c0f63c80 c053b970 eebb1010 
00000001 00000001 ee0d4100
[    3.864251] fec0: eebb1010 c0f63c80 c0f63b68 c053ad08 ee0d4100 
eefa50c0 eebb1010 c053b258
[    3.872405] fee0: c053b21c ee0d4100 eefa50c0 ee13ff28 eefa8300 
c0f63bd8 00000000 c0fa8ae5
[    3.880560] ff00: c0f0846c c014352c 00000001 00000000 c014347c 
60000193 c09cb114 eefa50c0
[    3.888714] ff20: c0143c38 00000000 c0f63bd8 c110ef34 00000000 
c0c71fdc c0f05900 ee0d4100
[    3.896869] ff40: eefa50c0 eefa50f4 c0143bfc c0fa9a27 00000008 
ee0d4118 c0f05900 c0143b84
[    3.905024] ff60: c09d14d4 eeae7280 ee0d5000 eeae7280 ee0d5000 
00000000 eeae72b8 ee0d4100
[    3.913178] ff80: ee9b5eb0 c0143b50 00000000 c014a30c ee0d5000 
c014a1e4 00000000 00000000
[    3.921332] ffa0: 00000000 00000000 00000000 c01010b4 00000000 
00000000 00000000 00000000
[    3.929486] ffc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    3.937641] ffe0: 00000000 00000000 00000000 00000000 00000013 
00000000 00000000 00000000
[    3.945800] [<c0531b98>] (analogix_dp_resume) from [<c0543fec>] 
(pm_generic_runtime_resume+0x2c/0x38)
[    3.955001] [<c0543fec>] (pm_generic_runtime_resume) from 
[<c054ffb4>] (__genpd_runtime_resume+0x2c/0x8c)
[    3.964543] [<c054ffb4>] (__genpd_runtime_resume) from [<c0552d24>] 
(genpd_runtime_resume+0x14c/0x258)
[    3.973824] [<c0552d24>] (genpd_runtime_resume) from [<c0547798>] 
(__rpm_callback+0x134/0x214)
[    3.982409] [<c0547798>] (__rpm_callback) from [<c0547898>] 
(rpm_callback+0x20/0x80)
[    3.990126] [<c0547898>] (rpm_callback) from [<c0546ff4>] 
(rpm_resume+0x3a0/0x734)
[    3.997672] [<c0546ff4>] (rpm_resume) from [<c05475ec>] 
(__pm_runtime_resume+0x64/0x9c)
[    4.005654] [<c05475ec>] (__pm_runtime_resume) from [<c053b95c>] 
(__device_attach+0x8c/0x134)
[    4.014157] [<c053b95c>] (__device_attach) from [<c053ad08>] 
(bus_probe_device+0x88/0x90)
[    4.022314] [<c053ad08>] (bus_probe_device) from [<c05390d0>] 
(device_add+0x3a8/0x580)
[    4.030209] [<c05390d0>] (device_add) from [<c06764c4>] 
(i2c_register_adapter+0xd4/0x3ec)
[    4.038360] [<c06764c4>] (i2c_register_adapter) from [<c05321c8>] 
(analogix_dp_bind+0x2a0/0x410)
[    4.047128] [<c05321c8>] (analogix_dp_bind) from [<c0528e90>] 
(exynos_dp_bind+0x9c/0x12c)
[    4.055277] [<c0528e90>] (exynos_dp_bind) from [<c0535bc4>] 
(component_bind_all+0xfc/0x258)
[    4.063605] [<c0535bc4>] (component_bind_all) from [<c0522ee8>] 
(exynos_drm_bind+0x15c/0x28c)
[    4.072107] [<c0522ee8>] (exynos_drm_bind) from [<c0536378>] 
(try_to_bring_up_master+0x1b8/0x29c)
[    4.080957] [<c0536378>] (try_to_bring_up_master) from [<c05364fc>] 
(component_add+0xa0/0x170)
[    4.089545] [<c05364fc>] (component_add) from [<c0528fe4>] 
(exynos_dp_probe+0x64/0xb8)
[    4.097437] [<c0528fe4>] (exynos_dp_probe) from [<c053debc>] 
(platform_drv_probe+0x50/0xb0)
[    4.105766] [<c053debc>] (platform_drv_probe) from [<c053bd18>] 
(driver_probe_device+0x2b8/0x4a0)
[    4.114615] [<c053bd18>] (driver_probe_device) from [<c0539e4c>] 
(bus_for_each_drv+0x44/0x8c)
[    4.123115] [<c0539e4c>] (bus_for_each_drv) from [<c053b970>] 
(__device_attach+0xa0/0x134)
[    4.131355] [<c053b970>] (__device_attach) from [<c053ad08>] 
(bus_probe_device+0x88/0x90)
[    4.139509] [<c053ad08>] (bus_probe_device) from [<c053b258>] 
(deferred_probe_work_func+0x3c/0x168)
[    4.148536] [<c053b258>] (deferred_probe_work_func) from [<c014352c>] 
(process_one_work+0x1d0/0x7bc)
[    4.157644] [<c014352c>] (process_one_work) from [<c0143b84>] 
(worker_thread+0x34/0x4dc)
[    4.165710] [<c0143b84>] (worker_thread) from [<c014a30c>] 
(kthread+0x128/0x164)
[    4.173080] [<c014a30c>] (kthread) from [<c01010b4>] 
(ret_from_fork+0x14/0x20)
[    4.180274] Exception stack(0xee13ffb0 to 0xee13fff8)
[    4.185295] ffa0:                                     00000000 
00000000 00000000 00000000
[    4.193466] ffc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    4.201620] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    4.208207] Code: e2800e37 eafee601 e92d4070 e1a05000 (e59067d8)
[    4.214370] ---[ end trace bf6046013df7cab2 ]---

This oops happens, because analogix_dp_bind() calls drm_dp_aux_register()
which registers i2c adapter. I2C core tries to runtime get i2c host
device during registration. This ends in analogix_dp_resume(), but dp
context is NULL there. dp context is set in exynos_dp_bind() after
executing analogix_dp_bind().

A quick workaround of this issue is to postpone enabling runtime PM
on analogix device:

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c 
b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 8217c106c72b..db5a6b82815d 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1621,8 +1621,6 @@ analogix_dp_bind(struct device *dev, struct 
drm_device *drm_dev,
                 return ERR_PTR(-ENODEV);
         }

-       pm_runtime_enable(dev);
-
         ret = devm_request_threaded_irq(&pdev->dev, dp->irq,
                                         analogix_dp_hardirq,
                                         analogix_dp_irq_thread,
@@ -1642,7 +1640,9 @@ analogix_dp_bind(struct device *dev, struct 
drm_device *drm_dev,

         ret = drm_dp_aux_register(&dp->aux);
         if (ret)
-               goto err_disable_pm_runtime;
+               return ERR_PTR(ret);
+
+       pm_runtime_enable(dev);

         ret = analogix_dp_create_bridge(drm_dev, dp);
         if (ret) {

With such patch Exynos based boards boot, but there is significant delay
related to i2c/aux channel timeout:

[    3.510610] [drm] Exynos DRM: using 14400000.fimd device for DMA 
mapping operations
[    3.517733] exynos-drm exynos-drm: bound 14400000.fimd (ops 
fimd_component_ops)
[    3.524483] exynos-drm exynos-drm: bound 14450000.mixer (ops 
mixer_component_ops)
[    3.533743] exynos-drm exynos-drm: bound 145b0000.dp-controller (ops 
exynos_dp_ops)
[    3.540074] exynos-drm exynos-drm: bound 14530000.hdmi (ops 
hdmi_component_ops)
[    3.547262] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.553899] [drm] No driver support for vblank timestamp query.
[    3.580467] exynos-dp 145b0000.dp-controller: AUX CH cmd reply timeout!
[    4.085814] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    4.590904] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    5.095930] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    5.601022] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    6.106031] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    6.611095] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    7.116112] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    7.621150] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    8.126191] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    8.638389] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    9.138537] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    9.638613] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[   10.138698] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[   10.638784] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[   11.138939] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[   11.639025] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[   12.139186] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[   12.639281] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[   13.139368] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[   13.216585] exynos-dp 145b0000.dp-controller: Link Training Clock 
Recovery success
[   13.218846] exynos-dp 145b0000.dp-controller: Link Training success!
[   13.333502] Console: switching to colour frame buffer device 170x48
[   13.446186] exynos-drm exynos-drm: fb0:  frame buffer device
[   13.456751] [drm] Initialized exynos 1.0.0 20110530 for exynos-drm on 
minor 0

I've added some debugs and they reveal that AUX CH timeouts happen until DP
PHY is powered on:

[    3.511022] [drm] Exynos DRM: using 14400000.fimd device for DMA 
mapping operations
[    3.518137] exynos-drm exynos-drm: bound 14400000.fimd (ops 
fimd_component_ops)
[    3.524900] exynos-drm exynos-drm: bound 14450000.mixer (ops 
mixer_component_ops)
[    3.533944] exynos-drm exynos-drm: bound 145b0000.dp-controller (ops 
exynos_dp_ops)
[    3.540231] exynos-drm exynos-drm: bound 14530000.hdmi (ops 
hdmi_component_ops)
[    3.547447] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.554077] [drm] No driver support for vblank timestamp query.
[    3.580511] exynos-dp 145b0000.dp-controller: AUX CH cmd reply timeout!
[    4.085882] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    4.590979] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    5.095986] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    5.601057] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    6.106110] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    6.611168] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    7.116212] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    7.621290] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    8.126331] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    8.638578] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    9.138715] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[    9.638872] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[   10.138963] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[   10.639057] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[   11.139208] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[   11.639374] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[   12.139451] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[   12.639553] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[   13.139636] exynos-dp 145b0000.dp-controller: AUX CH enable timeout!
[   13.211826] analogix_dp_set_bridge line 1270 phy_power_on
[   13.216999] exynos-dp 145b0000.dp-controller: Link Training Clock 
Recovery success
[   13.219235] exynos-dp 145b0000.dp-controller: Link Training success!
[   13.333802] Console: switching to colour frame buffer device 170x48
[   13.453198] exynos-drm exynos-drm: fb0:  frame buffer device
[   13.462463] [drm] Initialized exynos 1.0.0 20110530 for exynos-drm on 
minor 0

It looks that handling of DDC i2c over DP AUX chanel (get_modes callback) is
not synchronized with enabling bridge in analogix_dp_set_bridge().

I'm surprised that you didn't observe similar issues on rk3399.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
