Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49E82601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932393AbeFFJPe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:15:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49168 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932265AbeFFJPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:15:33 -0400
Date: Wed, 6 Jun 2018 11:15:31 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Pingfan Liu <kernelfans@gmail.com>
cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: question about the limited interrupt vector resource on a single
 cpu
In-Reply-To: <CAFgQCTudugoNc26P22V+G_awzj2srKHhWBJubFoa7-K=cDtQyw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806061114290.1584@nanos.tec.linutronix.de>
References: <CAFgQCTudugoNc26P22V+G_awzj2srKHhWBJubFoa7-K=cDtQyw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2018, Pingfan Liu wrote:

> For x86, there is around 200 vectors left for external device on a
> single logic cpu.
>
> Is there any case that we exhaust them in real world, and is it worth to fix?

Exhaustion is unlikely, but how would you fix it? The vector space per CPU
is limited by hardware not software.

Thanks,

	tglx
