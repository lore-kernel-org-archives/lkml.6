Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1277C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1B320839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1B320839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeIKTQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:16:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44756 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKTQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:16:05 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F2E5B111B;
        Tue, 11 Sep 2018 14:16:32 +0000 (UTC)
Date:   Tue, 11 Sep 2018 16:16:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georg =?iso-8859-1?Q?M=FCller?= <georgmueller@gmx.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Missing mei patches
Message-ID: <20180911141630.GA19866@kroah.com>
References: <07e1f3a3-3f8d-27f2-440e-e07c64557df0@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07e1f3a3-3f8d-27f2-440e-e07c64557df0@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 04:11:15PM +0200, Georg Müller wrote:
> Is there a chance of getting the two mei patches into 4.19 and 4.18.y?
> 
> https://www.spinics.net/lists/stable/msg253484.html
> https://www.spinics.net/lists/stable/msg253485.html
> 
> Bugzilla entries:
> https://bugzilla.kernel.org/show_bug.cgi?id=200455
> https://bugzilla.redhat.com/show_bug.cgi?id=1597481
> 
> Even if maybe only a couple of systems are affected, this is causing a dead system on second suspend which could cause data loss.
> 
> Maybe the patches were not merged because of a typo in the subject (4.9 instead of 4.19)?

Heh, no, they are still in my "to apply" queue for 4.19-final, please
give me a week or so to catch up on things...

greg k-h
