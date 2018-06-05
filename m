Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeFETlh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:41:37 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34161 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbeFETl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:41:28 -0400
X-Google-Smtp-Source: ADUXVKK2nCRHsh0sHLWhVqEbrUcUGPzD9g/gL1OIcw1xeG3x2bxydPDtqcUcOfgBv7j9sXdivPwzcw==
Date: Tue, 5 Jun 2018 13:41:24 -0600
From: Rob Herring <robh@kernel.org>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v4 1/6] Documentation: DT: Consolidate SP805 binding docs
Message-ID: <20180605194124.GA26885@rob-hp-laptop>
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
 <1527530497-10392-2-git-send-email-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527530497-10392-2-git-send-email-ray.jui@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:01:32AM -0700, Ray Jui wrote:
> Consolidate two SP805 binding documents "arm,sp805.txt" and
> "sp805-wdt.txt" into "arm,sp805.txt" that matches the naming of the
> desired compatible string to be used
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  .../devicetree/bindings/watchdog/arm,sp805.txt     | 27 ++++++++++++++-----
>  .../devicetree/bindings/watchdog/sp805-wdt.txt     | 31 ----------------------
>  2 files changed, 20 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/sp805-wdt.txt

Would be good to get a ACK from FSL/NXP person on this. It looks to me 
like the driver fetches the wrong clock as it gets the first one and the 
driver really wants 'wdog_clk'. In any case, their dts files should be 
updated.

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
