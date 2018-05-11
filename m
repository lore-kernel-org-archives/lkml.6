Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbeEKPZf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:25:35 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:59049 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeEKPZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:25:34 -0400
Subject: Re: [PATCH] selftests: futex: delete RUN_TESTS and EMIT_TESTS
 overrides
To: Darren Hart <dvhart@infradead.org>
Cc: tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180502211848.22404-1-shuah@kernel.org>
 <20180502211848.22404-2-shuah@kernel.org> <20180511151320.GA6391@fury>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <1ab4e7fb-91af-e706-a6df-e7d9f16e21ae@kernel.org>
Date: Fri, 11 May 2018 09:25:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511151320.GA6391@fury>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 09:13 AM, Darren Hart wrote:
> On Wed, May 02, 2018 at 03:18:45PM -0600, Shuah Khan (Samsung OSG) wrote:
>> Delete RUN_TESTS and EMIT_TESTS overrides and use common defines in
>> lib.mk. Common defines work just fine and there is no need to define
>> custom overrides.
>>
>> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> 
> I was concerned because this override was a deliberate decision made in:
> 
> 9705315b7562 selftests/futex: Update Makefile to use lib.mk

Yes I had the same concern.
> 
> But reviewing lib.mk today, the RUN_TESTS and EMIT_TESTS perform the same
> function running TEST_PROGS.
> 
> Reviewed-by: Darren Hart (VMware) <dvhart@infradead.org>
> 

Thanks. Yes I was surprised as well. I ran a few times to make sure. :)

-- Shuah
