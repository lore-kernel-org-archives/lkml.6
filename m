Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeFBUK3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 16:10:29 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:46999 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeFBUK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 16:10:28 -0400
X-Google-Smtp-Source: ADUXVKLwXjM0oXPWX1GG8Vdhbt/7kqtp57AAmhxjIITsSf0/XwYPsNRlMcwdKk1aPO7Mj+Ppu0dadw==
Subject: Re: dm-crypt: fix warning in shutdown path
To: Mike Snitzer <snitzer@redhat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
References: <20180602174504.1847-1-kent.overstreet@gmail.com>
 <974665e7-fa4a-230b-99d8-e773489cc6bc@kernel.dk>
 <20180602200723.GA23980@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <eeea0f12-45d4-d90c-e07e-3f02cdc9994f@kernel.dk>
Date: Sat, 2 Jun 2018 14:10:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180602200723.GA23980@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/18 2:07 PM, Mike Snitzer wrote:
> On Sat, Jun 02 2018 at  4:03pm -0400,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> On 6/2/18 11:45 AM, Kent Overstreet wrote:
>>> The counter for the number of allocated pages includes pages in the
>>> mempool's reserve, so checking that the number of allocated pages is 0
>>> needs to happen after we exit the mempool.
>>
>> Looks good, but needs a fixes line. I'll add one.
> 
> Also needs the subject and header updated to reflect that it fixes the
> crash (Krzysztof please verify):
> 
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Mike Snitzer <snitzer@redhat.com>

Indeed, I have added that. Thanks Mike.

-- 
Jens Axboe
