Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280B2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D826C2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D826C2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeJJXQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:16:07 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:37080 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbeJJXQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:16:07 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w9AFr9cD005751;
        Wed, 10 Oct 2018 16:53:09 +0100
Date:   Wed, 10 Oct 2018 16:53:08 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [PATCH 2/2] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
Message-ID: <20181010165308.187aae51@alans-desktop>
In-Reply-To: <20181008172303.4f06cd94@coco.lan>
References: <1538861738.4088.5.camel@HansenPartnership.com>
        <1538861851.4088.7.camel@HansenPartnership.com>
        <20181008172303.4f06cd94@coco.lan>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -Maintainers have the right and responsibility to remove, edit, or reject
> +Maintainers may remove, edit, or reject
>  comments, commits, code, wiki edits, issues, and other contributions that are
>  not aligned to this Code of Conduct, or to ban temporarily or permanently any
>  contributor for other behaviors that they deem inappropriate, threatening,
> 
> The previous text seems too much legal for my taste.
> 

That is just as confusing. Maintainers have the right to remove, edit,
reject commits that *are* aligned with the code as well. So what exactly
is the point here ?

Alan
