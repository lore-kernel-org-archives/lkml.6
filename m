Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbeDIPvq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 11:51:46 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:37773 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeDIPvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 11:51:45 -0400
X-Google-Smtp-Source: AIpwx48/nNE+J+tUuaNSPLXAvyHEwEZn6rGb2PFLwFXNefnrP7FImBberc8FhHaYQMq5XEX73tBDcw==
Subject: Re: [PATCH] backing: silence compiler warning using __printf
To: Mathieu Malaterre <malat@debian.org>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        Nikolay Borisov <nborisov@suse.com>, Tejun Heo <tj@kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
References: <20180406201453.32683-1-malat@debian.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f8d37511-2a23-53f5-3c70-8a7f5f9e965e@kernel.dk>
Date: Mon, 9 Apr 2018 09:51:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180406201453.32683-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/18 2:14 PM, Mathieu Malaterre wrote:
> __printf marker was added in commit d2cc4dde9206 ("bdi_register: add
> __printf verification, fix arg mismatch") for function `bdi_register`
> since it is useful to verify format and arguments. Apply equivalent gcc
> attribute to `bdi_register_va`.
> 
> Remove warning triggered with W=1:
> 
>   mm/backing-dev.c:881:2: warning: function might be possible candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

Applied, thanks.

-- 
Jens Axboe
