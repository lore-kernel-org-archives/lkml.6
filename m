Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE62C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361902082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361902082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeKCGKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:10:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59711 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeKCGKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:10:10 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gIgZK-0006wQ-82; Fri, 02 Nov 2018 22:01:26 +0100
Date:   Fri, 2 Nov 2018 22:01:25 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
cc:     Guo Ren <ren_guo@c-sky.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] timer for tip/urgent
In-Reply-To: <d99ed466-b11a-b931-fc7a-a555cae80a53@linaro.org>
Message-ID: <alpine.DEB.2.21.1811022159420.3160@nanos.tec.linutronix.de>
References: <d99ed466-b11a-b931-fc7a-a555cae80a53@linaro.org>
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

Daniel,

On Fri, 2 Nov 2018, Daniel Lezcano wrote:

> this is a late pull request for the c-sky clocksource and clockevent.
> These are new drivers, they passed the review process several times for
> the c-sky architecture.
> 
>  - Add the per cpu timer for the c-sky architecture (Guo Ren)
> 
>  - Add the global timer for the c-sky architecture (Guo Ren)

Pulled. Can you please tag your pull requests in future and add the above
short summary into the tag. That automatically creates a merge commit and I
get the summary right into it.

Thanks,

	tglx
