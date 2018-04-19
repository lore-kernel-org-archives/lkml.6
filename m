Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeDSPL3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:11:29 -0400
Received: from 8bytes.org ([81.169.241.247]:49268 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751836AbeDSPL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:11:28 -0400
Date: Thu, 19 Apr 2018 17:11:27 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] x86/ldt: Fix support_pte_mask filtering in
 map_ldt_struct()
Message-ID: <20180419151126.GJ15462@8bytes.org>
References: <1523871837-8378-1-git-send-email-joro@8bytes.org>
 <CALCETrVgQspiO3nnyhqiXi17iaGG7bRDsr3gpHwdDnYfFDZabQ@mail.gmail.com>
 <07e2c23e-10b7-b03f-5706-3d4b910537ba@linux.intel.com>
 <20180418121403.GA3434@pd.tnic>
 <20180419130011.GG3896@pd.tnic>
 <20180419141134.GI15462@8bytes.org>
 <20180419145832.5mq3va53swswajmu@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419145832.5mq3va53swswajmu@unicorn.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Thu, Apr 19, 2018 at 04:58:32PM +0200, Michal Kubecek wrote:
> I had the same problem with v4.17-rc1 and fb43d6cb91ef and the change
> you suggested applied on top of
> 
>   (a) fb43d6cb91ef with cherry-picked e6f39e87b643
>   (b) current master (87ef12027b9b)
> 
> fixes the resume on my system.

Cool, thanks for testing! I prepared a patch and will send it out if
Boris also reports success. I'll also added your Tested-by :)


Thanks,

	Joerg
