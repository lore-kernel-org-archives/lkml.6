Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F98C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 06:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFA420652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 06:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FFA420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbeJNNwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 09:52:49 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:35129 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbeJNNwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 09:52:49 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w9E6CprV004004;
        Sun, 14 Oct 2018 08:12:51 +0200
Date:   Sun, 14 Oct 2018 08:12:51 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     salil GK <gksalil@gmail.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net
Subject: Re: What is the expected date of release for 4.19
Message-ID: <20181014061251.GB3995@1wt.eu>
Reply-To: linux-kernel@vger.kernel.org
References: <CAPACB-xT8fb4kTn_J0NMSR3bM6h-b_K99QKF5cySsTWqeRFz0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPACB-xT8fb4kTn_J0NMSR3bM6h-b_K99QKF5cySsTWqeRFz0A@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 09:21:23AM +0530, salil GK wrote:
> Hello
> 
>    I would like to know the expected date of release of 4.19 kernel.

What makes you think it should be different from any other version ?
If an -rc8 is needed before it you'll have an -rc8 first, if an -rc9
is needed, you'll also have an -rc9, etc... kernels are released once
they're good enough.

Willy
