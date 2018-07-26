Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5B3C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22C420862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22C420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbeGZWlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 18:41:23 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:46997 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730474AbeGZWlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 18:41:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 9C534C0ECB;
        Thu, 26 Jul 2018 21:22:43 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gctNcpkZIDCd; Thu, 26 Jul 2018 21:22:43 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 9BBDEC0637;
        Thu, 26 Jul 2018 21:22:33 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] selftests/ftrace: Fix kprobe string testcase to
 not probe notrace function
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <153258437722.11602.12405835083073480618.stgit@devbox>
 <153258446365.11602.5245508133014563916.stgit@devbox>
 <20180726164409.c4967698668b1816a8e9747c@kernel.org>
 <20180726155848.5d45aedb@gandalf.local.home>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <555469b9-a866-60f1-6856-e8bd80f99591@kernel.org>
Date:   Thu, 26 Jul 2018 15:22:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180726155848.5d45aedb@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/2018 01:58 PM, Steven Rostedt wrote:
> On Thu, 26 Jul 2018 16:44:09 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
>> On Thu, 26 Jul 2018 14:54:23 +0900
>> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>
>>> Fix kprobe string argument testcase to not probe notrace
>>> function. Instead, it probes tracefs function which must
>>> be available with ftrace.  
>>
>> Oops, this must be sent to Shuah too.
>>
>> Shuah, I think you can freely pick this patch to kselftest
>> branch, since this removes a dependency of notrace functions,
>> not depends on any new feature :)
>>
> 
> Shuah,
> 
> Please take this patch in your tree. I'll take the other two.
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> -- Steve
> 

Steve,

yes. I will pick this up.

thanks,
-- Shuah


