Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031711AbeEXRMe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:12:34 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:34372 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031084AbeEXRMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:12:31 -0400
Date: Thu, 24 May 2018 10:12:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v3 2/6] Documentation: DT: Add optional 'timeout-sec'
 property for sp805
Message-ID: <20180524171229.GC9499@roeck-us.net>
References: <1527120924-12131-1-git-send-email-ray.jui@broadcom.com>
 <1527120924-12131-3-git-send-email-ray.jui@broadcom.com>
 <20180524161628.GA28425@roeck-us.net>
 <621dc488-2d8d-003b-9bd1-4de59e8d178b@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <621dc488-2d8d-003b-9bd1-4de59e8d178b@broadcom.com>
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

On Thu, May 24, 2018 at 09:42:20AM -0700, Ray Jui wrote:
> 
> 
> On 5/24/2018 9:16 AM, Guenter Roeck wrote:
> >On Wed, May 23, 2018 at 05:15:20PM -0700, Ray Jui wrote:
> >>Update the SP805 binding document to add optional 'timeout-sec'
> >>devicetree property
> >>
> >>Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> >>---
> >>  Documentation/devicetree/bindings/watchdog/arm,sp805.txt | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >>diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> >>index 0fa3629..1debea3 100644
> >>--- a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> >>+++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> >>@@ -19,6 +19,8 @@ Required properties:
> >>  Optional properties:
> >>  - interrupts:  Should specify WDT interrupt number
> >>+- timeout-sec: Should specify default WDT timeout in seconds. If unset, the
> >>+               default timeout in the driver is 30 seconds
> >
> >"... the default timeout is determined by the driver" might be better.
> >If you want to mandate a default here (not sure if that is a good idea),
> >I would suggest to use something like "should be 30 seconds".
> >
> 
> Okay. This can be changed to:
> 
> - timeout-sec: Should specify default WDT timeout in seconds. If unset, the
> default timeout is determined by the driver.
> 
> Please advise how to proceed with this patch series. Should I make the above
> modification and send out v4?

I would suggest to wait a day or two, then send out v4 if there are no further
comments.

Thanks,
Guenter
