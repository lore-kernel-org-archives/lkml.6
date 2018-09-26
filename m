Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E18C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3D220843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3D220843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIZUZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:25:44 -0400
Received: from mail.windriver.com ([147.11.1.11]:38831 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbeIZUZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:25:43 -0400
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w8QEBl2I019311
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 26 Sep 2018 07:11:54 -0700 (PDT)
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.408.0; Wed, 26 Sep 2018 07:11:48 -0700
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 1BACB2E0684; Wed, 26 Sep 2018 10:11:48 -0400 (EDT)
Date:   Wed, 26 Sep 2018 10:11:48 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <peter@piie.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [PATCH 0/6] platform/x86: acerhdf: new BIOS string, better
 modparam handling
Message-ID: <20180926141147.GD3277@windriver.com>
References: <20180921014421.30804-1-paul.gortmaker@windriver.com>
 <f401b6fed813afb86f5442c7707bf9fb@piie.net>
 <CAHp75Vd3L2BQX02NQVM=ZTMkv4WpM=AXXVMyG0Cyc0SjjUU55g@mail.gmail.com>
 <CAHp75VecQvirM=XXFCHQ7qn_hh+ix2u2HFq9u+JOOzcmjeRrdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75VecQvirM=XXFCHQ7qn_hh+ix2u2HFq9u+JOOzcmjeRrdQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 0/6] platform/x86: acerhdf: new BIOS string, better modparam handling] On 26/09/2018 (Wed 14:13) Andy Shevchenko wrote:

> On Wed, Sep 26, 2018 at 2:09 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

[...]

> 
> Anyway, all suggested changes look good to me, I go ahead and push
> them to my review and testing queue.
> If nothing happens during let's say a week, I will move them forward.

Sounds good to me -- thanks!

P.
