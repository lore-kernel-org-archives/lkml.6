Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82149C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3891820861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3891820861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeIMK6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 06:58:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37688 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbeIMK6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 06:58:47 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 11DFABE1;
        Thu, 13 Sep 2018 05:50:49 +0000 (UTC)
Date:   Thu, 13 Sep 2018 07:50:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Clarify UIO vs UACCESS maintainer
Message-ID: <20180913055047.GA6976@kroah.com>
References: <153681530631.454480.6512525122403854324.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153681530631.454480.6512525122403854324.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:09:28PM -0700, Dan Williams wrote:
> The UIO file mask in MAINTAINERS was incorrectly directing UACCESS
> (include/linux/uio.h) patches to Greg.
> 
> Tag Al as the UACCESS maintainer as Ingo and others have explicitly
> required his ack before taking architecture patches that touch
> lib/iov_iter.c.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Al, let me know if this is ok. Alternatively we could just fix the file
> mask for UIO and not add a new UACCESS section.

Thanks for doing this!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

