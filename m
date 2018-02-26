Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752300AbeBZIuC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:50:02 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35929 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbeBZIt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:49:58 -0500
X-Google-Smtp-Source: AG47ELvGYHIgvrr4KnUKRHG7rai7DRnLdYSbHWPnAeOUcCMCbN3uC/SopN0BDRlfP5ggqL878/7Zsw==
Date: Mon, 26 Feb 2018 11:49:55 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, willy@infradead.org, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, peterz@infradead.org,
        luto@amacapital.net, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] x86/boot/compressed/64: Prepare trampoline memory
Message-ID: <20180226084955.GB5308@uranus.lan>
References: <20180209142228.21231-4-kirill.shutemov@linux.intel.com>
 <tip-b91993a87aff6dafd60a9c8ce80ebc425161a815@git.kernel.org>
 <20180224214818.GD29374@pd.tnic>
 <20180225105205.xicklkl3n5azdw2j@node.shutemov.name>
 <20180226073552.xabt55ukp24inut5@gmail.com>
 <20180226080256.j7jzuxyokx42uytd@node.shutemov.name>
 <20180226081533.GA5308@uranus.lan>
 <20180226083709.al5pvzwzyxuci4qp@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226083709.al5pvzwzyxuci4qp@node.shutemov.name>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 11:37:09AM +0300, Kirill A. Shutemov wrote:
> On Mon, Feb 26, 2018 at 11:15:34AM +0300, Cyrill Gorcunov wrote:
> > On Mon, Feb 26, 2018 at 11:02:56AM +0300, Kirill A. Shutemov wrote:
> > ...
> > > > Also, could do a puts() hexdump of the affected memory area _before_ we overwrite 
> > > > it? Is it empty? Could we add some debug warning that checks that it's all zeroes?
> > > 
> > > The problem is that we don't really have a way get a message out of there.
> > > 
> > > http://lkml.kernel.org/r/793b9c55-e85b-97b5-c857-dd8edcda4081@zytor.com
> > > 
> > 
> > I'm sorry for stepping in (since I didn't follow the series in details)
> > but can't we use vga memory here and print this early data tere?
> 
> I have no idea how to do this :/

https://wiki.osdev.org/Printing_To_Screen

Kirill, note that it might not do the trick at all, just give
the link a shot and check if it would worth the efforts.

> 
> And what about systems without monitor at all?

Such early boot things *require* additional equipment
anyway jtag/monitors/etc for debug stage at least.
