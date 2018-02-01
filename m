Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeBAP6u (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:58:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751530AbeBAP6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:58:49 -0500
Date: Thu, 1 Feb 2018 16:58:34 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Mihai Carabas <mihai.carabas@oracle.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: Re: [PATCH v3 0/3] Per-VCPU MSR bitmaps patches - topic branch for
 x86/pti
Message-ID: <20180201155833.GE31080@flask>
References: <20180131210924.22812-1-pbonzini@redhat.com>
 <20180201014810.GA19582@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201014810.GA19582@char.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-01-31 20:48-0500, Konrad Rzeszutek Wilk:
> On Wed, Jan 31, 2018 at 04:09:21PM -0500, Paolo Bonzini wrote:
> > David and others,
> > 
> > the following changes since commit ba804bb4b72e57374b5f567b783aa0298fba0ce6:
> > 
> >   Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-01-26 09:03:16 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/virt/kvm/kvm.git msr-bitmaps
> > 
> > for you to fetch changes up to 904e14fb7cb96401a7dc803ca2863fd5ba32ffe6:
> > 
> >   KVM: VMX: make MSR bitmaps per-VCPU (2018-01-26 22:59:32 +0100)
> > 
> > The patches are on top of Linus's tree and I checked that they apply okay
> > on top of the latest 4.14 tree as well as required for tip x86/pti.
> > One extra commit is needed that is pretty safe and would have been merged
> > for 4.16 anyway.
> > 
> > Radim, please pull this into kvm.git too.  As before I've placed my
> > resolution on kvm.git, branch refs/heads/msr-bitmaps-merge-resolution.
> > It's based on kvm/next this time.
> 
> You don't want folks to review patch #2 and #3 first? There are tons
> of people that I am sure would be thrilled with the whole Spectra circus.

This is only a boring prerequisite that doesn't add any security ...
Jim Mattson gave r-b to [v1 3/3] and was a significant contributor to
the patches, David Hildenbrandt reviewed [v2 2,3/3] and there have been
only minor changes since.

v3 looks good to me, so I'll pull if there are no more requirements from
pti.
