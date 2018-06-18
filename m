Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA35C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5801E2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5801E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936947AbeFRUmd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:42:33 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:58046 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936907AbeFRUmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:42:32 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fV0ys-0003Hk-No; Mon, 18 Jun 2018 22:42:30 +0200
Message-ID: <1529354549.3092.36.camel@sipsolutions.net>
Subject: Re: [PATCH v3] bitfield: fix *_encode_bits()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 18 Jun 2018 22:42:29 +0200
In-Reply-To: <CAHp75VesXgrh-XR-3bFMOF6eE0K=NyRvyY1tw1yOX44rJS9fag@mail.gmail.com> (sfid-20180618_224029_738852_AF216451)
References: <20180618195618.17536-1-johannes@sipsolutions.net>
         <CAHp75VdY+PF0Edm_py+UiD3nz77HTQps_8uaRh+Sa3C+UKECKA@mail.gmail.com>
         <1529353683.3092.32.camel@sipsolutions.net>
         <CAHp75VesXgrh-XR-3bFMOF6eE0K=NyRvyY1tw1yOX44rJS9fag@mail.gmail.com>
         (sfid-20180618_224029_738852_AF216451)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-18 at 23:40 +0300, Andy Shevchenko wrote:

> The idea is to print what was the input, expected output and actual result.
> Then you would see what exactly is broken.

Yeah, I guess we could. I did some of that work.

> I dunno how much we may take away from this certain test case, though
> it would be better for my opinion.

TBH though, I'm not sure I want to do this (right now at least). I don't
think we gain anything from it, it's so basic ... so to me it's just
pointless extra code.

johannes
