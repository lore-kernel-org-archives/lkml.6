Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD2DECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 22:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0612620836
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 22:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0612620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeJVGtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 02:49:06 -0400
Received: from smtprelay0247.hostedemail.com ([216.40.44.247]:59157 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725882AbeJVGtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 02:49:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id F1F4E187A6304;
        Sun, 21 Oct 2018 22:33:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: blade35_1bc6f63cb482a
X-Filterd-Recvd-Size: 1862
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sun, 21 Oct 2018 22:33:10 +0000 (UTC)
Message-ID: <d4e4a2d9d63112a854fd30df19fd16f20face810.camel@perches.com>
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of
 Conduct: Fix some wording, and add an interpretation document
From:   Joe Perches <joe@perches.com>
To:     NeilBrown <neil@brown.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
Date:   Sun, 21 Oct 2018 15:33:09 -0700
In-Reply-To: <87y3ar80ac.fsf@notabene.neil.brown.name>
References: <20181020134908.GA32218@kroah.com>
         <87y3ar80ac.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-22 at 08:20 +1100, NeilBrown wrote:
> On Sat, Oct 20 2018, Greg Kroah-Hartman wrote:
> > As everyone knows by now, we added a new Code of Conduct to the kernel
> > tree a few weeks ago.
> 
> I wanted to stay detached from all this, but as remaining (publicly)
> silent might be seen (publicly) as acquiescing, I hereby declare that:
>    I reject, as illegitimate, this Code and the process by
>    which it is being "developed".
[]
> I call on any other community members who reject this process to say so,
> not to remain silent.

The concept of describing a desire for pleasant interactions
while
developing the linux kernel is legitimate and useful.

I do reject this process as well and I think the attempt to
reform it via a private, non-public method is, at best,
poor form.

Joe Perches

