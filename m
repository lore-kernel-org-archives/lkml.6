Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B36C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BF72075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BF72075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936924AbeFRUrF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:47:05 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:58228 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935299AbeFRUrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:47:03 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fV13G-0003Qt-FP; Mon, 18 Jun 2018 22:47:02 +0200
Message-ID: <1529354821.3092.42.camel@sipsolutions.net>
Subject: Re: [PATCH v4 3/3] bitfield: add tests
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 18 Jun 2018 22:47:01 +0200
In-Reply-To: <CAHp75VfeMBr57Frzvm2vJ2irJQat-6a+_dN9mtftAnwfPT=Bww@mail.gmail.com> (sfid-20180618_224449_177090_AC34F0FA)
References: <20180618203750.28658-1-johannes@sipsolutions.net>
         <20180618203750.28658-3-johannes@sipsolutions.net>
         <CAHp75VfeMBr57Frzvm2vJ2irJQat-6a+_dN9mtftAnwfPT=Bww@mail.gmail.com>
         (sfid-20180618_224449_177090_AC34F0FA)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-18 at 23:44 +0300, Andy Shevchenko wrote:
> On Mon, Jun 18, 2018 at 11:37 PM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
> > Add tests for the bitfield helpers. The constant ones will all
> > be folded to nothing by the compiler (if everything is correct
> > in the header file), and the variable ones do some tests against
> > open-coding the necessary shifts.
> > 
> > A few test cases that should fail/warn compilation are provided
> > under ifdef.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Though license mismatch. Either GPL-2.0+ for SPDX, or "GPL v2" for _LICENSE().

Sigh. Yeah, I guess I'll resend. That's what I get for copy/pasting.

johannes
