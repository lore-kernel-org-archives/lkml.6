Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbeEBNhd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:37:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54086 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbeEBNhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:37:31 -0400
Date: Wed, 2 May 2018 15:37:30 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
cc: linux-kernel@vger.kernel.org, diego.viola@gmail.com,
        len.brown@intel.com, rjw@rjwysocki.net, rui.zhang@intel.com
Subject: Re: [PATCH v2 3/7] clocksource: Initialize cs->wd_list
In-Reply-To: <20180430100344.472662715@infradead.org>
Message-ID: <alpine.DEB.2.21.1805021536460.1560@nanos.tec.linutronix.de>
References: <20180430100008.503783478@infradead.org> <20180430100344.472662715@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2018, Peter Zijlstra wrote:

> A number of places relies on list_empty(&cs->wd_list), however the
> list_head does not get initialized. Do so upon registration, such that
> thereafter it is possible to rely on list_empty() correctly reflecting
> the list membership status.
> 
> Tested-by: Diego Viola <diego.viola@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

The next patch is marked for stable, but this one not. Confused

Thanks,

	tglx
