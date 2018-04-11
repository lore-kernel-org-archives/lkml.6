Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeDKMoC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 08:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752382AbeDKMoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 08:44:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F31721737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 11 Apr 2018 08:43:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, keescook@chromium.org,
        wangnan0@huawei.com, mingo@redhat.com, srikar@linux.vnet.ibm.com,
        oleg@redhat.com, mhiramat@kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v2 1/2] trace_uprobe: Use %lx to display offset
Message-ID: <20180411084357.5fc776c3@gandalf.local.home>
In-Reply-To: <e56cfe4e-24cd-e01d-899b-a2862a6afd66@linux.vnet.ibm.com>
References: <20180315082756.9050-1-ravi.bangoria@linux.vnet.ibm.com>
        <e56cfe4e-24cd-e01d-899b-a2862a6afd66@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2018 11:42:51 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> Hi Steve,
> 
> Can you please pull these patches.
> 

Sure. I'll pull them in now and start testing them.

-- Steve
