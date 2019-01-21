Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2ABC2F3A6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846D82084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfAUNMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:12:22 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52991 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfAUNMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:12:21 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1glZN5-0003Wr-0v; Mon, 21 Jan 2019 14:12:11 +0100
Date:   Mon, 21 Jan 2019 14:12:10 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
In-Reply-To: <20190121122131.GG4020@osiris>
Message-ID: <alpine.DEB.2.21.1901211411290.1582@nanos.tec.linutronix.de>
References: <20181127081115.GB3625@osiris> <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de> <20181129112321.GB3449@osiris> <20190121122131.GG4020@osiris>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019, Heiko Carstens wrote:

> Hi Thomas,
> 
> [full quote below]
> 
> Did you have any time to look into this yet? :)
> 
> The warning is still reproducible.

Yeah, it's on my list of stuff which I need to take care of urgently. In
the next couple of days I hope...

Thanks,

	tglx
