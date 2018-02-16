Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeBPEsl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 23:48:41 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33064 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752450AbeBPEsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 23:48:39 -0500
X-Google-Smtp-Source: AH8x227s/qJBt8degz+hXbD9NNw7u1zl2NmMnVdLvvJa6BRlV+PteywBsjpNvsAiN8/wJJbGUCNQuw==
Date: Fri, 16 Feb 2018 07:48:35 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/3] proc: randomize "struct pde_opener"
Message-ID: <20180216044835.GB7811@avx2>
References: <20180214063033.GA15579@avx2>
 <20180214081935.GA17157@avx2>
 <20180215190713.GF30522@ZenIV.linux.org.uk>
 <20180215214113.GA27190@avx2>
 <20180216001317.GG30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216001317.GG30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 12:13:17AM +0000, Al Viro wrote:
> On Fri, Feb 16, 2018 at 12:41:13AM +0300, Alexey Dobriyan wrote:
> > On Thu, Feb 15, 2018 at 07:07:13PM +0000, Al Viro wrote:
> > > On Wed, Feb 14, 2018 at 11:19:35AM +0300, Alexey Dobriyan wrote:
> > > 
> > > > The more the merrier.
> > > 
> > > ITYM "Sanity is overrated anyway."
> > 
> > If you view annotations as debugging option the thing is not that bad.
> 
> Yes, if your goal is to debug gcc.  Look, randomize_layout is a bad idea,
> with worse implementation.  It's security theatre with no real benefits,
> it makes for much harder kernel debugging, it buggers cachelines without
> noticing *AND* it triggers gcc version-dependent miscompiles that
> cheerfully cause memory corruption.

So at least gcc people should all enable it. :^)
