Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455CDC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 07:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00780223E6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 07:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00780223E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeHKJtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 05:49:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58844 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbeHKJtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 05:49:09 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C0420BBF;
        Sat, 11 Aug 2018 07:15:54 +0000 (UTC)
Date:   Sat, 11 Aug 2018 09:15:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sodagudi Prasad <psodagud@codeaurora.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        andreyknvl@google.com, keescook@chromium.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: KASAN errors from unwind_frame
Message-ID: <20180811071551.GA25283@kroah.com>
References: <e296f7e70a0d0e61c94337bf334e80c2@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e296f7e70a0d0e61c94337bf334e80c2@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 07:29:30PM -0700, Sodagudi Prasad wrote:
> Hi All,
> 
> I have observed following KASAN error with 4.14.56 kernel.
> Can you please copy change-[1](kasan: add no_sanitize attribute for clang
> builds) into stable kernels?

Applied to 4.14 and 4.9 now, thanks.

greg k-h
