Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033056AbeCAQsA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:48:00 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51675 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031589AbeCAQr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:47:58 -0500
Date: Thu, 1 Mar 2018 17:47:55 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Haris Okanovic <haris.okanovic@ni.com>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, julia.cartwright@ni.com, gratian.crisan@ni.com,
        anna-maria@linutronix.de
Subject: Re: [PATCH v3 2/2] timers: Don't search for expired timers while
 TIMER_SOFTIRQ is scheduled
Message-ID: <20180301164755.pipco45y5nlvmdsy@linutronix.de>
References: <alpine.DEB.2.20.1707182206110.2425@nanos>
 <20170803210657.19179-1-haris.okanovic@ni.com>
 <20170803210657.19179-2-haris.okanovic@ni.com>
 <28f05e39-6bc6-99c5-e1bc-91be3e79ea78@ni.com>
 <13c06708-f7ad-4f46-1c0b-f12d1ca16beb@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13c06708-f7ad-4f46-1c0b-f12d1ca16beb@ni.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-01 09:49:59 [-0600], Haris Okanovic wrote:
> *bump* Has anyone looked into this?

I'm lost. 
It entered the kernel in v4.9.9-rt6 and left in v4.9.30-rt20 once we
figured out that there is something wrong with it.
Is it still in a RT tree somewhere?
Is there a newer patch pending on your side?

Sebastian
