Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D90C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99584222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbfBOSFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:05:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730285AbfBOSFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:05:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3BF23CA65D;
        Fri, 15 Feb 2019 18:05:12 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-20.phx2.redhat.com [10.3.112.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07C6C6E9E7;
        Fri, 15 Feb 2019 18:05:10 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 1558755D3; Fri, 15 Feb 2019 16:05:06 -0200 (BRST)
Date:   Fri, 15 Feb 2019 16:05:06 -0200
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>, acme@kernel.org
Subject: Re: [PATCH v2 perf,bpf 09/11] perf-top: add option --bpf-event
Message-ID: <20190215180506.GI5784@redhat.com>
References: <20190214235624.2579307-1-songliubraving@fb.com>
 <20190215000010.2590505-1-songliubraving@fb.com>
 <20190215000010.2590505-8-songliubraving@fb.com>
 <20190215142749.GD5784@redhat.com>
 <31C00A93-54B4-40D0-AC63-A19368AEC669@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31C00A93-54B4-40D0-AC63-A19368AEC669@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 15 Feb 2019 18:05:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 15, 2019 at 05:06:19PM +0000, Song Liu escreveu:
> > On Feb 15, 2019, at 6:27 AM, Arnaldo Carvalho de Melo <acme@redhat.com> wrote:
> > Em Thu, Feb 14, 2019 at 04:00:10PM -0800, Song Liu escreveu:
> >> bpf events are only tracked when opts->bpf_event is enabled. This patch
> >> adds command line flag to enable this for perf-top.
 
> > Shouldn't this start as enabled and we just provide a way to disable it
> > for testing purposes? Normally perf top works system wide, and then we
> > want to get info about BPF events, I think.

> We can enable it by default, and add a --no-bpf-event option to disable it
> for testing. 

Excellent, thanks.

- Arnaldo
