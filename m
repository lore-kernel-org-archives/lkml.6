Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932376AbeCLQUt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:20:49 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39668 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbeCLQUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:20:47 -0400
X-Google-Smtp-Source: AG47ELu/3dMVHJyAnUyTS/P7dU3n2b3qLQGy2Cazc8GeA5IWfTJBZrx5Ufjz8mgFb5YnPk4NRUHmcA==
Subject: Re: [PATCH 1/2] direct-io: Remove unused DIO_ASYNC_EXTEND flag
To: Nikolay Borisov <nborisov@suse.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, rgoldwyn@suse.de, linux-block@vger.kernel.org
References: <1519386329-2734-1-git-send-email-nborisov@suse.com>
 <f0132588-86e0-1430-dd2c-157e59272f40@suse.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bea25d90-9e92-dce5-7e32-edf99b4161a2@kernel.dk>
Date: Mon, 12 Mar 2018 09:20:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <f0132588-86e0-1430-dd2c-157e59272f40@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/18 2:54 AM, Nikolay Borisov wrote:
> 
> 
> On 23.02.2018 13:45, Nikolay Borisov wrote:
>> This flag was added by 6039257378e4 ("direct-io: add flag to allow aio
>> writes beyond i_size") to support XFS. However, with the rework of
>> XFS' DIO's path to use iomap in acdda3aae146 ("xfs: use iomap_dio_rw")
>> it became redundant. So let's remove it.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> 
> Jens,
> 
> On a second look I think you are the more appropriate person to take
> these patches. SO do you have any objections to merging those via the
> block tree. ( I did CC you but didn't cc linux-block).

Both look fine to me, I can add them for 4.17. Thanks.

-- 
Jens Axboe
