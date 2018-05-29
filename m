Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935369AbeE2OXD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:23:03 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:53746 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935293AbeE2OWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:22:46 -0400
X-Google-Smtp-Source: ADUXVKIk62UW9AzEx7uBinx4KrcjblOz5xLA1TsVcsWDolJtYc3i7Ebpxza6Mpo6KdlN3cnXfXLSpg==
Subject: Re: linux-next: manual merge of the block tree with the vfs tree
To: Christoph Hellwig <hch@lst.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
References: <20180529143357.2a66b0af@canb.auug.org.au>
 <20180529081205.GB1416@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <83024e98-8719-7ed2-a5d5-e1653162bacc@kernel.dk>
Date: Tue, 29 May 2018 08:22:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180529081205.GB1416@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/18 2:12 AM, Christoph Hellwig wrote:
> Meh.  Do we really need these switch to octal patches to start
> with?  I mean, I personally prefer octal, but just switching around
> in random code that isn't otherwise changed creates nothing but churn.

This is exactly why I hesitated doing it, I knew it would end up
with conflicts. The main reason was to get rid of the inconsistency,
since we had a fair mix of octal and symbolic names.

-- 
Jens Axboe
