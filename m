Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeEMWta (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 18:49:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeEMWt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 18:49:28 -0400
Subject: Re: [PATCH 1/2] bcachefs: On disk data structures
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bcache@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>, hare@suse.com
References: <20180508221800.2642-1-kent.overstreet@gmail.com>
 <20180508221800.2642-2-kent.overstreet@gmail.com>
 <dea41935-a52c-e720-0ca3-eef4367d3641@infradead.org>
 <20180513222948.GA20114@kmo-pixel>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3bf4a87c-20fc-0b9f-1c27-c43d1c194b47@infradead.org>
Date: Sun, 13 May 2018 15:49:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180513222948.GA20114@kmo-pixel>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/13/2018 03:29 PM, Kent Overstreet wrote:
> On Sun, May 13, 2018 at 01:30:06PM -0700, Randy Dunlap wrote:
>> On 05/08/2018 03:17 PM, Kent Overstreet wrote:
> 
>>> + * various btrees. There are only a small number of btrees, they're not
>>> + * sharded - we have one btree for extents, another for inodes, et cetera.
>>
>>    or shared?
> 
> No, I mean sharded - we're e.g. not splitting up the extents btree into one
> btree per inode. 

Got it, thanks.

>> I know that you have already answered a few comments about endianness,
>> so maybe you answered this and I missed it.
>>
>> Can a bcachefs fs be shared, a la NFS?  I.e., can multiple different-endian
>> clients be accessing the same bcachefs?
> 
> NFS works. I haven't tested NFS to different endian clients, wasn't aware there
> was any reason to... are there potential issues there I'm not aware of?

Not that I know of.

thanks,
-- 
~Randy
