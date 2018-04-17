Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeDQPcN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:32:13 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34233 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752192AbeDQPcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:32:11 -0400
X-Google-Smtp-Source: AIpwx4/XfA3AqXvfpYABRzbiaRx8kHdVFWNM5hwWaKKH9RkEc0AJCFLZDD/TGlbG4ap4LGXtz3qTyg==
Date: Tue, 17 Apr 2018 17:32:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andi Shyti <andi@etezian.org>
Cc: Simon Shields <simon@lineageos.org>, Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: exynos: Update x and y properties for mms114
 touchscreen
Message-ID: <20180417153207.fgfg5f4msggbtiuu@kozik-lap>
References: <CGME20180126060503epcas2p4befe2d3d43f4a2158b1e1a123bf7906f@epcas2p4.samsung.com>
 <20180126060454.18082-1-andi.shyti@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180126060454.18082-1-andi.shyti@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 03:04:54PM +0900, Andi Shyti wrote:
> The mms114 binding [1] specifies that the 'x' and 'y' should be
> called respectively 'touchscreen-size-x' and 'touchscreen-size-y'
> in coherence with the touchscreen [2] binding.
> 
> Update the mms114 node for trats2 and trats dts according to the
> binding.
> 
> [1] Documentation/devicetree/bindings/input/touchscreen/mms114.txt
> [2] Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
> Hi Krzysztof,
> 
> this patch depends on Simon's patchset [1] and must be applied after
> that. If you want I can ping you when the patch gets or you can take
> it in the next cycle.
> 
> Andi
> 
> [1] https://marc.info/?l=linux-kernel&m=151682273403098&w=2
>

Hi Andi,

As I understand, the dependencies are in and I can take this?

Best regards,
Krzysztof
