Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754289AbeCFWeg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 17:34:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754272AbeCFWee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 17:34:34 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4C3217A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 6 Mar 2018 17:34:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] drivers: qcom: rpmh-rsc: log RPMH requests in
 FTRACE
Message-ID: <20180306173432.2c43840f@vmware.local.home>
In-Reply-To: <20180306220542.GF4930@codeaurora.org>
References: <20180302164317.10554-4-ilina@codeaurora.org>
        <201803061347.bjigZje9%fengguang.wu@intel.com>
        <20180306164704.3c33c046@vmware.local.home>
        <20180306215630.GE4930@codeaurora.org>
        <20180306220542.GF4930@codeaurora.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2018 15:05:42 -0700
Lina Iyer <ilina@codeaurora.org> wrote:

> Duh. FTRACE seems to have been disabled. Will fix and update.

Don't feel bad. You're not alone, I've done that too ;-)

-- Steve
