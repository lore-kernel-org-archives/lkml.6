Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756134AbeCHQZ4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:25:56 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45157 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbeCHQZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:25:55 -0500
X-Google-Smtp-Source: AG47ELsR1EVf4ZyeX6AJk2meop63yd/rzYZ/d0X8f/5bZiZabKs5zfbJZ7r4gI/iunhXF+9/Fu9s3g==
Subject: Re: [GIT PULL] (xen) stable/for-jens-4.15
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com
References: <20180308161914.GN12029@char.us.oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f386ba9b-d331-ee8d-2b2f-27ff0074ed7d@kernel.dk>
Date: Thu, 8 Mar 2018 09:25:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20180308161914.GN12029@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/18 9:19 AM, Konrad Rzeszutek Wilk wrote:
> Hi Jens,
> 
> Please git pull the following branch for your for-linus branch:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git stable/for-jens-4.15
> 
> It has one simple fix for the multi-queue support not showing up after a block
> device was detached/re-attached.
> 
> The patch was originally posted in Dec 22nd but with the Spectre/Meltdown
> circus I forgot about it until now.
> 
> Thank you!
>  
> drivers/block/xen-blkfront.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> Bhavesh Davda (1):
>       xen-blkfront: move negotiate_mq to cover all cases of new VBDs

Pulled, thanks.

-- 
Jens Axboe
