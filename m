Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162101AbeCAVoB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:44:01 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:37168 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161643AbeCAVn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:43:59 -0500
X-Google-Smtp-Source: AG47ELugJQnUquRGxCh4SHphEiV0ZiaBetbAyLEr9fSNFXDt26HOz3xnyneQW1puX4A+NRhK8t3ETQ==
Date: Thu, 1 Mar 2018 15:43:57 -0600
From: Rob Herring <robh@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, mark.rutland@arm.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, pombredanne@nexb.com
Subject: Re: [PATCH v4 6/7] arm64: tegra: Add Tegra194 chip device tree
Message-ID: <20180301214357.a7wur5izbpk3udky@rob-hp-laptop>
References: <20180220115812.24108-1-mperttunen@nvidia.com>
 <20180220115812.24108-7-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220115812.24108-7-mperttunen@nvidia.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 01:58:11PM +0200, Mikko Perttunen wrote:
> Add the chip-level device tree, including binding headers, for the
> NVIDIA Tegra194 "Xavier" system-on-chip. Only a small subset of devices
> are initially available, enough to boot to UART console.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> 
> Notes:
>     v4:
>     - fixed copyright headers according to license-rules.rst
>     - removed comments from clock bindings
>     
>     v3:
>     - added hypervisor-related apertures to GIC node
>     - removed GPL boilerplate in favor of SPDX and harmonized
>       copyright headers
> 
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 344 +++++++++++++++++++++++++
>  include/dt-bindings/clock/tegra194-clock.h     | 321 +++++++++++++++++++++++
>  include/dt-bindings/gpio/tegra194-gpio.h       |  61 +++++
>  include/dt-bindings/power/tegra194-powergate.h |  35 +++
>  include/dt-bindings/reset/tegra194-reset.h     | 152 +++++++++++
>  5 files changed, 913 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/nvidia/tegra194.dtsi
>  create mode 100644 include/dt-bindings/clock/tegra194-clock.h
>  create mode 100644 include/dt-bindings/gpio/tegra194-gpio.h
>  create mode 100644 include/dt-bindings/power/tegra194-powergate.h
>  create mode 100644 include/dt-bindings/reset/tegra194-reset.h

Reviewed-by: Rob Herring <robh@kernel.org>
