Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754626AbeDMNmG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 09:42:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754283AbeDMNmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 09:42:05 -0400
Subject: Re: [PATCH RFC 5/8] mm: only mark section offline when all pages are
 offline
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180413133229.3257-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <be6c6b1c-6629-1b18-8a52-ac79e698cba6@redhat.com>
Date: Fri, 13 Apr 2018 15:42:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413133229.3257-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.2018 15:32, David Hildenbrand wrote:
> If any page is still online, the section should stay online.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

This is a duplicate, please ignore.

(get_maintainers.sh and my mail server had a little clinch, so I had to
send half of the series out manually -_- )

-- 

Thanks,

David / dhildenb
