Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752235AbeDGWgt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 18:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752034AbeDGWgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 18:36:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F072177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Sat, 7 Apr 2018 18:36:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wenle Chen <solomonwen@163.com>
Cc: chenwenle@huawei.com, jhogan@kernel.org, linux@roeck-us.net,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        solachenclever@hotmail.com
Subject: Re: [PATCH] scripts : sync the var type between memory and print
Message-ID: <20180407183644.79db9808@gandalf.local.home>
In-Reply-To: <1523095295-5575-1-git-send-email-solomonwen@163.com>
References: <1523095295-5575-1-git-send-email-solomonwen@163.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  7 Apr 2018 18:01:35 +0800
Wenle Chen <solomonwen@163.com> wrote:

> From: Wenle Chen <chenwenle@huawei.com>
> 
>     The %d in printf need get a int
> But the real type of these vars is unsigned.
> It may let some compilers show a warning.

Thanks but the merge window is currently open. It's best to not send
patches during it. Please send this again after 4.17-rc1 is released.

-- Steve
