Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbeE3MQd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:16:33 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47674 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbeE3MQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:16:27 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180530121624euoutp0150b6158c593f8fb7b0206b3265b7488d~zazdj7ieo0937309373euoutp01a
X-AuditID: cbfec7f5-b5fff700000028a9-49-5b0e961674b3
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v2 00/10] Add TOSHIBA TC358764 DSI/LVDS bridge driver
Date: Wed, 30 May 2018 14:15:51 +0200
Message-id: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHfc9lOw63TtP0VcNoYJigGQa9kIVQxiESCvogStnU4wWdk81r
        RopgzXnXStO8BCoxp9Y0U1Ept2YhuryUJawVc+a8VCZWYmbO6bff8/8/Nx4eCheuEx5UQnIq
        K0sWJ4k4PKJbv27wc70viAiorfNFM+1jJCoee4OhPMUyiZ5Wd5CoQbetTa1956AKUxmB5j+N
        E6jUvIgjg+EJF43mLXFRQXkTF2nM70k02feQg6oNgxhqtM4QqE1n5KLm6XEM5Q/ouKi60spB
        6331RPABRl2vBsxkSTHG9NYYuUyt4gHJaFQFHOb5r88kYyocxpjOphympEsFmFWN1yVeOC8o
        hk1KSGdlx85c58W35r7AUt4JM5Xt/SAXWAVK4EhB+gTsMhlxGwvpxwCqXwUoAW+bVwG0qH/j
        e0krZUuE3WgBsH+hYTfYAnBTqyeVgKI4tC9U34m06S60CsDOD8vAFuD0PRK+bVgkba2c6RCo
        Kv2G2ZigvaFxfXZH59Nn4Wz9191xXvDjWAFuK4b0BgcaLEbMbpyDhX/0HDs7w4XhLq6dD8IC
        xcvdHCnMnzPv6plwsHiEtPMpqB0e32GcFsCK7irctjWk+VBxW2hHBs5OM/ZTXIXLY6N4GYCN
        wEEF3Ng0uSSOlQcmsxn+crFEnpYc5x8tlWjA9kOM/Bte6wGDf6OGAE0BkRM/IIwfISTF6fIs
        yRCAFC5y4acNOEUI+THirBusTBopS0ti5UPAkyJEbvxrPrfChXScOJVNZNkUVrbnYpSjRy4o
        9vtiqTpZGiqZzziy6BLaWh+lOx9919ugvNhfMcWUZmyQ7p7hBnNhb4jahwwSSKWugSbXHyuT
        fsqEuvQJ1073tsuWotaaokc3t45qw/YfCrb05GTvmzNrDydO6HnUa2F2eWytd4/12QXnlkrN
        leZetadu02Hc3Ber+9lhcjotIuTx4uO+uEwu/g+xYuJUDAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsVy+t/xy7qi0/iiDf7OMbO4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsErozVDQeYCq4KVXSt28PYwPiSr4uRk0NCwETi44Q3LF2MXBxCAksYJTomzYZyGpkk
        Tt75z9jFyMHBJqAlsaY9HiQuIrCKUWLq3zvsIA6zwGxWiVePJjCCjBIWcJVY1f+OCcRmEVCV
        uPvzCSuIzSvgLPFk3nNmiHVyEjfPdTJPYORawMiwilEktbQ4Nz232FCvODG3uDQvXS85P3cT
        IzCUtx37uXkH46WNwYcYBTgYlXh4DSJ4o4VYE8uKK3MPMUpwMCuJ8Jbu5YkW4k1JrKxKLcqP
        LyrNSS0+xCjNwaIkznveoDJKSCA9sSQ1OzW1ILUIJsvEwSnVwKisKyr54qqt7DJvt+vzYrZf
        nVE8Zf2XTZ8W9fm8l1sT5JQ8j+nh2y5TPiXj7x+z7I1+vL7S/1mycOf107fzeE51lkQtzPu7
        2u5cnOui9yGNr9ubXOet9miPcoyKrcmeUcP+9X/hpjfPmJfOuLfGWmltbvbEnbIrnJ+tlrnD
        enPLh8hNfgUPgqKUWIozEg21mIuKEwEWFn+JYQIAAA==
X-CMS-MailID: 20180530121622eucas1p1015b65cd12a544b1ea72fe6bfd1a3ccc
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180530121622eucas1p1015b65cd12a544b1ea72fe6bfd1a3ccc
References: <CGME20180530121622eucas1p1015b65cd12a544b1ea72fe6bfd1a3ccc@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this patchset is a next attempt to add the tc358764 driver.
The previous one can be found here:

https://lists.freedesktop.org/archives/dri-devel/2014-February/053705.html

Back then, TC358764 was added as a panel driver.

The bridge is supposed to be a DSI peripheral. Currently exynos_dsi accepts only panels
as its peripherals. Therefore, some logic in exynos_dsi had to be ammended. That is implemented
in first 4 patches.

Apart from the driver this patchset adds support for BOE HV070WSA-100 panel, which is used by
TC358764 and dts nodes to exynos5250.dtsi and exynos5250-arndale.dtsi.

Best regards,

Maciej Purski

---

Changes in v2:
- fix commits authorship
- don't call pm_runtime_put_sync() in exyons_dsi_disable(), if pm_runtime_get_sync()
  has not been called
- squash dts commits
- merge some redundant regulators in tc358764 bindings and in DTS
- fix kbuild robot errors

Andrzej Hajda (6):
  panel/hv070wsa-100: add DT bindings
  drm/panel: add support for BOE HV070WSA-100 panel to simple-panel
  dt-bindings: tc358754: add DT bindings
  drm/bridge: tc358764: Add DSI to LVDS bridge driver
  ARM: dts: exynos5250: add DSI node
  ARM: dts: exynos5250-arndale: add DSI and panel nodes

Maciej Purski (4):
  drm/exynos: rename "bridge_node" to "mic_bridge_node"
  drm/exynos: move pm_runtime_get_sync() to exynos_dsi_init()
  drm/exynos: move connector creation to attach callback
  drm/exynos: add non-panel path to exynos_dsi_enable()

 .../bindings/display/bridge/toshiba,tc358764.txt   |  37 ++
 .../bindings/display/panel/boe,hv070wsa-100.txt    |   7 +
 arch/arm/boot/dts/exynos5250-arndale.dts           |  61 +++
 arch/arm/boot/dts/exynos5250.dtsi                  |  21 +
 drivers/gpu/drm/bridge/Kconfig                     |   9 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/tc358764.c                  | 547 +++++++++++++++++++++
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |  88 ++--
 drivers/gpu/drm/panel/panel-simple.c               |  25 +
 9 files changed, 755 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
 create mode 100644 drivers/gpu/drm/bridge/tc358764.c

-- 
2.7.4
