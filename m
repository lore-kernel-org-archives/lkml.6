Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeFETzf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:55:35 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:39165 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752050AbeFETzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:55:33 -0400
X-Google-Smtp-Source: ADUXVKL4oTqFsIeGXaBHG6ImmWZRDMp6nZjvDwP4QGbLFyA8wke29gygCBYk8szInyGARUWOap3znw==
Date: Tue, 5 Jun 2018 13:55:30 -0600
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
Subject: Re: [PATCH v4 2/6] Documentation: DT: Add optional 'timeout-sec'
 property for sp805
Message-ID: <20180605195530.GA874@rob-hp-laptop>
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
 <1527530497-10392-3-git-send-email-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527530497-10392-3-git-send-email-ray.jui@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:01:33AM -0700, Ray Jui wrote:
> Update the SP805 binding document to add optional 'timeout-sec'
> devicetree property

Note "dt-bindings: watchdog: ..." is the preferred subject prefix.

> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  Documentation/devicetree/bindings/watchdog/arm,sp805.txt | 2 ++
>  1 file changed, 2 insertions(+)

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
