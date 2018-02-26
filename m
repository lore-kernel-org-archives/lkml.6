Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeBZUzk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 15:55:40 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36806 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeBZUzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 15:55:37 -0500
X-Google-Smtp-Source: AH8x227VrT9dnkNpVbUkqZXJ/bBeGYa98s6V2AApE5T8HvJAMYgmyJsA0hlCCvdEk+TXYX9nIB7a4Q==
Date: Mon, 26 Feb 2018 23:55:27 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Borislav Petkov <bp@suse.de>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Andi Kleen <ak@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] x86/boot/compressed/64: Prepare trampoline memory
Message-ID: <20180226205527.6m6h55h6r2cgh5hq@node.shutemov.name>
References: <20180226180451.86788-1-kirill.shutemov@linux.intel.com>
 <20180226193244.GH14140@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226193244.GH14140@pd.tnic>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 08:32:44PM +0100, Borislav Petkov wrote:
> On Mon, Feb 26, 2018 at 09:04:46PM +0300, Kirill A. Shutemov wrote:
> > Borislav, could you check which patch breaks boot for you (if any)?
> 
> What is that ontop? tip/master from today or?

I made it on top of tip/x86/mm, but tip/master should be fine too.

-- 
 Kirill A. Shutemov
