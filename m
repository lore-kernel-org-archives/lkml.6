Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753965AbeDYMXk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:23:40 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:45704 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDYMXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:23:37 -0400
From: Richard Weinberger <richard@sigma-star.at>
To: Enrico Weigelt <lkml@metux.net>,
        "Enrico Weigelt, metux IT consult" <metux@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] p9caps: add Plan9 capability devices
Date: Wed, 25 Apr 2018 14:23:34 +0200
Message-ID: <3634890.Egg3N7Xbv6@blindfold>
In-Reply-To: <3ffb5399-46b8-7279-fda2-2ca5b40c04d3@metux.net>
References: <40d4c871-a16a-7b8f-2d4a-422a5a490693@infradead.org> <CAFLxGvwHebXuQYwOdG_vnYfjwtdMfCHg5srzjsj1fEaCFm2QGw@mail.gmail.com> <3ffb5399-46b8-7279-fda2-2ca5b40c04d3@metux.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 25. April 2018, 12:38:02 CEST schrieb Enrico Weigelt:
> >> +       list_for_each_safe(pos, q, &(caphash_writers)) {
> >> +               tmp = list_entry(pos, struct caphash_entry, list);
> > 
> > list_for_each_entry.
> 
> what's the exact difference ?

Whoops, I meant list_for_each_entry_safe().
You don't list_entry() then.

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y
