Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754921AbeDWLtD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 07:49:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33468 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754793AbeDWLtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 07:49:00 -0400
Date: Mon, 23 Apr 2018 13:48:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Diego Viola <diego.viola@gmail.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, len.brown@intel.com,
        rui.zhang@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Experiencing freezes with kernel 4.16.3 on a desktop with E5500
 CPU (bisect included)
Message-ID: <20180423114850.GK4082@hirez.programming.kicks-ass.net>
References: <CA+ToGPE59B0EKYkRbMcoddEtWwe50nXNu-91UMdjamz+s8nKfg@mail.gmail.com>
 <20180423091633.GU4064@hirez.programming.kicks-ass.net>
 <CA+ToGPEaHb1ueDRGuzCzm_HxketqxW8j1gawEsCCp2QGLCA=xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ToGPEaHb1ueDRGuzCzm_HxketqxW8j1gawEsCCp2QGLCA=xg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 08:23:24AM -0300, Diego Viola wrote:
> > That's a Core2 era chip; does it actually have stable TSC ?
> 
> I'm not sure.

dmesg | grep -i tsc

should be able to tell you.
