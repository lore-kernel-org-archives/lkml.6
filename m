Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C43C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238FA2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549936169;
	bh=SwxswY0huzdmqaRhJMozLsNdQMsqZNOZ4/9NMa7F+1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZPuMX12m5wQS9CRPIbVehr476KhN2CIoLb65HZq8SSY6NYjCJlV3Xrp/zKIDOtf1Q
	 PgURCR4VcWpdc84VouZYvz24YpkrnVpidjwoVkgl0R+ukdqMm9mycDD4A7U8loq2NQ
	 eVZY23H0dXet6S9RFLo82mE0z+s8GD7t4g8fEyac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfBLBt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:49:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfBLBt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:49:27 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88A152080A;
        Tue, 12 Feb 2019 01:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549936166;
        bh=SwxswY0huzdmqaRhJMozLsNdQMsqZNOZ4/9NMa7F+1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jDyJV/DkbgUAAUr6o2vOprcNwEUt4IdTopJzQFWVInJHDan42BhVVmUPEB2jgf/8J
         YWrsJhs3Qa30oMeMIH+Dgmi4e9f1xiBVM32aCRxMNtBnsTd22vbN62DhHyZCvRzY31
         7F6ZOdmush62eJJnlUs3Fd9Bq2X+5uZN2LN0vOpE=
Date:   Tue, 12 Feb 2019 09:49:19 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <ren_guo@c-sky.com>
Subject: Re: [GIT PULL] csky fixes for v5.0-rc6
Message-ID: <20190212014919.GA7332@guoren-Inspiron-7460>
References: <1549861699-11875-1-git-send-email-guoren@kernel.org>
 <CAHk-=wh9kycrBtNOUN1-aOR_JL4scBgs=6NUkGQonfWFyzhvVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh9kycrBtNOUN1-aOR_JL4scBgs=6NUkGQonfWFyzhvVw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:28:26AM -0800, Linus Torvalds wrote:
> On Sun, Feb 10, 2019 at 9:08 PM <guoren@kernel.org> wrote:
> >
> > arch/csky patches for 5.0-rc6
> 
> The bulk of this seems to be new hardware support code.
> 
> Please send it during the 5.1 merge window, not as fixes at post-rc6 time.
Ok, I'll remove:
      irqchip/csky: Support csky,dh7k SOC intc driver
      dt-bindings: csky,apb-intc: Add dh7k SOC support

Best Regards
 Guo Ren
