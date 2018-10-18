Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0283FECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB9A2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9yKOegl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB9A2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeJRPcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:32:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbeJRPcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:32:47 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7A712098A;
        Thu, 18 Oct 2018 07:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539847987;
        bh=PJsVa+78zFZKew2d40ucMlpp+wPtjrFwus7ohX10RNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R9yKOeglE28vt/mSrPhIQGaLV03K+h0RUwHVnybahreA3ImYcuhmfYWZ2509DX/fS
         ItlUCItFlLvWhLPDcAyh2DzCQXpap4s0E5b/ZWyAUoF1oHkIlUqt3Qau/RtuxHeYni
         Jms0lJnt+mTxygABNf/4sD5csmfvTYlBiBiix+/U=
Date:   Thu, 18 Oct 2018 09:33:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] [GIT PULL] tracing: Two fixes for 4.19
Message-ID: <20181018073304.GA4356@kroah.com>
References: <20181017194939.044060850@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017194939.044060850@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 03:49:39PM -0400, Steven Rostedt wrote:
> 
> Linus (aka Greg),
> 
> This fixes two bugs:
> 
>  - Fix size mismatch of tracepoint array
> 
>  - Have preemptirq test module use same clock source of the selftest

Now pulled, thanks.

greg k-h
