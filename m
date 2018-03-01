Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032713AbeCAPya (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:54:30 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51492 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031978AbeCAPy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:54:28 -0500
Date: Thu, 1 Mar 2018 16:54:25 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Haris Okanovic <haris.okanovic@ni.com>
cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, julia.cartwright@ni.com, gratian.crisan@ni.com,
        anna-maria@linutronix.de
Subject: Re: [PATCH v3 2/2] timers: Don't search for expired timers while
 TIMER_SOFTIRQ is scheduled
In-Reply-To: <13c06708-f7ad-4f46-1c0b-f12d1ca16beb@ni.com>
Message-ID: <alpine.DEB.2.21.1803011651150.1396@nanos.tec.linutronix.de>
References: <alpine.DEB.2.20.1707182206110.2425@nanos> <20170803210657.19179-1-haris.okanovic@ni.com> <20170803210657.19179-2-haris.okanovic@ni.com> <28f05e39-6bc6-99c5-e1bc-91be3e79ea78@ni.com> <13c06708-f7ad-4f46-1c0b-f12d1ca16beb@ni.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.21.1803011653561.1396@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2018, Haris Okanovic wrote:

> *bump* Has anyone looked into this?

I have, but it's still in my melted spectrum induced backlog and it does
not apply anymore :)

Thanks,

	tglx
