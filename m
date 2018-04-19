Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbeDSRXo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:23:44 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:34042 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbeDSRXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:23:42 -0400
X-Google-Smtp-Source: AIpwx48tswX9bVn285OkOuvTgIdCU99leXVgn+kKaPHRWNsAJtxB43p76UkcT3/i7NQvLKJumUtQEg==
Subject: Re: [PATCH 1/2] blkcg: small fix on comment in blkcg_init_queue
To: Randy Dunlap <rdunlap@infradead.org>,
        Jiang Biao <jiang.biao2@zte.com.cn>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, zhong.weidong@zte.com.cn, wen.yang99@zte.com.cn
References: <1524110666-106945-1-git-send-email-jiang.biao2@zte.com.cn>
 <b24cd922-01c7-ce14-6427-1a8dd7819e58@kernel.dk>
 <c79d16cb-739d-2ac8-9fa4-bd5f6671269a@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1695686e-40c0-6128-9b27-18cba7bf53ca@kernel.dk>
Date: Thu, 19 Apr 2018 11:23:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <c79d16cb-739d-2ac8-9fa4-bd5f6671269a@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/18 11:10 AM, Randy Dunlap wrote:
> On 04/19/18 07:52, Jens Axboe wrote:
>> On 4/18/18 10:04 PM, Jiang Biao wrote:
>>> The comment before blkg_create() in blkcg_init_queue() was moved
>>> from blkcg_activate_policy() by commit ec13b1d6f0a0457312e615, but
>>> it does not suit for the new context.
>>
>> Applied - btw, in the future, if you send more than one patch in
>> a series, please include a cover letter.
> 
> Hi Jens,
> 
> Where does that cover letter requirement come from?  It's not documented
> anywhere AFAICT and shouldn't be needed for such small patch series.

It's not a requirement, I just strongly prefer it for anything that is
more than one patch. Hence I tend to let people know about that
preference, if they send patches more than once.

It makes it possible to send comments for the series as a whole.

-- 
Jens Axboe
