Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E98C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5162C20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5162C20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeJZCFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:05:43 -0400
Received: from muru.com ([72.249.23.125]:52912 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbeJZCFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:05:42 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BA1838027;
        Thu, 25 Oct 2018 17:31:57 +0000 (UTC)
Date:   Thu, 25 Oct 2018 10:31:55 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, Eyal Reizer <eyalr@ti.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: Regression: OOPs on boot due to "wlcore: Add support for
 optional wakeirq"
Message-ID: <20181025173155.GB31348@atomide.com>
References: <CALAqxLVOEVP2g6tPc1RF8mEgfffwWVHSuwrvv_a+oB2d0Jp8rg@mail.gmail.com>
 <CALAqxLWEMXAUeNA3DJS9Nx10VvwkqU0G15h7WPP2QepFi5X4hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLWEMXAUeNA3DJS9Nx10VvwkqU0G15h7WPP2QepFi5X4hw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* John Stultz <john.stultz@linaro.org> [181025 17:15]:
> On Thu, Oct 25, 2018 at 10:04 AM, John Stultz <john.stultz@linaro.org> wrote:
> > Should we check wakeirq before we set the second elements of res[]?
> 
> Here's my first swing at doing the above. It seems to work ok. Let me
> know if it looks reasonable and I'll submit it as a proper patch.
> 
> https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey-mainline-WIP&id=383fb6e3abb71b8a721f196120a2e3a9da3315ac

Yes thanks for fixing it, looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
