Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeBRXwa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 18:52:30 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:44372 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeBRXw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 18:52:28 -0500
X-Google-Smtp-Source: AH8x227asPh7mOkmDkvqCsYCh6BPIxW8HobU7rAcf4k8eHB0Vou/z7knXZcS8CAL3sus6zwnDxXUtA==
Date: Sun, 18 Feb 2018 17:52:26 -0600
From: Rob Herring <robh@kernel.org>
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/4] dt/bindings: fix binding examples for tegra gmi
 controller
Message-ID: <20180218235226.ys5sxq5yr3zddsnb@rob-hp-laptop>
References: <20180210013326.27771-1-marcel@ziswiler.com>
 <20180210013326.27771-2-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180210013326.27771-2-marcel@ziswiler.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 02:33:22AM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Fix devicetree binding examples for the Generic Memory Interface (GMI)
> bus driver found on Tegra SOCs.
> 
> While at it also remove double new lines as a left over from Rob's
> commit 4da722ca19f3 ("dt-bindings: Remove "status" from examples").
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
> 
>  Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
