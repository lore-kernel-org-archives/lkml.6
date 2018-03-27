Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeC0POj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751349AbeC0POi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:14:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352A8217A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 27 Mar 2018 11:14:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@gmail.com>
Subject: Re: [PATCH] ftrace: fix stddev calculation in function profiler
 (again)
Message-ID: <20180327111435.568b6d8a@gandalf.local.home>
In-Reply-To: <966ff66c-5ab9-23c4-7c23-01a802c20159@universe-factory.net>
References: <f208c5c360f1e86327b0adbb879d61f4779e8ddd.1521908409.git.mschiffer@universe-factory.net>
        <20180326125131.15fba249@gandalf.local.home>
        <966ff66c-5ab9-23c4-7c23-01a802c20159@universe-factory.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018 16:51:49 +0200
Matthias Schiffer <mschiffer@universe-factory.net> wrote:

> I mentioned in my commit message was caused by the second MIPS-specific
> issue I mentioned in my last mail, so while this method may lead to
> inaccurate results [1], and it is certainly not Welford's method, it might
> be good enough in practice, and you can disregard my patch.

Thanks for verifying.

Did you have any other patches to this code I need to look at?

-- Steve
