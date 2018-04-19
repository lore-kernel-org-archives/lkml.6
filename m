Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753708AbeDSQER (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:04:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:53134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753690AbeDSQEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:04:15 -0400
Date: Thu, 19 Apr 2018 18:04:08 +0200
From: Borislav Petkov <bp@suse.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: Michal Kubecek <mkubecek@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] x86/ldt: Fix support_pte_mask filtering in
 map_ldt_struct()
Message-ID: <20180419160408.GA3905@pd.tnic>
References: <1523871837-8378-1-git-send-email-joro@8bytes.org>
 <CALCETrVgQspiO3nnyhqiXi17iaGG7bRDsr3gpHwdDnYfFDZabQ@mail.gmail.com>
 <07e2c23e-10b7-b03f-5706-3d4b910537ba@linux.intel.com>
 <20180418121403.GA3434@pd.tnic>
 <20180419130011.GG3896@pd.tnic>
 <20180419141134.GI15462@8bytes.org>
 <20180419145832.5mq3va53swswajmu@unicorn.suse.cz>
 <20180419151126.GJ15462@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419151126.GJ15462@8bytes.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 05:11:27PM +0200, Joerg Roedel wrote:
> Cool, thanks for testing! I prepared a patch and will send it out if
> Boris also reports success. I'll also added your Tested-by :)

Boris reports success too.

Very good catch, thanks!

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
