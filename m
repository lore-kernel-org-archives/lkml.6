Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966152AbeEJPMZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:12:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38256 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965665AbeEJPMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:12:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6BA6D601A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Thu, 10 May 2018 09:12:21 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, rplsssn@codeaurora.org
Subject: Re: [PATCH v8 03/10] drivers: qcom: rpmh-rsc: log RPMH requests in
 FTRACE
Message-ID: <20180510151221.GG4698@codeaurora.org>
References: <20180509170159.29682-1-ilina@codeaurora.org>
 <20180509170159.29682-4-ilina@codeaurora.org>
 <20180509134923.1e315a7c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180509134923.1e315a7c@gandalf.local.home>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09 2018 at 11:49 -0600, Steven Rostedt wrote:
>On Wed,  9 May 2018 11:01:52 -0600
>Lina Iyer <ilina@codeaurora.org> wrote:
>
>> Log sent RPMH requests and interrupt responses in FTRACE.
>
>Has this changed since the last time I reviewed it? If not, please add
>the: Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>to you patch queue.
>
Sorry, no it did not change in v8.
I will add your reviewed-by tag. Thanks Steve.

-- Lina

>-- Steve
>
>>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>
>> Changes in v7:
>> 	- varible name changes and white space
>>
>> Changes in v6:
>> 	- struct tcs_response was removed. Fix in trace as well.
>> Changes in v4:
>> 	- fix compilation issues, use __assign_str
>> 	- use %#x instead of 0x%08x
>> Changes in v3:
>> 	- Use __string() instead of char *
>> 	- fix TRACE_INCLUDE_PATH
>> ---
