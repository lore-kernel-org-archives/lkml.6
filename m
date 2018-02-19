Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbeBSDij (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 22:38:39 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40689 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbeBSDih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 22:38:37 -0500
X-Google-Smtp-Source: AH8x225CF+LLCa0IBYX3uVbd9eVztJU8k3QMpP2xN49IEbEk5q8/VXkmu6GZEed7VRgMbY2rEO6bzQ==
Date: Mon, 19 Feb 2018 09:08:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: sean.wang@mediatek.com
Cc: robh+dt@kernel.org, matthias.bgg@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/15] arm64: dts: mt7622: add cpufreq related device
 nodes
Message-ID: <20180219033833.GG28462@vireshk-i7>
References: <cover.1518895232.git.sean.wang@mediatek.com>
 <2cf761c2a20a8ff8a9208ddf3872f10f6f3198f5.1518895232.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf761c2a20a8ff8a9208ddf3872f10f6f3198f5.1518895232.git.sean.wang@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-02-18, 03:54, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add clocks, regulators and opp information into cpu nodes.
> In addition, the power supply for cpu nodes is deployed on
> mt7622-rfb1 board.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 12 +++++++
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi     | 52 ++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
