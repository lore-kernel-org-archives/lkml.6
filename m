Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003F5C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 11:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCD221019
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 11:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbeL3LjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 06:39:05 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:33092 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbeL3LjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 06:39:05 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id wBUBcfGw017376;
        Sun, 30 Dec 2018 12:38:41 +0100
Date:   Sun, 30 Dec 2018 12:38:41 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>, acme@redhat.com,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] tools headers: move the nolibc header from rcutorture to
 tools/include/nolibc/
Message-ID: <20181230113841.GA17373@1wt.eu>
References: <20181229180453.15889-1-w@1wt.eu>
 <20181229182508.GJ4170@linux.ibm.com>
 <20181230112502.GA16126@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181230112502.GA16126@gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 12:25:02PM +0100, Ingo Molnar wrote:
Could we please also use the opportunity and move 
> nolibc.h to a more prominent place, like in tools/include/nolibc/nolibc.h 
> or so?

It's exactly what the last patch does, I followed your suggestion :-)

Willy
