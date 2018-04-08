Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeDHDsQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 23:48:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752012AbeDHDsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 23:48:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B96621773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Sat, 7 Apr 2018 23:48:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-patch-test@lists.linaro.org
Subject: Re: [PATCH v1] ringbuffer: Don't choose the process with adj equal
 OOM_SCORE_ADJ_MIN
Message-ID: <20180407234812.2bf2b24b@gandalf.local.home>
In-Reply-To: <1523153783-20579-1-git-send-email-zhaoyang.huang@spreadtrum.com>
References: <1523153783-20579-1-git-send-email-zhaoyang.huang@spreadtrum.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  8 Apr 2018 10:16:23 +0800
Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:

> Don't choose the process with adj == OOM_SCORE_ADJ_MIN which
> over-allocating pages for ring buffers.

Why?

-- Steve
