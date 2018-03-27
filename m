Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbeC0GsL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 02:48:11 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42878 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeC0GsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 02:48:10 -0400
X-Google-Smtp-Source: AG47ELtQPMQ3mP2baYW9wT1IymcEbVMQdUXn+jJ23OKMW/vyOJniCTccZi98dfN17/9EOngdfefqjw==
Date: Tue, 27 Mar 2018 08:48:06 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, bp@suse.de
Subject: Re: [PATCH 0/2] x86/CPU/AMD: Add support for Extended Topology
 Enumeration
Message-ID: <20180327064806.dy5updhu7grlct3q@gmail.com>
References: <1522051559-23415-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522051559-23415-1-git-send-email-suravee.suthikulpanit@amd.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:

> Linux currently provides function detect_extended_topology()
> for parsing CPUID Fn0xB and derive CPU topology information.
> Therefore, also call this function in AMD code path.
> 
> Thanks,
> Suravee
> 
> Suravee Suthikulpanit (2):
>   x86/CPU: Modify detect_extended_topology() to return result
>   x86/CPU/AMD: Derive CPU topology from CPUID Fn0xB when available
> 
>  arch/x86/include/asm/processor.h |  2 +-
>  arch/x86/kernel/cpu/amd.c        | 16 ++++++++++++----
>  arch/x86/kernel/cpu/topology.c   |  8 ++++----
>  3 files changed, 17 insertions(+), 9 deletions(-)

Which tree is this again? The second patch does not apply to -linus or -tip.

Thanks,

	Ingo
