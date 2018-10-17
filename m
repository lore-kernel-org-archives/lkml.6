Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E990ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13A521528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13A521528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeJRALb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:11:31 -0400
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:58592 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727191AbeJRALb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:11:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E4CE7182CF666;
        Wed, 17 Oct 2018 16:15:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: form98_83a0b97e55d19
X-Filterd-Recvd-Size: 1456
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed, 17 Oct 2018 16:15:04 +0000 (UTC)
Message-ID: <dbffbc4990dc123a8a6cca2c0f2d20ae69557238.camel@perches.com>
Subject: Re: Bad MAINTAINERS pattern in section 'USER-MODE LINUX (UML)'
From:   Joe Perches <joe@perches.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org
Date:   Wed, 17 Oct 2018 09:15:03 -0700
In-Reply-To: <CAFLxGvyevwwDbxFy_PAiwHh5Dh5znS-=3baoVKe9rPTGU1oCEw@mail.gmail.com>
References: <20180928220507.31886-1-joe@perches.com>
         <CAFLxGvyevwwDbxFy_PAiwHh5Dh5znS-=3baoVKe9rPTGU1oCEw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Joe,

Hi Richard.

> On Sat, Sep 29, 2018 at 12:06 AM Joe Perches <joe@perches.com> wrote:
> > Please fix this defect appropriately.
> 
> Care to send a patch?

Not really.

Because you are listed as the maintainer, you should
be the person that fixes it as you are nominally and
actually responsible for introducing this defect.

You have a tree that gets pulled, I do not.

It'd probably take you less time to just do the
removal than asking me to send a patch did.


