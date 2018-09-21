Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BB6ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A19220877
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A19220877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391282AbeIVAiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:38:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50960 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391160AbeIVAiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:38:21 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 044DA1176;
        Fri, 21 Sep 2018 18:48:10 +0000 (UTC)
Date:   Fri, 21 Sep 2018 20:48:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [GIT PULL] pin control fixes for v4.19
Message-ID: <20180921184808.GA12430@kroah.com>
References: <CACRpkdaTsM-VV7ck1E8Q_Fv+9NSQ7a8mQp_WAyBMvZjGkrYeLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaTsM-VV7ck1E8Q_Fv+9NSQ7a8mQp_WAyBMvZjGkrYeLg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 10:03:09AM -0700, Linus Walleij wrote:
> Hi Greg,
> 
> here are some two fixes for pin contol for v4.19.
> 
> Please pull them in for the current HEAD.
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:
> 
>   Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
> tags/pinctrl-v4.19-3

Now pulled, thanks.

greg k-h
