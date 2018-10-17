Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B026EECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2AD20869
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2AD20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeJRG7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:59:54 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:37131 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeJRG7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:59:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 1686BC0B17;
        Wed, 17 Oct 2018 23:01:58 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BEi1UgVhc6cb; Wed, 17 Oct 2018 23:01:58 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 6B3CAC08DD;
        Wed, 17 Oct 2018 23:01:46 +0000 (UTC)
Subject: Re: [PATCH] selftests/ftrace: Use colored output when available
To:     Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Cc:     linux-kselftest@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <20181016170220.31156-1-daniel.diaz@linaro.org>
 <20181017164103.4fb8692f@gandalf.local.home>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <ba605b17-9de2-3fc8-4b2a-daf9edfa96c9@kernel.org>
Date:   Wed, 17 Oct 2018 17:01:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181017164103.4fb8692f@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 02:41 PM, Steven Rostedt wrote:
> On Tue, 16 Oct 2018 12:02:20 -0500
> Daniel Díaz <daniel.diaz@linaro.org> wrote:
> 
>> If test is being directly executed (with stdout opened on the
>> terminal) and the terminal capabilities indicate enough
>> colors, then use the existing scheme of green, red, and blue
>> to show when tests pass, fail or end in a different way.
>>
>> When running the tests redirecting the stdout, for instance,
>> to a file, then colors are not shown, thus producing a more
>> readable output.
>>
>> Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Shuah, can you pull this into your tree?
> 
Applied to linux-ksefltest next for 4.20-rc1

thanks,
-- Shuah

