Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeDEScj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 14:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751563AbeDESch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 14:32:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B470020B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 5 Apr 2018 14:32:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v5 03/10] drivers: qcom: rpmh-rsc: log RPMH requests in
 FTRACE
Message-ID: <20180405143233.53de33e1@gandalf.local.home>
In-Reply-To: <20180405161834.3850-4-ilina@codeaurora.org>
References: <20180405161834.3850-1-ilina@codeaurora.org>
        <20180405161834.3850-4-ilina@codeaurora.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Apr 2018 10:18:27 -0600
Lina Iyer <ilina@codeaurora.org> wrote:

> Log sent RPMH requests and interrupt responses in FTRACE.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Still looks good.

-- Steve
