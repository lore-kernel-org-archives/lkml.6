Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C9DECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A13621526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMwOCUJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A13621526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeJQTgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbeJQTgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:36:14 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A07C2086E;
        Wed, 17 Oct 2018 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539776456;
        bh=BvOara2MLzbKp4M6ViTZcKqQFC0sLrkQKRjojuJjCSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qMwOCUJj943PPLX60IBkyWli7KQ0WzX5UGKbBqaAVoUEALnCu3RpiwCvC67GQ+f4V
         lgcoYvVVNSWhTMZOq72ucq+L0KfT1j4j+yfTZLxZ+xn/QR7HE8SRA7KzB6fRvQbrPe
         FMkRdqSivq8vrKZ3/I/6Qphk4pQZ0kRtrsZUYbeI=
Date:   Wed, 17 Oct 2018 13:40:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     sboyd@kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] clk fixes for v4.19-rc8
Message-ID: <20181017114053.GA29265@kroah.com>
References: <20181016210202.117594-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016210202.117594-1-sboyd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 02:02:02PM -0700, sboyd@kernel.org wrote:
> From: Stephen Boyd <sboyd@kernel.org>
> 
> The following changes since commit bded6c03e398dc6e862dc8301fb9a60175740653:
> 
>   clk: x86: Set default parent to 48Mhz (2018-08-30 14:47:41 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-fixes-for-linus

Now merged, thanks.

greg k-h
