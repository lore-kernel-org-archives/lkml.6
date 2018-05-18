Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeERVbZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 17:31:25 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34682 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751942AbeERVbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 17:31:11 -0400
X-Google-Smtp-Source: AB8JxZpP+HSXrt2x2ZkbijnyWSDm7MhL67obgmHigWQiYe3ITt4RhlxiDhzTTs06LWZguyCG5UEABg==
Date: Fri, 18 May 2018 16:31:09 -0500
From: Rob Herring <robh@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mathieu Malaterre <malat@debian.org>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 6/8] MIPS: jz4780: dts: Fix watchdog node
Message-ID: <20180518213109.GA28202@rob-hp-laptop>
References: <20180510184751.13416-1-paul@crapouillou.net>
 <20180510184751.13416-6-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510184751.13416-6-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 08:47:49PM +0200, Paul Cercueil wrote:
> - The previous node requested a memory area of 0x100 bytes, while the
>   driver only manipulates four registers present in the first 0x10 bytes.
> 
> - The driver requests for the "rtc" clock, but the previous node did not
>   provide any.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Mathieu Malaterre <malat@debian.org>
> Acked-by: James Hogan <jhogan@kernel.org>
> ---
>  Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt | 7 ++++++-
>  arch/mips/boot/dts/ingenic/jz4780.dtsi                            | 5 ++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
>  v2: No change
>  v3: Also fix documentation

Reviewed-by: Rob Herring <robh@kernel.org>
