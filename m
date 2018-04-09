Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbeDIGhT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 02:37:19 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:54092 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeDIGhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 02:37:17 -0400
X-Google-Smtp-Source: AIpwx490++qXblmXamIxXx+3L+PwTMkGv7NHMDAJs58NH4tf5iBE9GRexKq9Dt5fMhyGzLmuelvv7A==
Subject: Re: [PATCH] checkpatch: relax check for revert commit
To: Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc: linux-kernel@vger.kernel.org, Jia He <jia.he@hxt-semitech.com>
References: <1522679339-19067-1-git-send-email-hejianet@gmail.com>
 <1522679339-19067-2-git-send-email-hejianet@gmail.com>
 <d5f5fbc7-d01f-05e1-f8ac-c1db8ba5fd9e@gmail.com>
 <7d9467ac5aee4b81b5c58c167ac553c75dd26f4c.camel@perches.com>
From: Jia He <hejianet@gmail.com>
Message-ID: <979a4ce5-2c68-6186-476c-1214aed2cdbc@gmail.com>
Date: Mon, 9 Apr 2018 14:37:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7d9467ac5aee4b81b5c58c167ac553c75dd26f4c.camel@perches.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/2018 1:07 AM, Joe Perches Wrote:
> On Sun, 2018-04-08 at 10:12 +0800, Jia He wrote:
>> Hi Andy & Joe
>>
>> Although it is minor, it is a real bug, I thought.
>>
>> Is there any comment? Thank you
> If you really want to do something useful here,
> quote the quote characters and compare for that.
>
>
Hi Joe, thanks for the comments
I am not sure I understand you comments here.
e.g.If there is such a commit f5c1350256fb ("Revert "mm/page_alloc: fix 
memmap_init_zone pageblock alignment"") in the decription log.

Do you want me to quote the first match - Revert "mm/page_alloc: fix 
memmap_init_zone pageblock alignment" or the second one - mm/page_alloc: fix 
memmap_init_zone pageblock alignment ?
Thanks for more details

-- 
Cheers,
Jia
