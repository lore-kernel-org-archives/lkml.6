Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbeDPKMb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:12:31 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:13423 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeDPKM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:12:28 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180416101226epoutp04251be18473fd06bfd06b800ed78cc52c~l4uqg7tur0540305403epoutp04M
X-AuditID: b6c32a45-6ebff70000000fe4-46-5ad477099c82
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 00/14] thermal: exynos: pending fixes and cleanups
Date: Mon, 16 Apr 2018 12:11:51 +0200
Message-id: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsWy7bCmhS5X+ZUog0PTGS02zljPajHvs6zF
        /CvXWC36H79mtjh/fgO7xeVdc9gsPvceYbSYcX4fk8WTh31sDpweO2fdZfdYvOclk8emVZ1s
        Hneu7WHz6NuyitHj8ya5ALYoLpuU1JzMstQifbsEroy+AzvZC6YoVix+d4W1gbFJuouRk0NC
        wETixOStLF2MXBxCAjsYJf4+b2WEcL4zSky4/ZQRpmrKwvusEIkNjBILHjZAVf1ilDhzeh0T
        SBWbgJXExPZVYB0iAloSJy5tZwIpYhaYwCTx9NVMNpCEsICTxJV9G5lBbBYBVYkVT0+D2bwC
        HhJXtpxlgVgnJ3Hy2GSwdRICHWwS89e2Q93hIjGvayozhC0s8er4FnYIW1ri2aqNjBANzYwS
        33bsgSqawCixZ70QhG0tcfj4RVYQm1mAT6Lj8F+gZg6gOK9ERxtUiYfEqW3b2SBsR4mZ0z6D
        zRcSiJWYt3UdywRGyQWMDKsYxVILinPTU4uNCgz1ihNzi0vz0vWS83M3MYKjU8t1B+OMcz6H
        GAU4GJV4eHecvRwlxJpYVlyZe4hRgoNZSYR3WSJQiDclsbIqtSg/vqg0J7X4EKM0B4uSOG+D
        75koIYH0xJLU7NTUgtQimCwTB6dUA2PZY/MPfJ6VkZL79JVm1e7k/LrzcEC84OYpk1O+unYk
        tPJVz3fiX9SREz/9zhP+o4ohp/WvvGGtV99YZSo/ZeEfThXHJw8tXklOL4nV/b1cYP2OTq3K
        mOYa1g117zcpTNznYumQGvqWUaxpapaxSftlrq632968cO90zaudefzZ47/13nnv7yixFGck
        GmoxFxUnAgBmraDUygIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpiluLIzCtJLcpLzFFi42I5/e+xoC5n+ZUogyVnVS02zljPajHvs6zF
        /CvXWC36H79mtjh/fgO7xeVdc9gsPvceYbSYcX4fk8WTh31sDpweO2fdZfdYvOclk8emVZ1s
        Hneu7WHz6NuyitHj8ya5ALYoLpuU1JzMstQifbsEroy+AzvZC6YoVix+d4W1gbFJuouRk0NC
        wERiysL7rCC2kMA6Rompd6O7GLmA7F+MEl+WzmcHSbAJWElMbF/FCGKLCGhJnLi0nQmkiFlg
        ApPEkrWLwIqEBZwkruzbyAxiswioSqx4ehrM5hXwkLiy5SwLxDY5iZPHJrNOYORawMiwilEy
        taA4Nz232KjAKC+1XK84Mbe4NC9dLzk/dxMjMGS2Hdbq38H4eEn8IUYBDkYlHt4dZy9HCbEm
        lhVX5h5ilOBgVhLhXZYIFOJNSaysSi3Kjy8qzUktPsQozcGiJM7Ln38sUkggPbEkNTs1tSC1
        CCbLxMEp1cC4reKfXsllZkPe+pexO95c2eu66eKh/ToqjZUXX3ukG0meaJx62bWI9758xd/P
        Cnc9zR04H0cuPmbIVD6n4dPDvjeOTWt8uvr32s47fEU9q9A0KWzDyZIDOivFLl/5qmd1KfFD
        RJLBF0X5t2s7T+s8yPhV47vW15hh3ofHy5T3fpiTsSqs2YlHiaU4I9FQi7moOBEApSFbUxUC
        AAA=
X-CMS-MailID: 20180416101225epcas2p42e345645d822cd869dbdb449becf1c7a
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180416101225epcas2p42e345645d822cd869dbdb449becf1c7a
X-RootMTR: 20180416101225epcas2p42e345645d822cd869dbdb449becf1c7a
References: <CGME20180416101225epcas2p42e345645d822cd869dbdb449becf1c7a@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eduardo,

Per your request (https://marc.info/?l=linux-pm&m=152378232213070&w=2)
this patchset contains pending Exynos thermal driver fixes and cleanups.

It is based on:
- "[PATCH v3] thermal: exynos: Reading temperature makes sense only
  when TMU is turned on" from Marek Szyprowski
  (https://www.spinics.net/lists/linux-samsung-soc/msg62248.html)
- "[PATCH] thermal: exynos: Propagate error value from tmu_read()"
  from Marek Szyprowski
  (https://www.spinics.net/lists/linux-samsung-soc/msg62252.html)
- "[PATCH] thermal: exynos: Read soc_type from match data" from
  Maciej Purski
  (https://www.spinics.net/lists/linux-samsung-soc/msg62138.html)
- "[PATCH 00/12] thermal: exynos: sanitize DeviceTree support"
  (https://www.spinics.net/lists/linux-samsung-soc/msg62335.html)

Changes:
- fix warnings in "thermal: exynos: remove parsing of
  samsung,tmu_default_temp_offset property" patch
  (in a way suggested by Daniel Lezcano)
- split dts changes on ARM & ARM64 parts
  (as requested by Krzysztof Kozlowski)
- drop "dt-bindings: thermal: remove no longer needed samsung
  thermal properties" patch
  (the patch is already present in linux-soc-thermal-tree)
- drop "thermal: exynos: remove separate thermal_exynos.h header
  file" patch
  (to be resend once dts changes are merged)

Tested on Exynos4210 based Trats board and Exynos5422 based Odroid-XU3
Lite board.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (11):
  thermal: exynos: remove unused "type" field from struct
    exynos_tmu_platform_data
  thermal: exynos: remove parsing of samsung,tmu_default_temp_offset
    property
  thermal: exynos: remove parsing of
    samsung,tmu_[first,second]_point_trim properties
  thermal: exynos: remove parsing of samsung,tmu_noise_cancel_mode
    property
  thermal: exynos: remove parsing of samsung,tmu[_min,_max]_efuse_value
    properties
  thermal: exynos: remove parsing of samsung,tmu_reference_voltage
    property
  thermal: exynos: remove parsing of samsung,tmu_gain property
  thermal: exynos: remove parsing of samsung,tmu_cal_type property
  thermal: exynos: remove separate exynos_tmu.h header file
  ARM: dts: exynos: remove no longer needed samsung thermal properties
  arm64: dts: exynos: remove no longer needed samsung thermal properties

Maciej Purski (1):
  thermal: exynos: Read soc_type from match data

Marek Szyprowski (2):
  thermal: exynos: Reading temperature makes sense only when TMU is
    turned on
  thermal: exynos: Propagate error value from tmu_read()

 arch/arm/boot/dts/exynos3250.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos4.dtsi                     |   2 +-
 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi  |  20 --
 arch/arm/boot/dts/exynos5250.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |   8 +-
 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi  |  21 --
 arch/arm/boot/dts/exynos5420.dtsi                  |  10 +-
 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi  |  20 --
 arch/arm/boot/dts/exynos5440.dtsi                  |   6 +-
 .../dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi |  20 --
 .../dts/exynos/exynos5433-tmu-sensor-conf.dtsi     |  19 --
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  10 +-
 .../boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi   |  21 --
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |   2 +-
 drivers/thermal/samsung/exynos_tmu.c               | 294 ++++++++++-----------
 drivers/thermal/samsung/exynos_tmu.h               |  75 ------
 16 files changed, 165 insertions(+), 367 deletions(-)
 delete mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
 delete mode 100644 drivers/thermal/samsung/exynos_tmu.h

-- 
1.9.1
