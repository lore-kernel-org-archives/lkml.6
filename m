Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeBWGzu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 01:55:50 -0500
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:54860 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751350AbeBWGzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 01:55:49 -0500
Date: Fri, 23 Feb 2018 08:55:44 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: esc.storagedev@microsemi.com
cc: linux-scsi@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: hpsa crashes on boot in 4.16-rc2-00062
In-Reply-To: <alpine.LRH.2.21.1802222043240.9192@math.ut.ee>
Message-ID: <alpine.LRH.2.21.1802230854420.27999@math.ut.ee>
References: <alpine.LRH.2.21.1802222043240.9192@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This happens on a HP DL360 G6 with Smart Array 410i.
> 
> Will try to bisect.
> 
> IO completion timeout could be because of some IRQ toubles?

Reverting 84676c1f21e8ff54befe985f4f14dc1edc10046b fixes it for me (as 
suggested by Laurence Oberman).

-- 
Meelis Roos (mroos@linux.ee)
