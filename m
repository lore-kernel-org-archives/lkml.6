Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936966AbeE2U7W (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 16:59:22 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:50594 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932798AbeE2U7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 16:59:17 -0400
Date: Tue, 29 May 2018 13:59:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: binding: Fix "#cooling-cells" property's name
Message-ID: <20180529205915.GA18129@roeck-us.net>
References: <9754c25e8459685d4919017dd7c8709cee7b89ce.1527224960.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9754c25e8459685d4919017dd7c8709cee7b89ce.1527224960.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 10:49:57AM +0530, Viresh Kumar wrote:
> It should be "#cooling-cells" instead of "cooling-cells". Fix it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied to hwmon-next after updating the subject.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/gpio-fan.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt b/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
> index 439a7430fc68..2becdcfdc840 100644
> --- a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
> +++ b/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
> @@ -11,7 +11,7 @@ Bindings for fan connected to GPIO lines
>    must have the RPM values in ascending order.
>  - alarm-gpios: This pin going active indicates something is wrong with
>    the fan, and a udev event will be fired.
> -- cooling-cells: If used as a cooling device, must be <2>
> +- #cooling-cells: If used as a cooling device, must be <2>
>    Also see: Documentation/devicetree/bindings/thermal/thermal.txt
>    min and max states are derived from the speed-map of the fan.
>  
> -- 
> 2.15.0.194.g9af6a3dea062
> 
