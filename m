Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA91C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DAA223DB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DAA223DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeHJInB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 04:43:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35016 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725746AbeHJInA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 04:43:00 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 35F0D74;
        Fri, 10 Aug 2018 06:14:37 +0000 (UTC)
Date:   Fri, 10 Aug 2018 08:14:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Joseph <jnjoseph@google.com>
Cc:     Todd Poynor <toddpoynor@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 01/16] MAINTAINERS: Switch a maintainer for
 drivers/staging/gasket
Message-ID: <20180810061422.GB1062@kroah.com>
References: <20180810032111.197743-1-toddpoynor@gmail.com>
 <20180810032111.197743-2-toddpoynor@gmail.com>
 <CAOmRg6P53DdsmMKOXpB2RWueU5d2Otzg_gyWgcX+5cPf+wSJ7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOmRg6P53DdsmMKOXpB2RWueU5d2Otzg_gyWgcX+5cPf+wSJ7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 08:40:06PM -0700, John Joseph wrote:
> Acked-by: John Joseph <jnjoseph@google.com>

Why are you acking something you supposidly already signed-off on?

> On Thu, Aug 9, 2018 at 8:20 PM, Todd Poynor <toddpoynor@gmail.com> wrote:
> > From: Todd Poynor <toddpoynor@google.com>
> >
> > Todd Poynor takes over for John Joseph.
> >
> > Signed-off-by: John Joseph <jnjoseph@google.com>
> > Signed-off-by: Todd Poynor <toddpoynor@google.com>

Did you not really provide your signed-off-by here?

totally confused,

greg k-h
