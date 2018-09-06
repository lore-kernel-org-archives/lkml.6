Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF14BC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B271E20645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B271E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbeIFElL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 00:41:11 -0400
Received: from namei.org ([65.99.196.166]:46164 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbeIFElK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 00:41:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w8608UTA023519;
        Thu, 6 Sep 2018 00:08:30 GMT
Date:   Thu, 6 Sep 2018 10:08:30 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] seccomp: remove unnecessary unlikely()
In-Reply-To: <CAGXu5jKoKsj=qbKrcYGiQWJnSrLwfoBHL40RK37qZyLgXWk=DQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1809061008210.23269@namei.org>
References: <20180905203443.32289-1-igor.stoppa@huawei.com> <CAGXu5j+e2n6pUW+40ZNm5qifd8dVEEryN-Qfqe7ok-KZHP1Hyw@mail.gmail.com> <2192189d-b8bb-3233-c9f3-14cbeeddaf34@gmail.com> <CAGXu5jKoKsj=qbKrcYGiQWJnSrLwfoBHL40RK37qZyLgXWk=DQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018, Kees Cook wrote:

> On Wed, Sep 5, 2018 at 3:49 PM, Igor Stoppa <igor.stoppa@gmail.com> wrote:
> >
> >
> > On 06/09/18 01:23, Kees Cook wrote:
> >
> >> Should I take this, or is it part of your series going somewhere else?
> >
> >
> > It turned out it doesn't really work to have a generic series against 20
> > trees :-/
> 
> I know that pain very well!
> 
> > I'm submitting them individually to each subsystem.
> > So this one is just for security.
> 
> Sounds good.
> 
> James, can you take this directly, or would you prefer a pull request from me?

I'll take it with your ack.

-- 
James Morris
<jmorris@namei.org>

