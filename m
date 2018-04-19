Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbeDSKkx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:40:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34968 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeDSKku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:40:50 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, heiko@sntech.de, linux-pm@vger.kernel.org,
        dbasehore@chromium.org, linux-kernel@vger.kernel.org,
        dianders@google.com, groek@google.com, kernel@collabora.com,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lin Huang <hl@rock-chips.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/6] devfreq: rk3399_dmc: improve rk3399_dmc driver and it's documentation
Date: Thu, 19 Apr 2018 12:40:13 +0200
Message-Id: <20180419104019.24406-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

These patches is an attempt to improve a little bit the rk3399_dmc
driver and it's documentation in order to have all in a better shape for
a future work I am doing. My final intention is add ddrfreq support for
rockchip drm driver, but the patches for this are still
work-in-progress. So let's start with this first patchset that is
basically some fixes/improvements for the rk3399_dmc driver.

Best regards,

Enric Balletbo i Serra (3):
  dt-bindings: clock: add DDR3 standard speed bins.
  devfreq: rk3399_dmc: remove wait for dcf irq event.
  dt-bindings: devfreq: rk3399_dmc: remove interrupts as is not
    required.

Lin Huang (2):
  devfreq: rk3399_dmc: do not print error when get supply and clk defer.
  devfreq: rk3399_dmc: register devfreq notification to dmc driver.

Nick Milner (1):
  dt-bindings: devfreq: rk3399_dmc: improve binding documentation.

 .../bindings/devfreq/rk3399_dmc.txt           | 204 +++++++++---------
 drivers/devfreq/rk3399_dmc.c                  | 106 +--------
 drivers/soc/rockchip/pm_domains.c             |  31 +++
 include/dt-bindings/clock/ddr.h               |  34 +++
 include/soc/rockchip/rk3399_dmc.h             |  63 ++++++
 5 files changed, 238 insertions(+), 200 deletions(-)
 create mode 100644 include/dt-bindings/clock/ddr.h
 create mode 100644 include/soc/rockchip/rk3399_dmc.h

-- 
2.17.0
