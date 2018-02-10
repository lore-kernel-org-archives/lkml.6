Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751299AbeBJRha (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 12:37:30 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:53269 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbeBJRh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 12:37:29 -0500
Subject: Re: [PATCH] x86/Kconfig: Further simplify the NR_CPUS config
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
References: <56d0376c-dc1f-334b-d392-a8c5cd85f4aa@infradead.org>
 <CA+55aFymknkNH2mP1vX5ZLEqQwA3BgxQhZF-SUbbJMwTDL6hAA@mail.gmail.com>
 <0b833246-ed4b-e451-c426-c4464725be92@infradead.org>
 <20180210113629.jcv6su3r4suuno63@gmail.com>
 <20180210113842.7j62u7rxp4jscei2@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8d95c35f-bfe0-3397-f53c-d8f2adf8e2f7@infradead.org>
Date: Sat, 10 Feb 2018 09:37:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180210113842.7j62u7rxp4jscei2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2018 03:38 AM, Ingo Molnar wrote:
> 
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Ingo Molnar <mingo@kernel.org>
>> ---
>>  arch/x86/Kconfig |   66 +++++++++++++++++++++++++++++++++----------------------
>>  1 file changed, 40 insertions(+), 26 deletions(-)
> 
> Here is a full combo patch of your patch and mine, for easier review:
> 

Looks very nice.  Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
if you want it.


-- 
~Randy
