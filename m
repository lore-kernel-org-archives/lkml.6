Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeBIWta (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 17:49:30 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:39717 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753047AbeBIWtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 17:49:24 -0500
X-Google-Smtp-Source: AH8x226zigyXQTuPxh6vVYUgMavO74izXgZYcOidRoabJ+83oXS2qW26AhX4KYv0oMvvSRSkI/U3ig==
Date: Fri, 9 Feb 2018 16:49:22 -0600
From: Rob Herring <robh@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, mark.rutland@arm.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/7] dt-bindings: tegra: Add missing chips and NVIDIA
 boards
Message-ID: <20180209224922.4fxlpl77kwibzfui@rob-hp-laptop>
References: <1517901757-15353-1-git-send-email-mperttunen@nvidia.com>
 <1517901757-15353-5-git-send-email-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517901757-15353-5-git-send-email-mperttunen@nvidia.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 09:22:34AM +0200, Mikko Perttunen wrote:
> Add compatibility strings for supported but undocumented Tegra chips
> (Tegra114/124/132/210/186/194) and reference boards.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     - add patch
> 
>  Documentation/devicetree/bindings/arm/tegra.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
> index 7f1411bbabf7..32f62bb7006d 100644
> --- a/Documentation/devicetree/bindings/arm/tegra.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra.txt
> @@ -9,6 +9,12 @@ following compatible values:
>  
>    nvidia,tegra20
>    nvidia,tegra30
> +  nvidia,tegra114
> +  nvidia,tegra124
> +  nvidia,tegra132
> +  nvidia,tegra210

Some reason why this is not in numerical order?

> +  nvidia,tegra186
> +  nvidia,tegra194
>  
>  Boards
>  -------------------------------------------
> @@ -26,8 +32,18 @@ board-specific compatible values:
>    nvidia,cardhu
>    nvidia,cardhu-a02
>    nvidia,cardhu-a04
> +  nvidia,dalmore
>    nvidia,harmony
> +  nvidia,jetson-tk1
> +  nvidia,norrin
> +  nvidia,p2371-0000
> +  nvidia,p2371-2180
> +  nvidia,p2571
> +  nvidia,p2771-0000
> +  nvidia,p2972-0000
> +  nvidia,roth
>    nvidia,seaboard
> +  nvidia,tn7
>    nvidia,ventana
>    toradex,apalis_t30
>    toradex,apalis_t30-eval
> -- 
> 2.1.4
> 
