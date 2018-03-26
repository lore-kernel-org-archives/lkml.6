Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbeCZNTN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 09:19:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36040 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeCZNTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 09:19:11 -0400
X-Google-Smtp-Source: AIpwx494k0INDSJl5ajNHinGrQ4y/GHvMidypFtn37wa2NDKYWOWvRmGY67gbhdO5FZsfNZUDctSUA==
Date: Mon, 26 Mar 2018 14:19:07 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Aniruddha Banerjee <aniruddhab@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>,
        Thierry Reding <treding@nvidia.com>, Vipin Kumar <vipink@nvidia.com>
Subject: Re: [RFC PATCH] irqchip: arm-gic: take gic_lock when updating irq
 type
Message-ID: <20180326131907.3m3sfwxvyzuli2ps@holly.lan>
References: <c20f41d47ed9444b9050bc1f609d4bbe@bgmail101.nvidia.com>
 <77ac9d88-e99e-c507-66b2-cc14f06ce192@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77ac9d88-e99e-c507-66b2-cc14f06ce192@arm.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 12:19:15PM +0000, Marc Zyngier wrote:
> On 22/03/18 10:28, Aniruddha Banerjee wrote:
> [a PGP-encrypted email]
> 
> Given that you're cc-ing various mailing lists, please resend this email
> unencrypted.

I am very puzzled about what is going on here. I could read the 
original mail fine and I was not in To: or Cc:. It also seems to
have made it through to the archives OK.

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1645375.html
https://www.spinics.net/lists/linux-tegra/msg32829.html


Daniel.
