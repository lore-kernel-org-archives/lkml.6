Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbeEDKQo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:16:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:45108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbeEDKQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:16:43 -0400
Date: Fri, 4 May 2018 12:16:31 +0200
From: Borislav Petkov <bp@suse.de>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        robh+dt@kernel.org, dan.j.williams@intel.com, nicolas.pitre@linaro.org,
        josh@joshtriplett.org, Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v3 2/3] resource: add walk_system_ram_res_rev()
Message-ID: <20180504101631.GB9377@pd.tnic>
References: <20180419001848.3041-1-bhe@redhat.com>
 <20180419001848.3041-3-bhe@redhat.com>
 <20180419100745.GC3896@pd.tnic>
 <20180426085649.GC18395@localhost.localdomain>
 <20180426110905.GH15043@pd.tnic>
 <20180426132204.GF19030@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180426132204.GF19030@localhost.localdomain>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 09:22:04PM +0800, Baoquan He wrote:
> I noticed maintainers merged patches with this Message-ID, could you
> tell how to get this Message-ID?

https://en.wikipedia.org/wiki/Message-ID

> This is not a thing that one is top down, the other is bottom up. For
> us, they might be so different on details of code, for customers, they
> just think them as a same thing. They may say I just get a new machine,
> and still do kexec loading, why these top-down, bottom-up things come
> up.

So if I read the above correctly, it doesn't matter whether top-down or
bottom-up.

> And this is not causing code churn. You can see that by replacing
> pointer operation with list_head, code in kernel/resource.c related to
> child list iteration is much easier to read,

Now *this* is starting to sound like some reason "why". If it is better
readability, then say so in the commit message.

It still doesn't justify adding walk_system_ram_res_rev() though.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
