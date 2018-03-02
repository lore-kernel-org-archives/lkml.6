Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034385AbeCBQjG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:39:06 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54544 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034309AbeCBQjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:39:03 -0500
Date: Fri, 2 Mar 2018 17:39:01 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Haris Okanovic <haris.okanovic@ni.com>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, julia.cartwright@ni.com, gratian.crisan@ni.com,
        anna-maria@linutronix.de
Subject: Re: [PATCH v3 2/2] timers: Don't search for expired timers while
 TIMER_SOFTIRQ is scheduled
Message-ID: <20180302163900.ldnkhgsvqxlki4ju@linutronix.de>
References: <alpine.DEB.2.20.1707182206110.2425@nanos>
 <20170803210657.19179-1-haris.okanovic@ni.com>
 <20170803210657.19179-2-haris.okanovic@ni.com>
 <28f05e39-6bc6-99c5-e1bc-91be3e79ea78@ni.com>
 <13c06708-f7ad-4f46-1c0b-f12d1ca16beb@ni.com>
 <20180301164755.pipco45y5nlvmdsy@linutronix.de>
 <7079102c-f53b-e8ab-c54d-1c40ff21d921@ni.com>
 <20180302145232.anp4hz25uwqygopa@linutronix.de>
 <98f4236e-9863-2af7-1170-51cd118f65bd@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98f4236e-9863-2af7-1170-51cd118f65bd@ni.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-02 10:29:56 [-0600], Haris Okanovic wrote:
> > Could please point me to the code/patches or something?
> 
> I rebase onto v4.14.20-rt17, running some sanity test before reposting to ml
> (cyclictest & Anna's timertest). Will post V4 sometime today (US Central
> Time) if everything goes well.
> 
> Are you also asking for a 4.9 version? I'm fine leaving it out of 4.9.

Hmmm. Maybe this is a form of miscommunication here :)
So my understanding is that you complain/ask why there is an older
version of the patch still in v4.9-RT:

|It was added back into 4.9 at some point after v4.9.30-rt20. I see an older
|version in v4.9.68-rt60, for example, hence my original email. It was dropped
|sometime thereafter, presumably because it no longer cleanly applies. I don't
|see it in v4.14.20-rt17, for example.

So I ask where you see the old version of your patch in v4.9-RT. Yes it
was added, then removed and it never appeared back in. However, I don't
see anymore in v4.9.68-rt60.

> -- Haris

Sebastian
