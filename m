Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeCVVBr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 17:01:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56996 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751713AbeCVVBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 17:01:46 -0400
Date: Thu, 22 Mar 2018 22:01:44 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Patrice CHOTARD <patrice.chotard@st.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-soc tree
Message-ID: <20180322210144.GB3417@piout.net>
References: <20180316075629.019b6560@canb.auug.org.au>
 <CAK8P3a2-fUi0nnsLVJ6h_UuJCgwoNs2OEroYed2ofLd=FiPG0g@mail.gmail.com>
 <6b239ab5-5ded-b32b-eefc-601075d33f25@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b239ab5-5ded-b32b-eefc-601075d33f25@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2018 at 07:34:06 +0000, Patrice CHOTARD wrote:
> Hi Arnd, Stephen
> 
> On 03/15/2018 10:06 PM, Arnd Bergmann wrote:
> > On Thu, Mar 15, 2018 at 9:56 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >> Hi all,
> >>
> >> Commit
> >>
> >>    9a5f4879cd8d ("ARM: dts: stih4xx: Add missing #sound-dai-cells")
> >>
> >> is missing a Signed-off-by from its committer.
> > 
> > Thanks for the report.
> > 
> > What script do you use to find those? I guess I should check for
> > missing signoffs as well when pulling a branch.
> > 
> > Patrice, I've dropped the merge now, and picked up the one
> > patch in it directly, with my signoff. This should fix the issue this
> > time, but please make sure you always sign off patches when
> > you apply them from the list.
> > 
> >          Arnd
> > 
> 
> Ok i will update my script on my side with Stephen's script to avoid 
> this in the future.
> 

FWIW, last time this happened in the at91 tree, I've switched to use
Stephen's script as a pre-push hook:
https://raw.githubusercontent.com/alexandrebelloni/tools/master/pre-push_signed-off


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
