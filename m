Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754203AbeEOQpn convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:45:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60812 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbeEOQpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:45:41 -0400
Date: Tue, 15 May 2018 18:45:39 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mike Galbraith <efault@gmx.de>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [patch-rt] sched,fair: Fix CFS bandwidth control  lockdep
 DEADLOCK report
Message-ID: <20180515164538.w4nnuqkkjj6lnp5c@linutronix.de>
References: <20180503162934.b2ly6jz4a5tydaag@linutronix.de>
 <1525414478.6761.5.camel@gmx.de>
 <20180504104802.33e9a52f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180504104802.33e9a52f@gandalf.local.home>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-04 10:48:02 [-0400], Steven Rostedt wrote:
> On Fri, 04 May 2018 08:14:38 +0200
> Mike Galbraith <efault@gmx.de> wrote:
> 
…
> Looks good to me.
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

trimmed commit message, tagged stable, applied.

> -- Steve

Sebastian
