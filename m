Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeC0Gwo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 02:52:44 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33982 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbeC0Gwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 02:52:40 -0400
X-Google-Smtp-Source: AG47ELvG0GHwFpR3Gt2daP0WG4IebjFfZH8UVK5JAIi+xKX6fl4dSiR45dwYSQPFxjJPdSsjUPjXzg==
Date: Mon, 26 Mar 2018 23:52:38 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Ingo Molnar <mingo@kernel.org>
cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, bp@suse.de
Subject: Re: [PATCH 0/2] x86/CPU/AMD: Add support for Extended Topology
 Enumeration
In-Reply-To: <20180327064806.dy5updhu7grlct3q@gmail.com>
Message-ID: <alpine.DEB.2.20.1803262351340.261728@chino.kir.corp.google.com>
References: <1522051559-23415-1-git-send-email-suravee.suthikulpanit@amd.com> <20180327064806.dy5updhu7grlct3q@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018, Ingo Molnar wrote:

> > Linux currently provides function detect_extended_topology()
> > for parsing CPUID Fn0xB and derive CPU topology information.
> > Therefore, also call this function in AMD code path.
> > 
> > Thanks,
> > Suravee
> > 
> > Suravee Suthikulpanit (2):
> >   x86/CPU: Modify detect_extended_topology() to return result
> >   x86/CPU/AMD: Derive CPU topology from CPUID Fn0xB when available
> > 
> >  arch/x86/include/asm/processor.h |  2 +-
> >  arch/x86/kernel/cpu/amd.c        | 16 ++++++++++++----
> >  arch/x86/kernel/cpu/topology.c   |  8 ++++----
> >  3 files changed, 17 insertions(+), 9 deletions(-)
> 
> Which tree is this again? The second patch does not apply to -linus or -tip.
> 

I was wondering the exact same thing today when this came across.  I found 
it's based on Suravee's other patch series posted today entitled "x86/CPU: 
Update AMD Last-Level-Cache Information".

https://marc.info/?l=linux-kernel&m=152204614503522
1522046116-22578-1-git-send-email-suravee.suthikulpanit@amd.com
