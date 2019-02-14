Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECEBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83948217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406486AbfBNVrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:47:32 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51392 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406222AbfBNVrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:47:32 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1guOqu-0002TL-Uy; Thu, 14 Feb 2019 22:47:29 +0100
Date:   Thu, 14 Feb 2019 22:47:28 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()")
 may have revealed another problem
In-Reply-To: <48a2817e-4133-967e-7e57-eea2f547cb01@gmail.com>
Message-ID: <alpine.DEB.2.21.1902142245170.1646@nanos.tec.linutronix.de>
References: <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com> <alpine.DEB.2.21.1808241000340.1668@nanos.tec.linutronix.de> <20180824143056.GC2730@lerouge> <d8fd3322-e982-2c9c-85e3-9b1770357520@gmail.com> <20180828022545.GA25943@lerouge>
 <alpine.DEB.2.21.1809271805190.8118@nanos.tec.linutronix.de> <20180928131855.GB8795@lerouge> <c472b6bf-e4af-d807-e63f-75211ce295bd@gmail.com> <20181227065321.GA3749@lerouge> <e838fa7f-f43f-7b3c-aae6-edb4f6734964@gmail.com> <20190116062408.GA26169@lenoir>
 <f60567f7-fa7e-f424-12e6-b3df7a24c0be@gmail.com> <48a2817e-4133-967e-7e57-eea2f547cb01@gmail.com>
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

On Thu, 14 Feb 2019, Heiner Kallweit wrote:
> On 24.01.2019 20:37, Heiner Kallweit wrote:
> >>
> > Hi Frederic,
> > is the update debug patch still to come?

Heiner, there is a related fix queued in

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core

See also:
    https://lkml.kernel.org/r/20190128234625.78241-3-mka@chromium.org
    https://lkml.kernel.org/r/20190128234625.78241-2-mka@chromium.org

Can you please have a look?

Thanks,

	tglx
