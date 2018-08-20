Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287E2C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AB521531
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AB521531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeHTUex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:34:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52124 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeHTUex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:34:53 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C6DD389C;
        Mon, 20 Aug 2018 17:18:23 +0000 (UTC)
Date:   Mon, 20 Aug 2018 19:18:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     He Zhe <zhe.he@windriver.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, pombredanne@nexb.com, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86: corruption-check: Passing
 memory_corruption_check to command line causes panic
Message-ID: <20180820171821.GB18965@kroah.com>
References: <1534260823-87917-1-git-send-email-zhe.he@windriver.com>
 <129aaffb-7f8d-cf84-cf2d-8e95e303908a@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <129aaffb-7f8d-cf84-cf2d-8e95e303908a@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 04:56:22PM +0800, He Zhe wrote:
> Could you please provide your input? Thanks.

It is the middle of the merge window, we can not do anything with new
patches.  This is a trivial cleanup fix, nothing that is really
important at the moment it will be reviewed in time, please give us a
chance.

thanks,

greg k-h
