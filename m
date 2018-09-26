Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F757C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BCC2152C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BCC2152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeI0CNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:13:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36706 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeI0CNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:13:55 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 90DCA10BE;
        Wed, 26 Sep 2018 19:59:19 +0000 (UTC)
Date:   Wed, 26 Sep 2018 21:59:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
Subject: Re: Linux 4.19-rc5: Missing iommu fix
Message-ID: <20180926195917.GB20689@kroah.com>
References: <CA+icZUUdxjVe4p-9aui0cqj_EiHD3O2VZ=dW8HqWf-+9jqnWCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUUdxjVe4p-9aui0cqj_EiHD3O2VZ=dW8HqWf-+9jqnWCA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 11:33:39AM +0200, Sedat Dilek wrote:
> Hi Greg,
> 
> thanks and congrats for this release.
> 
> Me and several other people have an issue with "intel_iommu=on" (see
> [1]) and a patch is pending in [2].
> Unfortunately, it is not in linux-iommu Git.
> Hope this will soon happen.
> 
> Just want to inform you and let people know if they have a similiar problem.

Is this all now merged properly?

thanks,

greg k-h
