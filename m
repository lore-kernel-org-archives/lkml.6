Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74509C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C45120578
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbeLPTRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 14:17:38 -0500
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:46447 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730334AbeLPTRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 14:17:37 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E2EE71272;
        Sun, 16 Dec 2018 19:17:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: gate88_7c86f0f338942
X-Filterd-Recvd-Size: 1278
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sun, 16 Dec 2018 19:17:35 +0000 (UTC)
Message-ID: <c7865616af2eab80f5e5a4cf756ba430f2293499.camel@perches.com>
Subject: Re: [RFC] LKML Archive in Maildir Format
From:   Joe Perches <joe@perches.com>
To:     Joey Pabalinas <joeypabalinas@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     kernelnewbies@kernelnewbies.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Sun, 16 Dec 2018 11:17:34 -0800
In-Reply-To: <20181216190639.6safwjqwdphkce67@gmail.com>
References: <20181216190639.6safwjqwdphkce67@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-12-16 at 09:06 -1000, Joey Pabalinas wrote:
> I spent a lot of time trying to find an LKML archive in Maildir format
> that I could use for local searches with nutmuch or something, but all
> the links I was able to find were all dead.

You might instead use

https://www.kernel.org/lore.html
https://git.kernel.org/pub/scm/public-inbox/vger.kernel.org/git.git/


