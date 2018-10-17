Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BEAECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A8620869
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A8620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeJRHAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:00:36 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:45024 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeJRHAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:00:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 6177F42345;
        Wed, 17 Oct 2018 23:02:40 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xTKVIsz3VhcG; Wed, 17 Oct 2018 23:02:40 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 2975740C24;
        Wed, 17 Oct 2018 23:02:31 +0000 (UTC)
Subject: Re: [PATCH] selftests/ftrace: Strip escape sequences for log file
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        linux-kselftest@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20181017100305.0b3c03461b098f8943805455@gmail.com>
 <153974720272.17748.17439079576533415951.stgit@devbox>
 <20181017164514.23bcc9c3@gandalf.local.home>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <cd3b8cc9-fdf0-9b29-5445-1d8e24e148d8@kernel.org>
Date:   Wed, 17 Oct 2018 17:02:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181017164514.23bcc9c3@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 02:45 PM, Steven Rostedt wrote:
> On Wed, 17 Oct 2018 12:33:23 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
>> Strip escape sequences from the stream to the ftracetest
>> summary log file. Note that all test-case results are
>> dumped raw in each file.
>>
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Shuah,
> 
> Please take this one too.
> 

Yup. Applied to linux-kselftest for 4.20-rc1.

thanks,
-- Shuah

