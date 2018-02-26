Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbeBZTdH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:33:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:42648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751454AbeBZTdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:33:06 -0500
Date: Mon, 26 Feb 2018 20:32:44 +0100
From: Borislav Petkov <bp@suse.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Andi Kleen <ak@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] x86/boot/compressed/64: Prepare trampoline memory
Message-ID: <20180226193244.GH14140@pd.tnic>
References: <20180226180451.86788-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180226180451.86788-1-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 09:04:46PM +0300, Kirill A. Shutemov wrote:
> Borislav, could you check which patch breaks boot for you (if any)?

What is that ontop? tip/master from today or?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
