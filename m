Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03880C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C873E218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfBKMtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:49:42 -0500
Received: from smtprelay0241.hostedemail.com ([216.40.44.241]:53986 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727106AbfBKMtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:49:42 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 03D3618224D6B;
        Mon, 11 Feb 2019 12:49:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crow04_37505634ccf17
X-Filterd-Recvd-Size: 1566
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 Feb 2019 12:49:39 +0000 (UTC)
Message-ID: <1f528cba2af00a69ddfd2de163bad69f381e264b.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Add test for SPDX-License-Identifier on
 wrong line #
From:   Joe Perches <joe@perches.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Feb 2019 04:49:38 -0800
In-Reply-To: <e64adaf7-d7e2-76b7-cfe3-0cbb5c32c79d@metux.net>
References: <1549588593-4856-1-git-send-email-lkml@metux.net>
         <CACRpkdaSEZMR7LuLbO1V0k9QEBu4FWxFbq4ZL1pE9dAvNT1z_Q@mail.gmail.com>
         <dfd0101f4a596600e2f0f8cf36886cf01c7dcb67.camel@perches.com>
         <9b74ee87f8c1b8fd310e213fcb4994d58610fcb6.camel@perches.com>
         <e64adaf7-d7e2-76b7-cfe3-0cbb5c32c79d@metux.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-11 at 13:41 +0100, Enrico Weigelt, metux IT consult
wrote:
> On 08.02.19 21:44, Joe Perches wrote:
> > Warn when any SPDX-License-Identifier: tag is not created
> > on the proper line number.
> 
> By the way: there are corner cases, which can't have it at the first
> line, eg. scripts.

Which I believe the patch and script handles.

Please provide a sample if the script does not
operate properly.

