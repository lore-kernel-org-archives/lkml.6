Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeECPYV convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 11:24:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34087 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeECPYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 11:24:20 -0400
Date: Thu, 3 May 2018 17:24:18 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v4.14.29-rt25
Message-ID: <20180503152417.sztoptu5fcbw2b5h@linutronix.de>
References: <20180325101204.ibuvdpnusv3vutyc@linutronix.de>
 <b04275af-000d-7b29-3031-508c9a01cd91@ti.com>
 <20180420171116.w2hxytgzvp4jgpyl@linutronix.de>
 <764d0abc-7e88-a696-17a0-0bf807148d5b@ti.com>
 <20180423191023.qtinidsq4vj3lmha@linutronix.de>
 <8933b3b9-7f70-0f3f-a8b8-19d4369b35d4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <8933b3b9-7f70-0f3f-a8b8-19d4369b35d4@ti.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-01 10:04:13 [-0500], Grygorii Strashko wrote:
> Hi Sebastian,
Hi Grygorii,

> Sry, it took some time as i found some instability -
> test "stress-ng --class os --all 0 -t 5m " not always finished :(
> So, I've tried to rollback to v4.14.29-rt25 and use as TI RT kernel as
> pure rt-devel. Still not sure if this is some sort of regression or not.

is this new? So v4.14.29-rt25 works and v4.14.29-rt25 with this does
not? This patch just silences the warning so it should not break
anything…

Sebastian
