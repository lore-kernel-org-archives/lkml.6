Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AC7C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CA6208F7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CA6208F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=credativ.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeHXSig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:38:36 -0400
Received: from gauss.credativ.com ([93.94.130.89]:44078 "EHLO
        gauss.credativ.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeHXSig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:38:36 -0400
Received: from gauss.credativ.com (localhost [127.0.0.1])
        by gauss.credativ.com (Postfix) with ESMTP id B2A3A1E30FD;
        Fri, 24 Aug 2018 17:03:32 +0200 (CEST)
Received: from forel.credativ.com (forel.credativ.com [93.94.130.85])
        (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gauss.credativ.com (Postfix) with ESMTPS id A24A81E3069;
        Fri, 24 Aug 2018 17:03:32 +0200 (CEST)
Received: from null (localhost [127.0.0.1])
        by forel.credativ.com (Postfix) with ESMTPS id 41xl0N4NB0zpK;
        Fri, 24 Aug 2018 17:03:32 +0200 (CEST)
Date:   Fri, 24 Aug 2018 17:03:32 +0200 (CEST)
From:   Sedat Dilek <sedat.dilek@credativ.de>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Message-ID: <349625264.549.1535123012532@ox.credativ.com>
In-Reply-To: <20180824150119.y7ikykvq37a6brbj@ninjato>
References: <20180819135135.8801-1-sedat.dilek@credativ.de>
 <20180824130130.bialyhjarwkwodzw@ninjato>
 <1335058904.531.1535118581478@ox.credativ.com>
 <20180824140705.t3pkiqfpnqzaaksz@ninjato>
 <1600966696.540.1535120394100@ox.credativ.com>
 <20180824150119.y7ikykvq37a6brbj@ninjato>
Subject: Re: [PATCH v2] i2c: Remove '-Wno-deprecated-declarations' compiler
 warning
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-IP: 2003:5b:203b:100:56e1:adff:fea0:6ba0
X-Originating-Client: open-xchange-appsuite
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Wolfram Sang <wsa@the-dreams.de> hat am 24. August 2018 um 17:01 geschrieben:
> 
> 
> On Fri, Aug 24, 2018 at 04:19:53PM +0200, Sedat Dilek wrote:
> > > Wolfram Sang <wsa@the-dreams.de> hat am 24. August 2018 um 16:07 geschrieben:
> > > 
> > > 
> > > 
> > > > will my patch go to [1]?
> > > 
> > > It won't be needed anymore, the __deprecated function will go away until
> > > next week.
> > >
> > 
> > The relict in drivers/i2/Makefile should go away, too.
> 
> Correct. I will apply your patch, just with an shoertened commit message
> (because the use case is gone) if this is OK with you.

OK, Thanks.
