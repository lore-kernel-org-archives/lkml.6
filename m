Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbeCWRLF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751691AbeCWRLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:11:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BC821835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: avifishman70@gmail.com, brendanhiggins@google.com,
        linux@armlinux.org.uk, mark.rutland@arm.com, mturquette@baylibre.com,
        raltherr@google.com, robh+dt@kernel.org, sboyd@codeaurora.org,
        tali.perry1@gmail.com, tmaimon77@gmail.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1521553249-6971-2-git-send-email-tali.perry1@gmail.com>
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Tali Perry <tali.perry1@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1521553249-6971-1-git-send-email-tali.perry1@gmail.com>
 <1521553249-6971-2-git-send-email-tali.perry1@gmail.com>
Message-ID: <152182506241.178046.9923016351698583201@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v11 1/2] dt-binding: clk: npcm750: Add binding for Nuvoton
 NPCM7XX Clock
Date: Fri, 23 Mar 2018 10:11:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting tali.perry1@gmail.com (2018-03-20 06:40:48)
> From: Tali Perry <tali.perry1@gmail.com>
> 
> * Nuvoton NPCM7XX Clock Controller
> 
> Nuvoton Poleg BMC NPCM7XX contains an integrated clock controller, which
> generates and supplies clocks to all modules within the BMC.
> 
> ---
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
> 
> Signed-off-by: Tali Perry <tali.perry1@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

But this part goes before the triple dash. I'll apply it and fix it up
on clk-next.
