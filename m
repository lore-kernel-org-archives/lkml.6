Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeBYM3t (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 07:29:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:48003 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751653AbeBYM3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 07:29:48 -0500
Date: Sun, 25 Feb 2018 13:29:24 +0100
From: Borislav Petkov <bp@suse.de>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, willy@infradead.org, hpa@zytor.com,
        mingo@kernel.org, kirill.shutemov@linux.intel.com,
        peterz@infradead.org, gorcunov@openvz.org, luto@amacapital.net,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] x86/boot/compressed/64: Prepare trampoline memory
Message-ID: <20180225122924.GB26323@pd.tnic>
References: <20180209142228.21231-4-kirill.shutemov@linux.intel.com>
 <tip-b91993a87aff6dafd60a9c8ce80ebc425161a815@git.kernel.org>
 <20180224214818.GD29374@pd.tnic>
 <20180225105205.xicklkl3n5azdw2j@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180225105205.xicklkl3n5azdw2j@node.shutemov.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2018 at 01:52:05PM +0300, Kirill A. Shutemov wrote:
> Could you check if the patch below makes a difference?
> 
> If it is, could you check 0x9d000 address instead of 0x99000?

Both don't make a difference.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
