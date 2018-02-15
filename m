Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032611AbeBOCDu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 21:03:50 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33335 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032437AbeBOCDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 21:03:49 -0500
X-Google-Smtp-Source: AH8x225NXUwKud96++T3L8z4NiRam49SEaC8lw/b3hOZStxg2gEvP10ixqMlPknwF0BkynR+BK+Xjw==
Subject: Re: [PATCH] block: Change 'unsigned' to 'unsigned int' throughout
 block layer
To: John Pittman <jpittman@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1518658622-5931-1-git-send-email-jpittman@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8c4f1f22-223e-6bc1-6261-dceb0caf5219@kernel.dk>
Date: Wed, 14 Feb 2018 19:03:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1518658622-5931-1-git-send-email-jpittman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/18 6:37 PM, John Pittman wrote:
> In quite a few files throughout the block layer, the bare 'unsigned' is
> used rather than the preferred 'unsigned int'.  The issue was
> exposed by checkpatch.pl.  Warnings encountered were:
> 
>     WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>     WARNING: Prefer 'unsigned int *' to bare use of 'unsigned *'
> 
> Fixed 64 total warnings.

I'm not going to take this, unless there's a specific bug related
to it.

-- 
Jens Axboe
