Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeDQPbi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:31:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54646 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750741AbeDQPbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:31:37 -0400
Date: Tue, 17 Apr 2018 17:31:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?B?SsO2cmc=?= Otte <jrg.otte@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: 4.17.0-rc1 doesn't boot.
Message-ID: <20180417153101.GB2894@pd.tnic>
References: <CADDKRnAp1EKCAosD-kLNRaJ4qJppUtmmP1n76wzcvNUVa0fQzg@mail.gmail.com>
 <20180417081458.GA2894@pd.tnic>
 <CADDKRnDmycResXxAsfYfM6sFoWffD_v_cMoR4XF7OxUps3mU+Q@mail.gmail.com>
 <20180417142715.GL18640@pd.tnic>
 <CADDKRnBtQKz5S3EdJbrVH8PN9_qTrSQ3owcK=PfxToHdxpu8rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADDKRnBtQKz5S3EdJbrVH8PN9_qTrSQ3owcK=PfxToHdxpu8rA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 05:21:30PM +0200, Jörg Otte wrote:
> finished bisection.
> 39114b7a743e6759bab4d96b7d9651d44d17e3f9 is the first bad commit
> (x86/pti: Never implicitly clear _PAGE_GLOBAL for kernel image).

Looks like you're not the only one:

http://marc.info/?i=20180417150130.GA11166@ak-laptop.emea.nsn-net.net

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
