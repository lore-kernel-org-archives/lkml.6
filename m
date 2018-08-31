Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4A2C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8382920839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8382920839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeHaEqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 00:46:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53256 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeHaEqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 00:46:33 -0400
Received: from localhost (unknown [72.28.92.217])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 92614EC7;
        Fri, 31 Aug 2018 00:41:46 +0000 (UTC)
Date:   Thu, 30 Aug 2018 17:41:44 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] staging: android: ion: check for kref overflow
Message-ID: <20180831004144.GC20664@kroah.com>
References: <20180830230946.228701-1-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830230946.228701-1-drosen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 04:09:46PM -0700, Daniel Rosenberg wrote:
> This patch is against 4.9. It does not apply to master due to a large
> rework of ion in 4.12 which removed the affected functions altogther.
> 4c23cbff073f3b9b ("staging: android: ion: Remove import interface")
> 
> Userspace can cause the kref to handles to increment
> arbitrarily high. Ensure it does not overflow.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I signed off on this?  Where?  When?  Are you sure?

greg k-h
