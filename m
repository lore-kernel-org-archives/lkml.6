Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0AAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1858204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1858204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeICMLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 08:11:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725969AbeICMLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 08:11:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E245A4023ECC;
        Mon,  3 Sep 2018 07:52:52 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 167E72156701;
        Mon,  3 Sep 2018 07:52:51 +0000 (UTC)
Date:   Mon, 3 Sep 2018 09:52:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Make perf script easier to use for itrace
Message-ID: <20180903075251.GF24575@krava>
References: <20180831220206.28351-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831220206.28351-1-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 03 Sep 2018 07:52:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 03 Sep 2018 07:52:52 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 03:01:56PM -0700, Andi Kleen wrote:

SNIP

>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                          calc_timer_values
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              sched_clock_cpu
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                          __x86_indirect_thunk_rax
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                          arch_perf_update_userpage
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              __fentry__
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              using_native_sched_clock
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              sched_clock_stable
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_pmu_enable
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])              __x86_indirect_thunk_rax
> 
> 
> Also available in
> git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git pt/easy-script-2
> 
> v1: Initial post
> v2: Address review comments. Minor fixes to descriptions. Now builds everywhere.

with those changelogs updates:

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
