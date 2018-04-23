Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754793AbeDWKjq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:39:46 -0400
Received: from foss.arm.com ([217.140.101.70]:38786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754597AbeDWKjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:39:43 -0400
Date: Mon, 23 Apr 2018 11:39:39 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        will.deacon@arm.com, catalin.marinas@arm.com, suzuki.poulose@arm.com
Subject: Re: BUG: KASAN: global-out-of-bounds in
 unmap_kernel_at_el0+0x70/0x1a0
Message-ID: <20180423103938.xbzdrhnzic4zby5w@lakrids.cambridge.arm.com>
References: <97d99ad9-c5cf-a4d2-126a-2b39ffead0b3@web.de>
 <20180422190639.lyfvgnzapo2mrpu6@salmiak>
 <b14575e7-c862-fb7c-b776-86976e68f4b7@web.de>
 <20180423102909.ra2n6tqvwcn7oash@lakrids.cambridge.arm.com>
 <02ba4513-7913-6415-5252-9cb7d75f3687@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02ba4513-7913-6415-5252-9cb7d75f3687@web.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 12:33:17PM +0200, Jan Kiszka wrote:
> On 2018-04-23 12:29, Mark Rutland wrote:
> > On Mon, Apr 23, 2018 at 07:00:52AM +0200, Jan Kiszka wrote:
> >> On 2018-04-22 21:06, Mark Rutland wrote:
> > 
> >>> Does the below help?

[...]

> >> Jep, all fine now!
> > 
> > Cool. Can I take that as a Tested-by?
> 
> Yes, sorry:
> 
> Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Jan

Cheers!

I'll fix up the reported-by address likewise, and send this out as a
patch.

Thanks,
Mark.
