Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A9BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E7420664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E7420664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbeKAIBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:01:37 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:33340 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbeKAIBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:01:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A5B02609F834;
        Thu,  1 Nov 2018 00:01:26 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UvjovhtSD_dO; Thu,  1 Nov 2018 00:01:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 60554609F83D;
        Thu,  1 Nov 2018 00:01:26 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2nQseFWmo_ON; Thu,  1 Nov 2018 00:01:26 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 26543609F834;
        Thu,  1 Nov 2018 00:01:26 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] UML changes for 4.20-rc1
Date:   Thu, 01 Nov 2018 00:01:25 +0100
Message-ID: <4324649.OiLOZ4spUA@blindfold>
In-Reply-To: <CAHk-=wjw8qra+SYDDjvSnZ=APsn9aFG9WiJGSLD94A0Q_+BZWg@mail.gmail.com>
References: <1829585.6m1bt7BjAO@blindfold> <CAHk-=wjw8qra+SYDDjvSnZ=APsn9aFG9WiJGSLD94A0Q_+BZWg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 31. Oktober 2018, 23:48:07 CET schrieb Linus Torvalds:
> On Wed, Oct 31, 2018 at 2:22 PM Richard Weinberger <richard@nod.at> wrote:
> >
> > - Removal of old and dead code
> > - A bug fix for our tty driver
> > - Other minor cleanups across the code base
> 
> Pulled. I may not like recent rebases, but I do like this:

Okay, so my rebase was in vain, I thought you don't like pull requests
with such an old base.

Thanks,
//richard


