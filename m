Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964851AbeEIRt2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:32888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933555AbeEIRt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:49:27 -0400
Date: Wed, 9 May 2018 13:49:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, rplsssn@codeaurora.org
Subject: Re: [PATCH v8 03/10] drivers: qcom: rpmh-rsc: log RPMH requests in
 FTRACE
Message-ID: <20180509134923.1e315a7c@gandalf.local.home>
In-Reply-To: <20180509170159.29682-4-ilina@codeaurora.org>
References: <20180509170159.29682-1-ilina@codeaurora.org>
        <20180509170159.29682-4-ilina@codeaurora.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 May 2018 11:01:52 -0600
Lina Iyer <ilina@codeaurora.org> wrote:

> Log sent RPMH requests and interrupt responses in FTRACE.

Has this changed since the last time I reviewed it? If not, please add
the: Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
to you patch queue.

-- Steve

> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> 
> Changes in v7:
> 	- varible name changes and white space
> 
> Changes in v6:
> 	- struct tcs_response was removed. Fix in trace as well.
> Changes in v4:
> 	- fix compilation issues, use __assign_str
> 	- use %#x instead of 0x%08x
> Changes in v3:
> 	- Use __string() instead of char *
> 	- fix TRACE_INCLUDE_PATH
> ---
