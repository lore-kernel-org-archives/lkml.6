Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbeFELTQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:19:16 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10131 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbeFELTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:19:14 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 05 Jun 2018 04:19:14 -0700
Date: Tue, 5 Jun 2018 14:19:11 +0300
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Dmitry Osipenko <digetx@gmail.com>
CC: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <linux-tegra@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Tegra20 External Memory Controller driver
Message-ID: <20180605111911.GD27696@tbergstrom-lnx.Nvidia.com>
References: <20180603223654.23324-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180603223654.23324-1-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 01:36:49AM +0300, Dmitry Osipenko wrote:
> Hello,
> 
> Couple years ago the Tegra20 EMC driver was removed from the kernel
> due to incompatible changes in the Tegra's clock driver. This patchset
> introduces a modernized EMC driver. Currently the sole purpose of the
> driver is to initialize DRAM frequency to maximum rate during of the
> kernels boot-up. Later we may consider implementing dynamic memory
> frequency scaling, utilizing functionality provided by this driver.
> 
> Changelog:
> 
> v2:
> 	- Minor code cleanups like consistent use of writel_relaxed instead
> 	  of non-relaxed version, reworded error messages, etc.
> 
> 	- Factored out use_pllm_ud bit checking into a standalone patch for
> 	  consistency.
> 
> Dmitry Osipenko (5):
>   dt: bindings: tegra20-emc: Document interrupt property
>   ARM: dts: tegra20: Add interrupt to External Memory Controller
>   clk: tegra20: Turn EMC clock gate into divider
>   clk: tegra20: Check whether direct PLLM sourcing is turned off for EMC
>   memory: tegra: Introduce Tegra20 EMC driver
> 

Series Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
