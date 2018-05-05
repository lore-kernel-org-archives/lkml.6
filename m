Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbeEEJyD (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:54:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35276 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbeEEJyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:54:02 -0400
Date: Sat, 5 May 2018 11:53:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?B?SsO2cmc=?= Otte <jrg.otte@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [v4.17-rcx] Lost IBPB, IBRS_FW support for spectre_v2 mitigation.
Message-ID: <20180505095335.GA3708@pd.tnic>
References: <alpine.DEB.2.21.1804302151530.1596@nanos.tec.linutronix.de>
 <CADDKRnAi69PFNH-hyxCTLckJ5UU6-DKWvzGNzxZZhD0sA215qg@mail.gmail.com>
 <alpine.DEB.2.21.1805011458390.1596@nanos.tec.linutronix.de>
 <CA+55aFxKbPDrMQssyEtOnYZqE8HcOo=Zx6ASty6CybhwPfT9_g@mail.gmail.com>
 <CADDKRnC1V3KUR__PAo_JhMVdaWknQ9x1_XAQNewUWuO3cqFFFg@mail.gmail.com>
 <alpine.DEB.2.21.1805021043510.1668@nanos.tec.linutronix.de>
 <CADDKRnBn7rNN9UrwtYvNDPeJxqNQ-WHQVyHXAV7RwcVxX7jSDw@mail.gmail.com>
 <alpine.DEB.2.21.1805021418550.1560@nanos.tec.linutronix.de>
 <20180504161815.GG9257@pd.tnic>
 <CADDKRnDU6gt4a0UaPkjHOE+8iZCoZ1DXw06Fx7y6=Ge+trhbOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADDKRnDU6gt4a0UaPkjHOE+8iZCoZ1DXw06Fx7y6=Ge+trhbOQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 11:47:53AM +0200, Jörg Otte wrote:
> Patch doesn't hurt me. For me it´s ok.
> 
> Thanks, Jörg

Good, thanks for testing!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
