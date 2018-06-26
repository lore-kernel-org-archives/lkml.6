Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F2EC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A856E2630D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A856E2630D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935702AbeFZOUf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934063AbeFZOUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:20:34 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54AA4257B0;
        Tue, 26 Jun 2018 14:20:32 +0000 (UTC)
Date:   Tue, 26 Jun 2018 10:20:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        James Morris <james.morris@microsoft.com>,
        Xiongwei Song <sxwjean@me.com>,
        Changbin Du <changbin.du@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH 9/9] docs: histogram.txt: convert it to ReST file format
Message-ID: <20180626102030.69bf840a@gandalf.local.home>
In-Reply-To: <4e8df7559e48b4b90bca73cf08d4e01497a39066.1530005114.git.mchehab+samsung@kernel.org>
References: <cover.1530005114.git.mchehab+samsung@kernel.org>
        <4e8df7559e48b4b90bca73cf08d4e01497a39066.1530005114.git.mchehab+samsung@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018 06:49:11 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> Despite being mentioned at Documentation/trace/ftrace.rst as a
> rst file, this file was still a text one, with several issues.
> 
> Convert it to ReST and add it to the trace index:
> - Mark the document title as such;
> - Identify and indent the literal blocks;
> - Use the proper markups for table.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/trace/events.rst                |    2 +-
>  .../trace/{histogram.txt => histogram.rst}    | 1242 +++++++++--------
>  Documentation/trace/index.rst                 |    1 +
>  kernel/trace/Kconfig                          |    2 +-
>  4 files changed, 627 insertions(+), 620 deletions(-)
>  rename Documentation/trace/{histogram.txt => histogram.rst} (73%)
> 

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
