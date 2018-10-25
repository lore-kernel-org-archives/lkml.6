Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30A5ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC1620831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC1620831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeJYIxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:53:55 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:33535 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726117AbeJYIxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:53:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 3AC5E181D340F;
        Thu, 25 Oct 2018 00:23:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hand46_2723afd4c220
X-Filterd-Recvd-Size: 1967
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Oct 2018 00:23:36 +0000 (UTC)
Message-ID: <825268591809f66eb475c3b41c327809a304388f.camel@perches.com>
Subject: Re: [PATCH] Change judgment len position
From:   Joe Perches <joe@perches.com>
To:     David Miller <davem@davemloft.net>
Cc:     w@1wt.eu, wanghaifine@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, fengguang.wu@intel.com, lkp@01.org
Date:   Wed, 24 Oct 2018 17:23:35 -0700
In-Reply-To: <20181024.170213.632063387857625082.davem@davemloft.net>
References: <61d94f2a5563db4d6580c8385c3b93c8eeb3669a.camel@perches.com>
         <20181024204852.GA25509@1wt.eu>
         <49ec92564284b5beb0a151bce1d537b51340d0a8.camel@perches.com>
         <20181024.170213.632063387857625082.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-24 at 17:02 -0700, David Miller wrote:
> From: Joe Perches <joe@perches.com>
> Date: Wed, 24 Oct 2018 16:46:18 -0700
> 
> > I would have suggested David reply with only his second sentence
> > and maybe a pointer to kernelnewbies or staging.is
> 
> I maintain that I was not out of line with my comment.
> 
> I sought a second opinion from Greg KH and others, and they agree with
> me that I was still kind with my choice of words.

"You can't be serious?" is kind?

> I think you're taking things too far, and I will simply not stand for
> this overreaching judgement upon my behavior on this list which is
> completely not justified.

Even above here, concision is generally better.

overreaching and completely are probably not reasonable.

openness and defensiveness are somewhat antithetic.

From the new Code of Conduct (which I don't even approve)

* Gracefully accepting constructive criticism.

cheers, Joe

