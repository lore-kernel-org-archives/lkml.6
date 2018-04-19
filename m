Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753481AbeDSRKi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:10:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41598 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753252AbeDSRKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:10:37 -0400
Subject: Re: [PATCH 1/2] blkcg: small fix on comment in blkcg_init_queue
To: Jens Axboe <axboe@kernel.dk>, Jiang Biao <jiang.biao2@zte.com.cn>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, zhong.weidong@zte.com.cn, wen.yang99@zte.com.cn
References: <1524110666-106945-1-git-send-email-jiang.biao2@zte.com.cn>
 <b24cd922-01c7-ce14-6427-1a8dd7819e58@kernel.dk>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c79d16cb-739d-2ac8-9fa4-bd5f6671269a@infradead.org>
Date: Thu, 19 Apr 2018 10:10:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b24cd922-01c7-ce14-6427-1a8dd7819e58@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/18 07:52, Jens Axboe wrote:
> On 4/18/18 10:04 PM, Jiang Biao wrote:
>> The comment before blkg_create() in blkcg_init_queue() was moved
>> from blkcg_activate_policy() by commit ec13b1d6f0a0457312e615, but
>> it does not suit for the new context.
> 
> Applied - btw, in the future, if you send more than one patch in
> a series, please include a cover letter.

Hi Jens,

Where does that cover letter requirement come from?  It's not documented
anywhere AFAICT and shouldn't be needed for such small patch series.

> I've applied 2/2 as well.

thanks,
-- 
~Randy
