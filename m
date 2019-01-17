Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D590FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD08120851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfAQXT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:19:56 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48057 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfAQXT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:19:56 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gkGwr-000184-Hq; Fri, 18 Jan 2019 00:19:45 +0100
Date:   Fri, 18 Jan 2019 00:19:44 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: linux-next: Fixes tag needs some work in the tip tree
In-Reply-To: <20190118093515.4bee6eb3@canb.auug.org.au>
Message-ID: <alpine.DEB.2.21.1901180019050.1647@nanos.tec.linutronix.de>
References: <20190118093515.4bee6eb3@canb.auug.org.au>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven,

On Fri, 18 Jan 2019, Stephen Rothwell wrote:
> Commit
> 
>   f0ca26ca4f36 ("genirq: Fix the kerneldoc comment for struct irq_affinity_desc")
> 
> Fixes tag
> 
>   Fixes: Commit c410abbbacb9 ("genirq/affinity: Add is_managed to struct irq_affinity_desc")
> 
> has these problems:
> 
>   - No SHA1 recognised
> 
> The word "Commit" is unexpected in the Fixes tag line.

Ooops. Missed that one. Fixed now.

Thanks,

	tglx
