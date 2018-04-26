Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755352AbeDZLJV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:09:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:50663 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755159AbeDZLJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:09:20 -0400
Date: Thu, 26 Apr 2018 13:09:05 +0200
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
Message-ID: <20180426110905.GH15043@pd.tnic>
References: <20180419001848.3041-1-bhe@redhat.com>
 <20180419001848.3041-3-bhe@redhat.com>
 <20180419100745.GC3896@pd.tnic>
 <20180426085649.GC18395@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180426085649.GC18395@localhost.localdomain>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 04:56:49PM +0800, Baoquan He wrote:
> Sorry for that, I just ran scripts/get_maintainer.pl to get expert's
> name and added them into each patch. The reason this change is made is
> in patch 3/3. Test robot reported a code bug on the latest kernel, will
> repost and CC everyone in all patches.
> 
> 
> Rob Herring asked the same question in v2, I explained to him. The
> discussion can be found here:
> https://lkml.org/lkml/2018/4/10/484

... and when I open that link, the first paragraph says:

"This is the explanation I made when Andrew helped to review the v1 post:
https://lkml.org/lkml/2018/3/23/78"

Do you see the absurdity of the link chasing of your explanation?!

Instead, the explanation *WHY* should be in the commit message of the
patch - not in mail replies when people ask you about it.

Also, do not use lkml.org when referencing a mail on lkml but
use the Message-ID of the header. We have a proper redirector at
https://lkml.kernel.org/r/<Message-ID>

Now lemme read the reason finally...

"We need unify these two interfaces on behaviour since they are the same
on essense from the users' point of view... "

That's not a good enough reason for me to cause code churn. If the only
reason is: because the one does it top-down and the other bottom-up, I'm
not convinced.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
