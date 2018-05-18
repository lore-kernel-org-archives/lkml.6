Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeERDu3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 23:50:29 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50953 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751698AbeERDu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 23:50:26 -0400
X-ME-Proxy: <xmx:gU3-WrxeKbUF4UXn97gcoZErmigVBcQNWVqyvqmvdR9u_ZEVPHHZTw>
X-ME-Proxy: <xmx:gU3-WiU5czn79Gfwo9henz3odjPo12OvZCUeq7so7XUZqvIkwROzMw>
X-ME-Proxy: <xmx:gU3-WrhQD1OUmrzaIBu8zA5eRBFbrvlpBkxBhT81zTgp74ipbpf2CA>
X-ME-Proxy: <xmx:gU3-WiDMk47-YVthlv8u05uembl1kGs2SxG5OwkhygQm6xoASkwPew>
X-ME-Proxy: <xmx:gU3-Whs4EZQQ3pUFMBGDZlbf77GURxfrheViHO0EEzy4dQA4isOb7w>
X-ME-Proxy: <xmx:gk3-Wm_teS41AeYqVY-wZEVILm4oOugYdCiaohwYBp57l0_9OdW2wg>
X-ME-Sender: <xms:gU3-Wnmw4dk3K8K7YDbXaUtPkyyN5nV9NHKVq3fNrag6A0AqzrjCxQ>
Subject: Re: mmotm 2018-05-17-16-26 uploaded (autofs)
To: Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
References: <20180517232639.sD6Cz%akpm@linux-foundation.org>
 <19926e1e-6dba-3b9f-fd97-d9eb88bfb7dd@infradead.org>
From: Ian Kent <raven@themaw.net>
Message-ID: <49acf718-da2e-73dc-a3bf-c41d7546576e@themaw.net>
Date: Fri, 18 May 2018 11:50:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <19926e1e-6dba-3b9f-fd97-d9eb88bfb7dd@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/18 08:21, Randy Dunlap wrote:
> On 05/17/2018 04:26 PM, akpm@linux-foundation.org wrote:
>> The mm-of-the-moment snapshot 2018-05-17-16-26 has been uploaded to
>>
>>    http://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> http://www.ozlabs.org/~akpm/mmotm/
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>>
>> You will need quilt to apply these patches to the latest Linus release (4.x
>> or 4.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>> http://ozlabs.org/~akpm/mmotm/series
>>
>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>> followed by the base kernel version against which this patch series is to
>> be applied.
>>
>> This tree is partially included in linux-next.  To see which patches are
>> included in linux-next, consult the `series' file.  Only the patches
>> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
>> linux-next.
>>
>> A git tree which contains the memory management portion of this tree is
>> maintained at git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.git
>> by Michal Hocko.  It contains the patches which are between the
>> "#NEXT_PATCHES_START mm" and "#NEXT_PATCHES_END" markers, from the series
>> file, http://www.ozlabs.org/~akpm/mmotm/series.
>>
>>
>> A full copy of the full kernel tree with the linux-next and mmotm patches
>> already applied is available through git within an hour of the mmotm
>> release.  Individual mmotm releases are tagged.  The master branch always
>> points to the latest release, so it's constantly rebasing.
> 
> 
> on x86_64: with (randconfig):
> CONFIG_AUTOFS_FS=y
> CONFIG_AUTOFS4_FS=y

Oh right, I need to make these exclusive.

I seem to remember trying to do that along the way, can't remember why
I didn't do it in the end.

Any suggestions about potential problems when doing it?

Thanks,
Ian
