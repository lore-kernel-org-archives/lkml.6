Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbeA3RwP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 12:52:15 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:38447 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbeA3RwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 12:52:14 -0500
Subject: Re: [PATCH v2] mm/swap.c: make functions and their kernel-doc agree
To: Michal Hocko <mhocko@kernel.org>
Cc: Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
References: <3b42ee3e-04a9-a6ca-6be4-f00752a114fe@infradead.org>
 <20180130123400.GD26445@dhcp22.suse.cz>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <958aa51a-e497-795f-1482-2e6b18143209@infradead.org>
Date: Tue, 30 Jan 2018 09:52:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180130123400.GD26445@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/2018 04:34 AM, Michal Hocko wrote:
> On Mon 29-01-18 16:43:55, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix some basic kernel-doc notation in mm/swap.c:
>> - for function lru_cache_add_anon(), make its kernel-doc function name
>>   match its function name and change colon to hyphen following the
>>   function name
> 
> This is pretty much an internal function to the MM. It shouldn't have
> any external callers. Why do we need a kernel doc at all?
> 
>> - for function pagevec_lookup_entries(), change the function parameter
>>   name from nr_pages to nr_entries since that is more descriptive of
>>   what the parameter actually is and then it matches the kernel-doc
>>   comments also
> 
> I know what is nr_pages because I do expect pages to be returned. What
> are entries? Can it be something different from pages?

OK, never mind.  I'll revisit this some other day.

later,
-- 
~Randy
