Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeEKDZq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:25:46 -0400
Received: from regular1.263xmail.com ([211.150.99.134]:33299 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeEKDZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:25:43 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: zhangqing@rock-chips.com
X-UNIQUE-TAG: <416bf6378cf55e3c708b767703bf2b23>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Elaine Zhang <zhangqing@rock-chips.com>
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, rjw@rjwysocki.net, khilman@kernel.org,
        ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v1 00/13] add power domain support for Rockchip Socs
Date: Fri, 11 May 2018 11:30:45 +0800
Message-Id: <1526009458-28579-1-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add power domain support for RK3036/RK3128/RK3228/PX30 Soc.
fix up the wrong value when set power domain up.

Elaine Zhang (13):
  dt-bindings: power: add RK3036 SoCs header for power-domain
  dt-bindings: add binding for rk3036 power domains
  Soc: rockchip: power-domain: add power domain support for rk3036
  soc: rockchip: power-domain: Fix wrong value when power up pd
  dt-bindings: power: add RK3128 SoCs header for power-domain
  dt-bindings: add binding for rk3128 power domains
  soc: rockchip: power-domain: add power domain support for rk3128
  dt-bindings: power: add RK3228 SoCs header for power-domain
  dt-bindings: add binding for rk3228 power domains
  soc: rockchip: power-domain: add power domain support for rk3228
  dt-bindings: power: add PX30 SoCs header for power-domain
  dt-bindings: add binding for px30 power domains
  soc: rockchip: power-domain: add power domain support for px30

 .../bindings/soc/rockchip/power_domain.txt         |  12 +++
 drivers/soc/rockchip/pm_domains.c                  | 116 ++++++++++++++++++++-
 include/dt-bindings/power/px30-power.h             |  32 ++++++
 include/dt-bindings/power/rk3036-power.h           |  27 +++++
 include/dt-bindings/power/rk3128-power.h           |  28 +++++
 include/dt-bindings/power/rk3228-power.h           |  26 +++++
 6 files changed, 240 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/power/px30-power.h
 create mode 100644 include/dt-bindings/power/rk3036-power.h
 create mode 100644 include/dt-bindings/power/rk3128-power.h
 create mode 100644 include/dt-bindings/power/rk3228-power.h

-- 
1.9.1
