Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753373AbeE3NoP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:44:15 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48339 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeE3NoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:44:13 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180530134411euoutp018251dd2eafa1d68a500de7128768e3bd~zcAG72H2I2044420444euoutp01Q
X-AuditID: cbfec7f2-5ffe19c000011644-6c-5b0eaaa9a1fd
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 10/19 v3] regulator: s2mps11: Pass descriptor instead of
 GPIO number
Date: Wed, 30 May 2018 15:44:08 +0200
Message-id: <1722883.ZQ0ZDYoSn5@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <2026891.KGZ2uNuXyI@amdc3058>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7djPc7orV/FFG0x6q2Yx9eETNovrX56z
        Wpw/v4Hd4tuVDiaLKX+WM1lc3jWHzWLtkbvsFhdXfGFy4PDYOesuu8emVZ1sHneu7WHz6Nuy
        itHj8ya5ANYoLpuU1JzMstQifbsEroyF5zvZCj5rVmz9NI29gfGQUhcjB4eEgInEvjcKXYxc
        HEICKxglFsz4wAjhfGaU2Lv4M5DDCVY05cB3ZojEMkaJtxMa2SGc34wS1ybPZgKpYhOwkpjY
        vgqsQ0RAR6J7209WkCJmgdVMEte+fmQGSQgLREms/nkdrIhFQFXi6Lo7YDavgKbE3/YJYLao
        gJfEln3tYEM5BbQkrl/4zwJRIyjxY/I9MJtZQF5i3/6prBC2jsTZY+vA7pYQ2MMm8ef+XiaI
        u10k2r5dYIawhSVeHd/CDmHLSHR2HGSCaOhnlPjZ+AfKmcEosXrLcqhua4nDxy9CreCTmLRt
        OjMkyHglOtqEIEo8JE48a4eG2A+g3jvT2ScwysxCcu0sJNfOQnLtAkbmVYziqaXFuempxYZ5
        qeV6xYm5xaV56XrJ+bmbGIHp4fS/4592MH69lHSIUYCDUYmH1yCCN1qINbGsuDL3EKMEB7OS
        CG/pXp5oId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxxGnVRQgLpiSWp2ampBalFMFkmDk6pBsb5
        H8/oitr8Ff56oi6otDDYiFfw68/Lj1t5Y3c7T3h3Vv5Srbnd7mcle9RCQm7s0A/59UEyin25
        d/f9DVn2dbNNi81Ep881lUt99elKw5kyVuOjP9za+87xbGXYfmO5eOCCRL8Cp52Md8PcK6+s
        Vk298r+crfjwzcQXn2bzv6k9brRDfc3blXFKLMUZiYZazEXFiQDC+xR3CwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsVy+t/xq7orVvFFG3y+aGAx9eETNovrX56z
        Wpw/v4Hd4tuVDiaLKX+WM1lc3jWHzWLtkbvsFhdXfGFy4PDYOesuu8emVZ1sHneu7WHz6Nuy
        itHj8ya5ANYoLpuU1JzMstQifbsEroyF5zvZCj5rVmz9NI29gfGQUhcjJ4eEgInElAPfmbsY
        uTiEBJYwSsybu4MVwvnLKHFo+SdWkCo2ASuJie2rGEFsEQEdie5tP8GKmAXWMknMv7KUBSQh
        LBAlsfrndbAiFgFViaPr7oDZvAKaEn/bJ4DZogJeElv2tTOB2JwCWhLXL/xngVt97U0XM0SD
        oMSPyffAhjILyEvs2z+VFcLWkli/8zjTBEb+WUjKZiEpm4WkbAEj8ypGkdTS4tz03GJDveLE
        3OLSvHS95PzcTYzA0N527OfmHYyXNgYfYhTgYFTi4d2wki9aiDWxrLgy9xCjBAezkghv6V6e
        aCHelMTKqtSi/Pii0pzU4kOM0hwsSuK85w0qo4QE0hNLUrNTUwtSi2CyTBycUg2MfDt1P9u+
        aLrrxyx+PzAvOf7EJz4mwS+HVHOPB/3y3pW69GlZbYB92+lrE87d3RmXqLAq+IMl86NEd2On
        yeldTbz39vbXxxufmuPxTqhvulZ16YG5shqiKZ8epT2TzzqwIPDbpTzDFZzeTC3WyQqdUiJG
        PAJJKWwGL280/n22o/1n7FGxf25KLMUZiYZazEXFiQBZPej5aQIAAA==
X-CMS-MailID: 20180530134408eucas1p14c6d7fe692e2ed91ef833c8a1ead8ce7
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180530134408eucas1p14c6d7fe692e2ed91ef833c8a1ead8ce7
References: <20180514080640.12515-1-linus.walleij@linaro.org>
        <CACRpkdZFrFuNnP=uJyREckr8EXW6L2ku+=QwVA7Tva3CpfrpCQ@mail.gmail.com>
        <2026891.KGZ2uNuXyI@amdc3058>
        <CGME20180530134408eucas1p14c6d7fe692e2ed91ef833c8a1ead8ce7@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, May 28, 2018 01:29:07 PM Bartlomiej Zolnierkiewicz wrote:
> 
> Hi Linus,
> 
> On Monday, May 28, 2018 10:41:31 AM Linus Walleij wrote:
> > On Sat, May 26, 2018 at 12:02 PM, Mark Brown <broonie@kernel.org> wrote:
> > > On Mon, May 14, 2018 at 10:06:31AM +0200, Linus Walleij wrote:
> > >> Instead of passing a global GPIO number for the enable GPIO, pass
> > >> a descriptor looked up with the standard devm_gpiod_get_optional()
> > >> call.
> > >>
> > >> This regulator supports passing platform data, but enable/sleep
> > >> regulators are looked up from the device tree exclusively, so
> > >> we can need not touch other files.
> > >
> > > This seems to have broken the boot on Odroid XU3 so I'm going to revert
> > > it:
> > >
> > > https://storage.kernelci.org/next/master/v4.17-rc6-9523-g47b9cef0672d/arm/multi_v7_defconfig/lab-baylibre-seattle/boot-exynos5422-odroidxu3.html
> > 
> > How annoying. I will check with a colleague who might have this
> > board so I can test it on hardware.
> 
> I've reproduced the problem on TM2e board and the patch below fixes
> it (old code always initialized the structure, new code does it only
> in case GPIO properties are provided).
> 
> I've also tested the new code (with fixup) on Artik5 board (which
> actually uses GPIO properties) and discovered the other problem,
> the GPIO core code doesn't handle shared GPIOs which are used by
> many platforms.
> 
> Old code:
> [    1.094950] s2mps11-pmic s2mps14-regulator: Using GPIO 21 for ext-control over 10/LDO11
> [    1.095210] s2mps11-pmic s2mps14-regulator: Using GPIO 21 for ext-control over 11/LDO12
> 
> New code (with fixup):
> [    1.114288] s2mps11-pmic s2mps14-regulator: Using GPIO for ext-control over 10/LDO11
> [    1.143209] s2mps11-pmic s2mps14-regulator: Failed to get control GPIO for 11/LDO12
> 
> [ It fails with -EBUSY on gpiod_request() in gpiod_get_from_of_node(). ]
> 
> Therefore it seems that more work is needed before s2mps11 driver
> can be converted to use GPIO descriptors.

The similar issue with shared GPIOs seems to be present in commit
c89c00e2b8f0 ("regulator: max77686: Pass descriptor instead of GPIO
number") and Midas board (arch/arm/boot/dts/exynos4412-midas.dtsi).
I don't have the board itself to test it but from the code audit it
seems that commit c89c00e2b8f0 should also be reverted.

Marek has also discovered separate problem on Trats2 board with
commit 3c6b38d45fa5 ("regulator: wm8994: Pass descriptor instead of
GPIO number"):

[    2.278330] wm8994 4-001a: Failed to get supply 'DBVDD1': -517
[    2.282773] wm8994 4-001a: Failed to get supplies: -517
[    2.291919] ------------[ cut here ]------------
[    2.295210] WARNING: CPU: 3 PID: 1 at drivers/gpio/gpiolib.c:2399 
release_nodes+0x178/0x1fc
[    2.303562] Modules linked in:
[    2.306483] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 
4.17.0-rc7-next-20180530-00001-g06c3288f5beb #811
[    2.315920] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    2.321975] [<c011313c>] (unwind_backtrace) from [<c010ed20>] 
(show_stack+0x10/0x14)
[    2.329715] [<c010ed20>] (show_stack) from [<c0a3c070>] 
(dump_stack+0x98/0xc4)
[    2.336913] [<c0a3c070>] (dump_stack) from [<c0127a50>] 
(__warn+0x10c/0x124)
[    2.343935] [<c0127a50>] (__warn) from [<c0127b7c>] 
(warn_slowpath_null+0x40/0x48)
[    2.351495] [<c0127b7c>] (warn_slowpath_null) from [<c057e564>] 
(release_nodes+0x178/0x1fc)
[    2.359838] [<c057e564>] (release_nodes) from [<c0579dd8>] 
(driver_probe_device+0xe8/0x4a4)
[    2.368169] [<c0579dd8>] (driver_probe_device) from [<c057a298>] 
(__driver_attach+0x104/0x120)
[    2.376765] [<c057a298>] (__driver_attach) from [<c0577ef8>] 
(bus_for_each_dev+0x68/0xb4)
[    2.384920] [<c0577ef8>] (bus_for_each_dev) from [<c057915c>] 
(bus_add_driver+0x1a8/0x268)
[    2.393166] [<c057915c>] (bus_add_driver) from [<c057b3ec>] 
(driver_register+0x78/0x10c)
[    2.401243] [<c057b3ec>] (driver_register) from [<c06ce0b4>] 
(i2c_register_driver+0x3c/0xa8)
[    2.409664] [<c06ce0b4>] (i2c_register_driver) from [<c0103188>] 
(do_one_initcall+0x8c/0x4b0)
[    2.418172] [<c0103188>] (do_one_initcall) from [<c0f01268>] 
(kernel_init_freeable+0x3e4/0x570)
[    2.426854] [<c0f01268>] (kernel_init_freeable) from [<c0a52418>] 
(kernel_init+0x8/0x10c)
[    2.435003] [<c0a52418>] (kernel_init) from [<c01010b4>] 
(ret_from_fork+0x14/0x20)
[    2.442542] Exception stack(0xef0bbfb0 to 0xef0bbff8)
[    2.447549] bfa0: 00000000 00000000 00000000 00000000
[    2.455745] bfc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    2.463903] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.470568] irq event stamp: 331409
[    2.474034] hardirqs last  enabled at (331493): [<c01935a4>] 
console_unlock+0x4a4/0x660
[    2.481962] hardirqs last disabled at (331500): [<c01931cc>] 
console_unlock+0xcc/0x660
[    2.489923] softirqs last  enabled at (331530): [<c01023e0>] 
__do_softirq+0x2b8/0x650
[    2.497733] softirqs last disabled at (331541): [<c0130068>] 
irq_exit+0x158/0x164
[    2.505190] ---[ end trace 54f70738f2594ecf ]---

[ Reverting the commit in question fixes the issue. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
