Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeDDPiO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:38:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbeDDPiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:38:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2350221707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 4 Apr 2018 11:38:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180404113809.64955e93@gandalf.local.home>
In-Reply-To: <20180404152713.GM6312@dhcp22.suse.cz>
References: <20180403135607.GC5501@dhcp22.suse.cz>
        <20180403101753.3391a639@gandalf.local.home>
        <20180403161119.GE5501@dhcp22.suse.cz>
        <20180403185627.6bf9ea9b@gandalf.local.home>
        <20180404062039.GC6312@dhcp22.suse.cz>
        <20180404085901.5b54fe32@gandalf.local.home>
        <20180404141052.GH6312@dhcp22.suse.cz>
        <20180404102527.763250b4@gandalf.local.home>
        <20180404144255.GK6312@dhcp22.suse.cz>
        <20180404110442.4cf904ae@gandalf.local.home>
        <20180404152713.GM6312@dhcp22.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018 17:27:13 +0200
Michal Hocko <mhocko@kernel.org> wrote:


> I am afraid I cannot help you much more though.

No, you have actually been a great help. I'm finishing up a patch on
top of this one. I'll be posting it soon.

Thanks for your help and your time!

-- Steve
