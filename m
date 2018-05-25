Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935990AbeEYHwW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:52:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:42188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935951AbeEYHwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:52:19 -0400
Date: Fri, 25 May 2018 09:52:17 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] doc: document scope NOFS, NOIO APIs
Message-ID: <20180525075217.GF11881@dhcp22.suse.cz>
References: <20180424183536.GF30619@thunk.org>
 <20180524114341.1101-1-mhocko@kernel.org>
 <6c9df175-df6c-2531-b90c-318e4fff72bb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c9df175-df6c-2531-b90c-318e4fff72bb@infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-05-18 09:37:18, Randy Dunlap wrote:
> On 05/24/2018 04:43 AM, Michal Hocko wrote:
[...]
> > +The traditional way to avoid this deadlock problem is to clear __GFP_FS
> > +resp. __GFP_IO (note the later implies clearing the first as well) in
> 
>                             latter

?
No I really meant that clearing __GFP_IO implies __GFP_FS clearing
-- 
Michal Hocko
SUSE Labs
