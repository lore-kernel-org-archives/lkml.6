Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6858C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABCD20878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABCD20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeG1QSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 12:18:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33888 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbeG1QSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 12:18:33 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 463B1C77;
        Sat, 28 Jul 2018 14:51:47 +0000 (UTC)
Date:   Sat, 28 Jul 2018 16:51:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tty: Address checkpatch warnings in goldfish.c
Message-ID: <20180728145143.GB12252@kroah.com>
References: <20180725005133.107823-1-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725005133.107823-1-rkir@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 05:51:31PM -0700, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> checkpatch.pl complained about missing blank lines
> (between variable definitions and executable code)
> and using just "unsigned" instead of "unsigned int".

That is two different things, please make two different patches.

thanks,

greg k-h
