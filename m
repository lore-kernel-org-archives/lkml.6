Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeEPUZD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 16:25:03 -0400
Received: from foss.arm.com ([217.140.101.70]:54416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeEPUZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 16:25:00 -0400
Date: Wed, 16 May 2018 15:24:58 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] coresight: documentation: update sysfs section
Message-Id: <20180516152458.d392b0d1e09393da30e2aeb6@arm.com>
In-Reply-To: <20180516131823.4b1a3ecb@lwn.net>
References: <20180507172915.c032cd71c07b1849bf419a5f@arm.com>
        <CANLsYkyQLan3XajOz2uuoOF8OQchGfeu2ZkZJ9H1Xm9q==aXTw@mail.gmail.com>
        <20180514121959.a9a3d2fb3d3d270849ffbc39@arm.com>
        <20180516131823.4b1a3ecb@lwn.net>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018 13:18:23 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> On Mon, 14 May 2018 12:19:59 -0500
> Kim Phillips <kim.phillips@arm.com> wrote:
> 
> > - Align and show updated ls devices output from the TC2, based on
> >   current driver
> > 
> > - Provide an example from an ETMv4 based system (Juno)
> > 
> > - Reflect changes to the way the RAM write pointer is accessed since
> >   it got changed in commit 7d83d17795ef ("coresight: tmc: adding sysFS
> >   management entries").
> 
> So I was going to apply this, but it's been pretty badly corrupted by
> your mailer.  Could I ask you to retry, please?

I had sent a v3 that corrected the issue, in the same thread, here:

https://lkml.org/lkml/2018/5/14/1190

Mathieu acked that one.

Thanks,

Kim
