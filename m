Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FDEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49DB2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550851185;
	bh=WKZw2aXxsQc1K0LynL62LnXcC5cSf4dnGvng2QXvjU0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=IXJEM5qsODhbF8QmA03lXGC9nMfBdQL2QjpDtkbp3c/IPW9TRRYna4CQoReK/m/BW
	 nK0MJkQMetjjdieDc0vXm8KCxH/P40f61TrgZrosinimRf9h/Yw6f3yik2RjBYPUHk
	 DY2id78fMqR9YRZjqf4D35Cx0kN2VBM9GH6TPulM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfBVP7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:59:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfBVP7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:59:44 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 480DA2070D;
        Fri, 22 Feb 2019 15:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550851183;
        bh=WKZw2aXxsQc1K0LynL62LnXcC5cSf4dnGvng2QXvjU0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nyBdnh5mUR/d2V00hyKwcW090s+N51lMuzP4fPD3ESBfUtKwTqQRyR4O0O4or7cIX
         3nSdOqyyn83CTaoEN1F3+sDXjdrMprTJAy0S9jXSwPWMCpy0a1zl/j+1MAPgkD3zJg
         DmuUcJnZqLO7Dv1Dj4aUrBVt8U/kntthD6WboNrk=
Subject: Re: [PATCH v2 2/2] selftests/ftrace: Replace \e with \033
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, Juerg Haefliger <juergh@canonical.com>,
        shuah <shuah@kernel.org>
References: <20190220161333.28109-1-juergh@canonical.com>
 <20190222091021.10178-1-juergh@canonical.com>
 <20190222091021.10178-3-juergh@canonical.com>
 <20190222235915.bdf82008eef24f8189bd33ec@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <9da084b1-7f60-ecbd-a956-76d72eb2309d@kernel.org>
Date:   Fri, 22 Feb 2019 08:59:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222235915.bdf82008eef24f8189bd33ec@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/19 7:59 AM, Masami Hiramatsu wrote:
> On Fri, 22 Feb 2019 10:10:21 +0100
> Juerg Haefliger <juerg.haefliger@canonical.com> wrote:
> 
>> The \e sequence character is not POSIX. Fix that by using \033 instead.
>>
>> Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> 
> This also looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thank you!
> 


I wasn't on the To or Cc on the original patch. Make sure to
run the get_maintainers and include the people it recommends.

Please resend the patch to me, so I can take it for 5.1-rc1

thanks,
-- Shuah
