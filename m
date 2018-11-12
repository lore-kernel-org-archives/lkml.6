Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB5AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383B0214F1
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383B0214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbeKLPaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:30:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:54432 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730979AbeKLPaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:30:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D43C0AF97;
        Mon, 12 Nov 2018 05:38:30 +0000 (UTC)
Date:   Sun, 11 Nov 2018 21:38:24 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     akpm@linux-foundation.org, jbaron@akamai.com,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/2] perf-bench: Add epoll parallel epoll_wait benchmark
Message-ID: <20181112053824.ccpq6h3vsukdxwmg@linux-r8p5>
References: <20181106152226.20883-1-dave@stgolabs.net>
 <20181106152226.20883-2-dave@stgolabs.net>
 <20181106182349.thdkpvshkna5vd7o@linux-r8p5>
 <20181106191325.GM7077@kernel.org>
 <20181108134500.GA15568@kernel.org>
 <20181109210719.pr7ohayuwqmfp2wl@linux-r8p5>
 <20181111173351.GC1111@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181111173351.GC1111@kernel.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2018, Arnaldo Carvalho de Melo wrote:
>Gets it a bit further, then we get this, which I think should be fixed
>using some PRIu64, etc. I'll try to do that at some point, but in short
>vacations now, then plumbers :-)

Yeah sorry, I didn't mean to suggest that was it. I can send the follow
up patches, or a v2 altogether if you prefer.

See you at lpc.

Thanks,
Davidlohr
