Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB3CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 23:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4CC205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 23:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeLaX4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 18:56:16 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:33187 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbeLaX4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 18:56:16 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id wBVNu2uF006893;
        Tue, 1 Jan 2019 00:56:02 +0100
Date:   Tue, 1 Jan 2019 00:56:02 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joey Pabalinas <joeypabalinas@gmail.com>, mingo@kernel.org,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] rcutorture/nolibc: add a bit of documentation to
 explain how to use nolibc
Message-ID: <20181231235602.GB6885@1wt.eu>
References: <20181229180218.15798-1-w@1wt.eu>
 <20181229180218.15798-4-w@1wt.eu>
 <20181229223324.slqx3qjrmzg5g2w2@gmail.com>
 <20181230070846.GA17139@1wt.eu>
 <20181230074020.nirv2jzf6lh7s5lf@gmail.com>
 <20181231200854.GS4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181231200854.GS4170@linux.ibm.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 12:08:54PM -0800, Paul E. McKenney wrote:
> The English rules for capitalization and lists are baroque and completely
> unsuited to word processors ("If any list item is longer than one line,
> capitalize all the items."), but in this case each item has multiple
> sentences, so it makes sense to capitalize.
> 
> Please see below for the updated commit, and thank you all!

OK, this looks fine to me, thank you Paul!

> And Happy New Year!!!  ;-)

Oh and same to you ;-)

willy
