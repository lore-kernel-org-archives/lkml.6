Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B955EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B98821508
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B98821508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404651AbeKLIdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:33:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731396AbeKLIdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:33:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A2A5308624F;
        Sun, 11 Nov 2018 22:43:39 +0000 (UTC)
Received: from krava (ovpn-204-16.brq.redhat.com [10.40.204.16])
        by smtp.corp.redhat.com (Postfix) with SMTP id B816819745;
        Sun, 11 Nov 2018 22:43:37 +0000 (UTC)
Date:   Sun, 11 Nov 2018 23:43:36 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
Message-ID: <20181111224336.GA30042@krava>
References: <20181108071303.GB29732@krava>
 <20181108.170721.825832647693654935.davem@davemloft.net>
 <20181111194132.GA3769@krava>
 <20181111.143208.353362314504370863.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111.143208.353362314504370863.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sun, 11 Nov 2018 22:43:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 02:32:08PM -0800, David Miller wrote:
> From: Jiri Olsa <jolsa@redhat.com>
> Date: Sun, 11 Nov 2018 20:41:32 +0100
> 
> > I added the dropping logic, it's simple so far..
> 
> How do you maintain your perf/fixes branch?  Do you rebase? :-/
> 
> I just pulled after a previous pull and got nothing but conflicts on
> every single file.

yep, I rebase.. it's my devel branch, I dont keep it sane, sry ;-)

jirka
