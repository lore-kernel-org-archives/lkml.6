Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753024AbeENRbP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:31:15 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:37056 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753002AbeENRbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:31:13 -0400
X-Google-Smtp-Source: AB8JxZoY0VYI7tKmaJ6aFYgcBBvoJ7vrviVTh142ckzA3y/kr9VVi36Mz+sy4XID+Z5QvZSyyv3A2w==
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
To: Paolo Valente <paolo.valente@linaro.org>,
        Bart Van Assche <bart.vanassche@wdc.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bfq-iosched@googlegroups.com" <bfq-iosched@googlegroups.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
 <d534de4765c0fbcc7bcd858c1d2f40391ece19ac.camel@wdc.com>
 <8B9DC3A2-0DB0-4EEB-AFB2-C4D6560B7A4A@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4ea9999a-e316-f0bc-a99f-70cd0e901e55@kernel.dk>
Date: Mon, 14 May 2018 11:31:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <8B9DC3A2-0DB0-4EEB-AFB2-C4D6560B7A4A@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/18 11:16 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 10 mag 2018, alle ore 18:14, Bart Van Assche <bart.vanassche@wdc.com> ha scritto:
>>
>> On Fri, 2018-05-04 at 19:17 +0200, Paolo Valente wrote:
>>> When invoked for an I/O request rq, [ ... ]
>>
>> Tested-by: Bart Van Assche <bart.vanassche@wdc.com>
>>
>>
>>
> 
> Any decision for this fix, Jens?

Guess I didn't reply, but I did commit this on Thursday.

-- 
Jens Axboe
