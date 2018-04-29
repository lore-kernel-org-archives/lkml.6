Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753928AbeD2R0s (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 13:26:48 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35126 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753719AbeD2R0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 13:26:46 -0400
X-Google-Smtp-Source: AB8JxZoas1PyTwdiuImjIbNMeENoQD4WZeC6QJZm5HNV+tOCR/jYDWjfMuK2DkncZ5f+UEASjw7GlA==
Date: Sun, 29 Apr 2018 19:26:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [RFT][PATCH] arm64: dts: exynos: Remove unneeded address space
 mapping for soc node
Message-ID: <20180429172641.d3hiwr5omrmmo5eh@kozik-lap>
References: <CGME20180424173731epcas2p15cddb6a4ea379f6d1736a93961a9c913@epcas2p1.samsung.com>
 <20180424173652.14735-1-krzk@kernel.org>
 <4ebc237b-b29a-0169-8d1b-8726b33bbf9c@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ebc237b-b29a-0169-8d1b-8726b33bbf9c@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 07:52:45AM +0200, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 2018-04-24 19:36, Krzysztof Kozlowski wrote:
> > Remove the address space mapping between root and soc nodes to fix
> > DTC warnings in Exynos5433 and Exynos7 like:
> >
> >      arch/arm64/boot/dts/exynos/exynos5433-tm2.dtb:
> >          Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Works fine on Samsung Exynos5433-based TM2e board.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks for testing! Applied.


Best regards,
Krzysztof
