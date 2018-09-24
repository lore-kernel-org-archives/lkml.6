Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A81ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DF020C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DF020C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbeIXXwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:52:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbeIXXwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:52:06 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A7D5C057F85;
        Mon, 24 Sep 2018 17:48:49 +0000 (UTC)
Received: from krava (unknown [10.43.17.97])
        by smtp.corp.redhat.com (Postfix) with SMTP id 762472010CF7;
        Mon, 24 Sep 2018 17:48:47 +0000 (UTC)
Date:   Mon, 24 Sep 2018 19:48:46 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-trace-devel@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [PATCH 00/15] tools/lib/traceevent: Namespace updates to make
 traceevent into a library
Message-ID: <20180924174846.GC22809@krava>
References: <20180919185643.358126338@goodmis.org>
 <20180923185626.GC30923@krava>
 <20180924045523.2c15be13@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924045523.2c15be13@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 24 Sep 2018 17:48:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 04:55:23AM -0400, Steven Rostedt wrote:
> On Sun, 23 Sep 2018 20:56:26 +0200
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > 
> > Steven,
> > is there still something left to rename, or we can start moving it into public rpm?
> > 
> 
> We're testing it as a external library, and we did find something. Did
> you get this patch?
> 
>  https://lore.kernel.org/lkml/20180921152037.1e23c7f4@gandalf.local.home

ah yep, overlooked this one.. going to check it

jirka

> 
> We're testing it against powertop and mceutils, when we get it working
> well with them, then I think it's time to start going ahead and making
> it into an rpm.
> 
> Thanks Jiri!
> 
> -- Steve
