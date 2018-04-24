Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934167AbeDXNVH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:21:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:50677 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933950AbeDXNVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:21:01 -0400
Date: Tue, 24 Apr 2018 07:20:57 -0600
From: Michal Hocko <mhocko@kernel.org>
To: Chunyu Hu <chuhu.ncepu@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chunyu Hu <chuhu@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC] mm: kmemleak: replace __GFP_NOFAIL to GFP_NOWAIT in
 gfp_kmemleak_mask
Message-ID: <20180424132057.GE17484@dhcp22.suse.cz>
References: <1524243513-29118-1-git-send-email-chuhu@redhat.com>
 <20180420175023.3c4okuayrcul2bom@armageddon.cambridge.arm.com>
 <20180422125141.GF17484@dhcp22.suse.cz>
 <CACT4Y+YWUgyzCBadg+Oe8wDkFCaBzmcKDgu3rKjQxim7NXNLpg@mail.gmail.com>
 <CABATaM6eWtssvuj3UW9LHLK3HWo8P9g0z9VzFnuqKPKO5KMJ3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABATaM6eWtssvuj3UW9LHLK3HWo8P9g0z9VzFnuqKPKO5KMJ3A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-04-18 12:17:32, Chunyu Hu wrote:
[...]
> So if there is a new flag, it would be the 25th bits.

No new flags please. Can you simply store a simple bool into fail_page_alloc
and have save/restore api for that?

-- 
Michal Hocko
SUSE Labs
