Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7C5C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F3D20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfAULyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:54:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbfAULyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:54:52 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B592792B8;
        Mon, 21 Jan 2019 11:54:52 +0000 (UTC)
Received: from krava (unknown [10.40.205.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id EE4CC5D737;
        Mon, 21 Jan 2019 11:54:49 +0000 (UTC)
Date:   Mon, 21 Jan 2019 12:54:48 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] perf record: implement --affinity=node|cpu option
Message-ID: <20190121115448.GB3852@krava>
References: <77852017-b6ee-4fe1-4f3d-63827d78078f@linux.intel.com>
 <8086d41c-21eb-1c80-9a62-22c08d961b14@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8086d41c-21eb-1c80-9a62-22c08d961b14@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 21 Jan 2019 11:54:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 12:23:56PM +0300, Alexey Budankov wrote:
> 
> Implement --affinity=node|cpu option for the record mode defaulting
> to system affinity mask bouncing.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> changes in v3:
> - adjusted indentation at record__parse_affinity()

having problems to apply this one:

Applying: perf record: allocate affinity masks
Applying: perf record: bind the AIO user space buffers to nodes
Applying: perf record: apply affinity masks when reading mmap buffers
Applying: perf record: implement --affinity=node|cpu option
error: corrupt patch at line 62
Patch failed at 0004 perf record: implement --affinity=node|cpu option


jirka
