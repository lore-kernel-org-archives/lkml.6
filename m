Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeBJBjz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:39:55 -0500
Received: from mout.perfora.net ([74.208.4.194]:41365 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752210AbeBJBji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:39:38 -0500
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc: Marcel Ziswiler <marcel@ziswiler.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] dt/bindings & ARM: dts: tegra: updates
Date: Sat, 10 Feb 2018 02:33:21 +0100
Message-Id: <20180210013326.27771-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
X-Provags-ID: V03:K0:khjxWRuVuLRBpKo8x5VZdXb8Mzt+k0XHKr0GVmhX8Wvncur4K1V
 8FYPErRAqcbv/PB60v4rf9TPuF/Agaz/T7252XUT0YKeNmRxQCIDd1Tvz8yuQQw/hNM14eA
 WK/t6a+45BndCC5h8J0jlXF1UKSJjw4BAradEHultuFx1AXWf/NWnWdNAXjVybcqOxTvz7O
 lT9i2pQbIftSXAVL6Db5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g4wivd9dxJI=:/x99wjJetd9Ea1GdvJ701Y
 kzu8uiH6WjR7uSjj1flgqJSxPo3kKNjOKNq/O79txmE58NDVMAqZT+VmEIJ84M4xv9W2nqhiq
 EYRaon9SQYSdyolXLKwhpuTcyfObWRXgzKr76k/+bjcwFh63ckBe/v0iJLbTeklf+1Wz/ufFV
 4QFnPefNNNKo0k1vPuol/5TKmYBEWulGPru2flv6Wu98YK5JM5ZduuRJh8BsXkenYPQgI1IUr
 m3JOvKmbxce57ZPYSauaX+uUtcw1BArVojJKOb2AKZStby3vmBor1TOkn+hYDD7/wwjkM7Q5l
 a/LpyFwQlMU8UIoW6QRFZxUTj3eltq3ReBN9+lS99x1Tq7E0XUt5o8+ummAEZENRLm9G+BI3K
 u6yucB6G/Js67IT2O4dwyRxmMLfj7dedH2jhqh0s6n9jaXuXZsduGhsxnz73XwnH4Avww7lTi
 XnH9Qma6QeBLrl1Kw1FNNON25nh6jDwn8qegdiX2yHGxRAWmY643kqXxRl+N1Mmu/cATPz6t2
 TbqTVDiQSK3Mww1jJXg5HiA9ApGgQlsF77GhmJTJdNrD/knkgBIEp3b4wy1j7fagHMoWn0vfy
 D7xiPW7gxrjeujtRGUbamPFdXswOrv99N4O1efthQ/9QCBsZbQCk2mnvqbkYgXq+EKNMkhaTK
 76H9w8rW/zgTNS3fayUKv7BP2ZVlUgxQu2bjCYk7HLovo6V84wa8s62MXX3K/GCbofEnLnOwF
 792FKYng1uam6dv4LY1jLs/egsSOQjnkiCys8A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series fixes the Tegra GMI controller DT/bindings example, a few
IRQ type definitions, removes some invalid uses of rsvd1 pin muxes on
Beaver and removes a duplicate pcie-1 node on Venice2.


Marcel Ziswiler (4):
  dt/bindings: fix binding examples for tegra gmi controller
  ARM: dts: tegra: use proper irq type definitions
  ARM: dts: tegra: beaver: remove invalid uses of rsvd1
  ARM: dts: tegra: venice2: remove duplicate pcie-1 node

 .../devicetree/bindings/bus/nvidia,tegra20-gmi.txt |  6 ++--
 arch/arm/boot/dts/tegra114-dalmore.dts             |  2 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |  2 +-
 arch/arm/boot/dts/tegra124-venice2.dts             |  9 ++----
 arch/arm/boot/dts/tegra30-apalis.dtsi              |  4 +--
 arch/arm/boot/dts/tegra30-beaver.dts               | 32 +++++++++++-----------
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts      |  2 +-
 7 files changed, 25 insertions(+), 32 deletions(-)

-- 
2.14.3
