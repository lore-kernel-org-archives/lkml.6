Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970554AbeEXOrM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:47:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:40448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965555AbeEXOrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:47:10 -0400
Date: Thu, 24 May 2018 16:47:08 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Shakeel Butt <shakeelb@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] doc: document scope NOFS, NOIO APIs
Message-ID: <20180524144708.GL20441@dhcp22.suse.cz>
References: <20180424183536.GF30619@thunk.org>
 <20180524114341.1101-1-mhocko@kernel.org>
 <CALvZod6CmkNgkYkSchFXsPefnuNUDjOEhPXtEUOJaeuSiXCUKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6CmkNgkYkSchFXsPefnuNUDjOEhPXtEUOJaeuSiXCUKg@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-05-18 07:33:39, Shakeel Butt wrote:
> On Thu, May 24, 2018 at 4:43 AM, Michal Hocko <mhocko@kernel.org> wrote:
[...]
> > +The traditional way to avoid this deadlock problem is to clear __GFP_FS
> > +resp. __GFP_IO (note the later implies clearing the first as well) in
> 
> Is resp. == respectively? Why not use the full word (here and below)?

yes. Because I was lazy ;)

-- 
Michal Hocko
SUSE Labs
