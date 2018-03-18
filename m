Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754556AbeCRMzw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:55:52 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42916 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754174AbeCRMw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:52:28 -0400
X-Google-Smtp-Source: AG47ELuwMRAK6eFvbNWycGvaafFvD3xIaVfAiw4OiekJhyUeCbSXZc+hh2HJQ8aeXBs51w8TaN9Bvg==
Date: Sun, 18 Mar 2018 07:52:25 -0500
From: Rob Herring <robh@kernel.org>
To: Tali Perry <tali.perry1@gmail.com>
Cc: brendanhiggins@google.com, mark.rutland@arm.com, linux@armlinux.org.uk,
        avifishman70@gmail.com, tmaimon77@gmail.com, raltherr@google.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v11 1/2] clk: npcm750: Add binding for Nuvoton NPCM7XX
 clock\n
Message-ID: <20180318125225.sp7ppfumxhcbzbfm@rob-hp-laptop>
References: <1521121518-32217-1-git-send-email-tali.perry1@gmail.com>
 <1521121518-32217-2-git-send-email-tali.perry1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521121518-32217-2-git-send-email-tali.perry1@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 03:45:17PM +0200, Tali Perry wrote:
> * Nuvoton NPCM7XX Clock Controller

Trailing '\n' on the subject.
> 
> Nuvoton Poleg BMC NPCM7XX contains an integrated clock controller, which
> generates and supplies clocks to all modules within the BMC.
> 
> 10 ==> 11
> update documentation. "eth" replaced with "ethernet" in use case eaxample.
> 
> 2 ==> 10
> update documentation. add external clocks as inputs to clk driver.
> fix SPDX comment.
> 
> 1 ==> 2
> This patch includes fix request described here:
> https://patchwork.kernel.org/patch/10200033/
> (move fixed clocks to DT)

Changelog goes after the '---' so it doesn't end up in the git commit.

> 
> Signed-off-by: Tali Perry <tali.perry1@gmail.com>
> 
> ---
> 
> 
>  .../bindings/clock/nuvoton,npcm750-clk.txt         | 100 +++++++++++++++++++++
>  include/dt-bindings/clock/nuvoton,npcm7xx-clock.h  |  44 +++++++++
>  2 files changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt
>  create mode 100644 include/dt-bindings/clock/nuvoton,npcm7xx-clock.h

With those fixed,

Reviewed-by: Rob Herring <robh@kernel.org>
