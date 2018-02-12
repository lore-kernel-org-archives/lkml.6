Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753862AbeBLQrc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:47:32 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39631 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753789AbeBLQra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:47:30 -0500
X-Google-Smtp-Source: AH8x226qvmF13/2i8FvHxWyLvZE2IJALIcqiaWnZ2/uWhyvmBRaeCX2dtOEaeZ0uZEnoC9hQ04gYMQ==
Date: Mon, 12 Feb 2018 08:47:26 -0800
From: Tejun Heo <tj@kernel.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com,
        morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, alessio.balsini@arm.com
Subject: Re: [RFC PATCH 2/3] sched/deadline: add task groups bandwidth
 management support
Message-ID: <20180212164726.GT695913@devbig577.frc2.facebook.com>
References: <20180212134030.12846-1-juri.lelli@redhat.com>
 <20180212134030.12846-3-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212134030.12846-3-juri.lelli@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Feb 12, 2018 at 02:40:29PM +0100, Juri Lelli wrote:
>  - implementation _is not_ hierarchical: only single/plain DEADLINE entities
>    can be handled, and they get scheduled at root rq level

This usually is a deal breaker and often indicates that the cgroup
filesystem is not the right interface for the feature.  Can you please
elaborate the interface with some details?

Thanks.

-- 
tejun
