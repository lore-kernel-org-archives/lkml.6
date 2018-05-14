Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932495AbeENObt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:31:49 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39368 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932313AbeENObr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:31:47 -0400
X-Google-Smtp-Source: AB8JxZpINF0xh6DwejSmN0lAQzB1tjJfuv6bTRc3Eq2+sHv/7+YSR3z85I44rfvBYXRK/m9KS8mq9w==
Subject: Re: linux-next: build warning after merge of the block tree
To: Christoph Hellwig <hch@lst.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180514125139.459a058d@canb.auug.org.au>
 <20180514082951.GA20978@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bbd3fc2b-2125-1e73-fc2f-dc992dba1dee@kernel.dk>
Date: Mon, 14 May 2018 08:31:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180514082951.GA20978@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/18 2:29 AM, Christoph Hellwig wrote:
> On Mon, May 14, 2018 at 12:51:39PM +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the block tree, today's linux-next build (x86_64
>> allmodconfig) produced this warning:
> 
> The look entirely correct, but oddly enough my compiler did not bother
> to warn.

Applied, thanks.

-- 
Jens Axboe
