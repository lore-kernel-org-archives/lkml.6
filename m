Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965183AbeBMRRt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:17:49 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38562 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934602AbeBMRRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:17:47 -0500
X-Google-Smtp-Source: AH8x225wAh/2HDB9X1wjm6H9q/kbyDbWneDWgGIPlnpGhp0/0flM6jPmah1Rgmu3ynZnya3YPw6cQQ==
Date: Tue, 13 Feb 2018 18:17:43 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andrei Vagin <avagin@virtuozzo.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
        tip-bot for Jacob Shin <tipbot@zytor.com>,
        kirill.shutemov@linux.intel.com, linux-tip-commits@vger.kernel.org,
        tglx@linutronix.de, willy@infradead.org, gorcunov@openvz.org,
        bp@suse.de, peterz@infradead.org, torvalds@linux-foundation.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, luto@amacapital.net
Subject: Re: [tip:x86/boot] x86/boot/compressed/64: Handle 5-level paging
 boot if kernel is above 4G
Message-ID: <20180213171742.ssblqj37l5daxc4s@gmail.com>
References: <tip-b4b56015ed1c98cbc9469e35ebbc4373a2844030@git.kernel.org>
 <20180213065155.GA14087@outlook.office365.com>
 <20180213080816.vwh64jiz23frjiot@node.shutemov.name>
 <20180213084121.GA19906@outlook.office365.com>
 <20180213090249.vnjwitt657jabnlt@node.shutemov.name>
 <20180213165337.GA20735@outlook.office365.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213165337.GA20735@outlook.office365.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrei Vagin <avagin@virtuozzo.com> wrote:

> On Tue, Feb 13, 2018 at 12:02:49PM +0300, Kirill A. Shutemov wrote:
> > On Tue, Feb 13, 2018 at 12:41:22AM -0800, Andrei Vagin wrote:
> > > On Tue, Feb 13, 2018 at 11:08:16AM +0300, Kirill A. Shutemov wrote:
> > > > On Mon, Feb 12, 2018 at 10:51:56PM -0800, Andrei Vagin wrote:
> > > > > Hi Kirill,
> > > > > 
> > > > > Something is wrong in this patch.
> > 
> > Could you please check if this makes a difference?
> 
> The kernel booted with this patch. Thanks!
> https://travis-ci.org/avagin/linux/jobs/341030882

Fantastic, thanks for the help!

I've amended the commit to keep the series bisectable, and added these two tags:

 Debugged-by: "Kirill A. Shutemov" <kirill@shutemov.name>
 Tested-by: "Kirill A. Shutemov" <kirill@shutemov.name>

To credit your debugging/testing help.

Thanks,

	Ingo
