Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751705AbeBYOKK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 09:10:10 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54086 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbeBYOKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 09:10:07 -0500
X-Google-Smtp-Source: AH8x224/W1A+5KhoNS0SogZ3VZWNYiHs4iTaDTMncYEYJE8XsKfgwsG/pMA4S49crecdwKy2HkZYkw==
Date: Sun, 25 Feb 2018 17:09:58 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Borislav Petkov <bp@suse.de>
Cc: tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, willy@infradead.org, hpa@zytor.com,
        mingo@kernel.org, kirill.shutemov@linux.intel.com,
        peterz@infradead.org, gorcunov@openvz.org, luto@amacapital.net,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] x86/boot/compressed/64: Prepare trampoline memory
Message-ID: <20180225140958.76brtollupvrbuwy@node.shutemov.name>
References: <20180209142228.21231-4-kirill.shutemov@linux.intel.com>
 <tip-b91993a87aff6dafd60a9c8ce80ebc425161a815@git.kernel.org>
 <20180224214818.GD29374@pd.tnic>
 <20180225105205.xicklkl3n5azdw2j@node.shutemov.name>
 <20180225122924.GB26323@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180225122924.GB26323@pd.tnic>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2018 at 01:29:24PM +0100, Borislav Petkov wrote:
> On Sun, Feb 25, 2018 at 01:52:05PM +0300, Kirill A. Shutemov wrote:
> > Could you check if the patch below makes a difference?
> > 
> > If it is, could you check 0x9d000 address instead of 0x99000?
> 
> Both don't make a difference.

Hm. Could you share dmesg from the kernel that works fine?

-- 
 Kirill A. Shutemov
