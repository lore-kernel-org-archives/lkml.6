Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754052AbeCFVrI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 16:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753876AbeCFVrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 16:47:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118312178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 6 Mar 2018 16:47:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: kbuild test robot <lkp@intel.com>
Cc: Lina Iyer <ilina@codeaurora.org>, kbuild-all@01.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] drivers: qcom: rpmh-rsc: log RPMH requests in
 FTRACE
Message-ID: <20180306164704.3c33c046@vmware.local.home>
In-Reply-To: <201803061347.bjigZje9%fengguang.wu@intel.com>
References: <20180302164317.10554-4-ilina@codeaurora.org>
        <201803061347.bjigZje9%fengguang.wu@intel.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2018 13:38:06 +0800
kbuild test robot <lkp@intel.com> wrote:

> >> drivers/soc/qcom/./trace-rpmh.h:29:3: error: implicit declaration of function '__assign_string'; did you mean '__assign_str'? [-Werror=implicit-function-declaration]  

Yes, you meant __assign_str(). I may have said __assign_string() in my
comments, but I was doing it from memory, not actually compiling code.

Please make sure you test the code and make sure it builds before
posting. And displays the tracepoint as you expect it to.

Thanks,

-- Steve


>       __assign_string(name, d->name);
>       ^
>    include/trace/trace_events.h:719:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
