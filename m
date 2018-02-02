Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbeBBOux (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:50:53 -0500
Received: from mail-ua0-f177.google.com ([209.85.217.177]:45454 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeBBOup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:50:45 -0500
X-Google-Smtp-Source: AH8x226UF2noBRst+3t+7YIFMWfd5REESPvyu7NJmjttv+rkIz3EmICA8J6Eo+eRFX7EuvTmwFH2uw==
Subject: Re: [PATCH v2] buffer: Avoid setting buffer bits that are already set
To: kemi <kemi.wang@intel.com>, Jan Kara <jack@suse.cz>,
        Darrick J Wong <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@google.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Jeff Layton <jlayton@redhat.com>
Cc: Dave <dave.hansen@linux.intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>, Ying Huang <ying.huang@intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <1508807802-9691-1-git-send-email-kemi.wang@intel.com>
 <f18ba82a-e715-a71c-4904-3adc9b8ea149@intel.com>
 <6e946728-23f5-d5df-c8d0-c9ec4251557c@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <872a539f-ce92-d3c8-92fb-312e57296191@kernel.dk>
Date: Fri, 2 Feb 2018 07:50:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <6e946728-23f5-d5df-c8d0-c9ec4251557c@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/18 1:07 AM, kemi wrote:
> Hi, Jens
>   Could you help to merge this patch to your tree? Thanks

Yes, I'll queue it up, thanks.

-- 
Jens Axboe
