Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754339AbeE1Jrc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:47:32 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40539 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754159AbeE1Jr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:47:26 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180528094723euoutp021dd82793a24b2644418bb5c038e2b29e~yxeyaPtzG1507715077euoutp02N
X-AuditID: cbfec7f5-b45ff700000028a9-f1-5b0bd02a10e0
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
Subject: [PATCH 00/12] Add TOSHIBA TC358764 DSI/LVDS bridge driver
Date: Mon, 28 May 2018 11:47:04 +0200
Message-id: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHe7dz8+TsNA3fVCQmhQy0RD+8UUiU4fkkUR8iNW3pYUo6bUdN
        o2wY2jad1zRN80I6banlFDVBP5g0L3jDNLO8wMLyLkwTUyrn9Nvv//8/z/O+DzyUULyDuVDR
        igROqZDFSAgaa/20PeQlHTkack5byqCpxiEc6Yb6BChNvYKjpuJ3OKro2fM+b64RKH82F0O/
        ZkYxlGNeEqLh4fckGkxbJpEmr5pERvMEjsY6yghUPNwlQJULUxhq6JkmUc2XUQFK7+whUXHB
        AoG2O8qxSyfY+vJ6wI5l6wTsh5fTJFuqLsFZo0FDsG2/53B2NtMkYJurn7DZLQbAWozu1+hg
        +mIkFxOdxCnP+t+ho56uFZHxOceT21UNpAoMirTAjoKMHzTp9LgW0JSYqQPQ9KpKYBMWAFVd
        G8RhlaWqANgCPYB1ExOYTfwDsE9j3hMURTBSWP8s3Oo7MQYAmydX9juETCEORyqWcOsoR+Yy
        LJg3YFbGmNMws+gHsLKICYDajgbc9pw7/DqkEVqbIbNFwJ/DeoEtCIDm1YkDdoSLphbSxm5w
        rCATs3EcTJ83H/jJsEs3cDD0AvxoGt1nIeMA81tfCK2/howIqjPEthIWrm6s768sZm5Do3oc
        5AJYCY4YgDOXyMfKOd5XwT3w5mWxfKJC7h0RF2sEeycx8Ne02Q66du92A4YCEnuRaocOEeOy
        JD4lthtASihxEtFee5YoUpbykFPGhSsTYzi+G7hSmMRZFOaZGixm5LIE7h7HxXPKw1RA2bmo
        QOP9yQSL35lcu9l1V7pst1aqdiKyOkPr5m5a8pqOvQ3Nky5mzSyf0i4G9S9+C0u8jr3u/ZOi
        SJuUZ53Xtdkn91ZfbUOF/aZpjbP5e+BcrbvPDbVHs6c/3xORqnco2Vq49eikvPtKjZ/vm/Lc
        Lb2LOWjl+WyjBz3uFhKYETD42F2C8VEyH6lQycv+A0AAAOEOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsVy+t/xy7qaF7ijDbZtVLW4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsErozm99PYC/oFK3Y0rGVvYDzL28XIySEhYCLxeeFkxi5GLg4hgSWMEp83N7JBOI1M
        Eo2fVgM5HBxsAloSa9rjQeIiAqsYJab+vcMO4jALzGaVePVoAiPIKGEBJ4nJz1axgNgsAqoS
        3dOegMV5BVwkunatZYVYJydx81wn8wRGrgWMDKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzEC
        Q3nbsZ9bdjB2vQs+xCjAwajEw6vxkytaiDWxrLgy9xCjBAezkggvly5QiDclsbIqtSg/vqg0
        J7X4EKM0B4uSOO95g8ooIYH0xJLU7NTUgtQimCwTB6dUA+Ox0/sjpjHlbbn9p+rg8qpnply6
        l3YcO+RoKC/Wn/i7YfsN9xYL/odLjEXkHJgShW7/c7fd0r6jlilkwt0vizeaB7wRyP28jYE5
        kOfxtmAfz23f+PJ9HmnHHehXW/fguUJit4jw7OP50rumFBwLq5wlctSmNPp2ko1o5nvPoiK2
        S+ZhdmuyDiqxFGckGmoxFxUnAgB9tsfWYQIAAA==
X-CMS-MailID: 20180528094721eucas1p22b90fd838ce00f029fec7f5241cc06b5
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180528094721eucas1p22b90fd838ce00f029fec7f5241cc06b5
References: <CGME20180528094721eucas1p22b90fd838ce00f029fec7f5241cc06b5@eucas1p2.samsung.com>
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

Maciej Purski (12):
  drm/exynos: rename "bridge_node" to "mic_bridge_node"
  drm/exynos: move pm_runtime_get_sync() to exynos_dsi_init()
  drm/exynos: move connector creation to attach callback
  drm/exynos: add non-panel path to exynos_dsi_enable()
  panel/hv070wsa-100: add DT bindings
  drm/panel: add support for BOE HV070WSA-100 panel to simple-panel
  dt-bindings: tc358754: add DT bindings
  drm/bridge: tc358764: Add DSI to LVDS bridge driver
  ARM: dts: exynos5250: add mipi-phy node
  ARM: dts: exynos5250: add DSI node
  ARM: dts: exynos5250-arndale: add display regulators
  ARM: dts: exynos5250-arndale: add dsi and panel nodes

 .../bindings/display/bridge/toshiba,tc358764.txt   |  42 ++
 .../bindings/display/panel/boe,hv070wsa-100.txt    |   7 +
 arch/arm/boot/dts/exynos5250-arndale.dts           |  63 +++
 arch/arm/boot/dts/exynos5250.dtsi                  |  20 +
 drivers/gpu/drm/bridge/Kconfig                     |   7 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/tc358764.c                  | 547 +++++++++++++++++++++
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |  84 ++--
 drivers/gpu/drm/panel/panel-simple.c               |  25 +
 9 files changed, 756 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
 create mode 100644 drivers/gpu/drm/bridge/tc358764.c

-- 
2.7.4
