Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbeEBTp7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 15:45:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750939AbeEBTpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 15:45:54 -0400
Date: Wed, 2 May 2018 15:45:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v7 03/10] drivers: qcom: rpmh-rsc: log RPMH requests in
 FTRACE
Message-ID: <20180502154551.340bcc3e@gandalf.local.home>
In-Reply-To: <20180502193749.31004-4-ilina@codeaurora.org>
References: <20180502193749.31004-1-ilina@codeaurora.org>
        <20180502193749.31004-4-ilina@codeaurora.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 May 2018 13:37:42 -0600
Lina Iyer <ilina@codeaurora.org> wrote:

> Log sent RPMH requests and interrupt responses in FTRACE.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

It's now up to the subsystem maintainer to apply it.

-- Steve
