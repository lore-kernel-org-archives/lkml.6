Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeFAQO1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:14:27 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6522 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbeFAQOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:14:25 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 01 Jun 2018 09:14:28 -0700
Subject: Re: [PATCH 2/2] dt-bindings: power: sbs-battery: re-document
 "ti,bq20z75"
To: Brian Norris <briannorris@chromium.org>,
        Sebastian Reichel <sre@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Alexandru Stan <amstan@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Doug Anderson <dianders@chromium.org>
References: <20180601003252.42810-1-briannorris@chromium.org>
 <20180601003252.42810-2-briannorris@chromium.org>
From: Rhyland Klein <rklein@nvidia.com>
Message-ID: <22411469-af79-604f-c56a-1680359b1629@nvidia.com>
Date: Fri, 1 Jun 2018 12:14:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180601003252.42810-2-briannorris@chromium.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/2018 8:32 PM, Brian Norris wrote:
> This compatible property was documented before the driver was renamed to
> "SBS" (see commit e57f1b68c406 ("devicetree-bindings: Propagate
> bq20z75->sbs rename to dt bindings")). The driver has continued to
> support this property as an alternative to "sbs,sbs-battery", and
> because we've noticed there are some lingering TI specifics (in the
> manufacturer-specific portion of the SBS spec), we'd like to start using
> this property again to differentiate.
> 
> Cc: Rhyland Klein <rklein@nvidia.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  .../devicetree/bindings/power/supply/sbs_sbs-battery.txt        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> index c40e8926facf..a7a9c3366f82 100644
> --- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> @@ -2,7 +2,7 @@ SBS sbs-battery
>  ~~~~~~~~~~
>  
>  Required properties :
> - - compatible : "sbs,sbs-battery"
> + - compatible : "sbs,sbs-battery" or "ti,bq20z75"
>  
>  Optional properties :
>   - sbs,i2c-retry-count : The number of times to retry i2c transactions on i2c
> 

Acked-by: Rhyland Klein <rklein@nvidia.com>

-- 
nvpublic
