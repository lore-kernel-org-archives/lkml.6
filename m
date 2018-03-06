Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754122AbeCFV4d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 16:56:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45692 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753923AbeCFV4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 16:56:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB463601CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Tue, 6 Mar 2018 14:56:30 -0700
From: Lina Iyer <ilina@codeaurora.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] drivers: qcom: rpmh-rsc: log RPMH requests in
 FTRACE
Message-ID: <20180306215630.GE4930@codeaurora.org>
References: <20180302164317.10554-4-ilina@codeaurora.org>
 <201803061347.bjigZje9%fengguang.wu@intel.com>
 <20180306164704.3c33c046@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180306164704.3c33c046@vmware.local.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06 2018 at 14:47 -0700, Steven Rostedt wrote:
>On Tue, 6 Mar 2018 13:38:06 +0800
>kbuild test robot <lkp@intel.com> wrote:
>
>> >> drivers/soc/qcom/./trace-rpmh.h:29:3: error: implicit declaration of function '__assign_string'; did you mean '__assign_str'? [-Werror=implicit-function-declaration]
>
>Yes, you meant __assign_str(). I may have said __assign_string() in my
>comments, but I was doing it from memory, not actually compiling code.
>
>Please make sure you test the code and make sure it builds before
>posting. And displays the tracepoint as you expect it to.
>
I compiled and checked for sparse. Didn't explictly test for this. Not
sure why it did not fail for me.

-- Lina
