Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934776AbeCHCXH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:23:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51886 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933351AbeCHCXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:23:06 -0500
Subject: Re: mmotm 2018-03-07-16-19 uploaded (UML & memcg)
From: Randy Dunlap <rdunlap@infradead.org>
To: akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Shakeel Butt <shakeelb@google.com>
References: <20180308002016.L3JwBaNZ9%akpm@linux-foundation.org>
 <41ec9eeb-f0bf-e26d-e3ae-4a684c314360@infradead.org>
Message-ID: <d6ec23eb-a886-9fef-99c7-51c7ba4f5d18@infradead.org>
Date: Wed, 7 Mar 2018 18:23:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <41ec9eeb-f0bf-e26d-e3ae-4a684c314360@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2018 06:20 PM, Randy Dunlap wrote:
> On 03/07/2018 04:20 PM, akpm@linux-foundation.org wrote:
>> The mm-of-the-moment snapshot 2018-03-07-16-19 has been uploaded to
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
> 
> UML on i386 and/or x86_64:
> 
> defconfig, CONFIG_MEMCG is not set:
> 
> ../fs/notify/group.c: In function 'fsnotify_final_destroy_group':
> ../fs/notify/group.c:41:24: error: dereferencing pointer to incomplete type
>    css_put(&group->memcg->css);
>                         ^
> 
> From: Shakeel Butt <shakeelb@google.com>
> Subject: fs: fsnotify: account fsnotify metadata to kmemcg



or x86 any time that CONFIG_MEMCG is not enabled.


-- 
~Randy
