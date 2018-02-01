Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeBAPXF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:23:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751554AbeBAPXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:23:03 -0500
Date: Thu, 1 Feb 2018 16:22:44 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        KVM <kvm@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: linux-next: manual merge of the kvm tree with Linus' tree
Message-ID: <20180201152244.GC31080@flask>
References: <20180201125512.7bc96674@canb.auug.org.au>
 <20180201104707.GA21802@cbox>
 <20180202002227.36db3356@canb.auug.org.au>
 <f49453f2-223e-abe0-912a-7288183a1671@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f49453f2-223e-abe0-912a-7288183a1671@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-01 09:21-0500, Paolo Bonzini:
> On 01/02/2018 08:22, Stephen Rothwell wrote:
> > Hi Christoffer,
> > 
> > On Thu, 1 Feb 2018 11:47:07 +0100 Christoffer Dall <christoffer.dall@linaro.org> wrote:
> >>
> >> While the suggested fix is functional it does result in some code
> >> duplication, and the better resolution is the following:
> > 
> > OK, I will use that resolution form tomorrow on.
> > 
> > Someone needs to remember to let Linus know when the pull request is
> > sent.
> 
> It should be fixed in the KVM tree before it reaches Linus (when we
> merge a topic branch that is common between x86/pti & KVM).

I wasn't sure if the pti top branch is final, so I pulled hyper-v topic
branch that also also contains v4.15.  This and the SEV feature
conflicts should be gone now,

thanks.
