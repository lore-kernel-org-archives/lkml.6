Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754586AbeBGQZZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:25:25 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40016 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754381AbeBGQZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:25:24 -0500
Date: Wed, 7 Feb 2018 17:25:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/3] x86: Patchable constants
Message-ID: <20180207162507.GB25219@hirez.programming.kicks-ass.net>
References: <20180207145913.2703-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207145913.2703-1-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 05:59:10PM +0300, Kirill A. Shutemov wrote:
> This conversion makes GCC generate worse code. Conversion __PHYSICAL_MASK
> to a patchable constant adds about 5k in .text on defconfig and makes it
> slightly slower at runtime (~0.2% on my box).

Do you have explicit examples for the worse code? That might give clue
on how to improve things.
