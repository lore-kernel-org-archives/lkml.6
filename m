Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbeDEFmj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 01:42:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:54895 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751437AbeDEFmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 01:42:38 -0400
Date: Thu, 5 Apr 2018 07:42:32 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH] prctl: Deprecate non PR_SET_MM_MAP operations
Message-ID: <20180405054232.GR6312@dhcp22.suse.cz>
References: <20180404185523.GG15783@uranus.lan>
 <6c784c94-e7a3-7dad-20bc-179a8720e98c@infradead.org>
 <20180404200426.GH15783@uranus.lan>
 <467373a7-8b2b-971c-4e62-7fae043c96fe@infradead.org>
 <20180404212906.GJ15783@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404212906.GJ15783@uranus.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-04-18 00:29:06, Cyrill Gorcunov wrote:
> On Wed, Apr 04, 2018 at 01:53:08PM -0700, Randy Dunlap wrote:
[...]
> > Yeah, that one's wrong also.  :)
> 
> So, maybe just get rid of any warning message at all?

or simply do
	pr_warn("PR_SET_MM_MAP has been removed. Use <ALTERNATIVE> instead\n");
-- 
Michal Hocko
SUSE Labs
