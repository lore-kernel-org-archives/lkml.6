Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852B3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4164025C1A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4164025C1A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030197AbeGBKYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:24:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53232 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965314AbeGBKYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:24:17 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A587B2D;
        Mon,  2 Jul 2018 10:24:16 +0000 (UTC)
Date:   Mon, 2 Jul 2018 12:24:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.9 000/101] 4.9.111-stable review
Message-ID: <20180702102413.GB16825@kroah.com>
References: <20180701160757.138608453@linuxfoundation.org>
 <CAMuHMdVcSkXAmuD2qsc0mk9pDx_Fd0Q_peBmZY6Mpfkq6gMQZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVcSkXAmuD2qsc0mk9pDx_Fd0Q_peBmZY6Mpfkq6gMQZg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 11:57:36AM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Sun, Jul 1, 2018 at 6:26 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 4.9.111 release.
> > There are 101 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> Thank you for your hard work on -stable!
> 
> > Pseudo-Shortlog of commits:
> 
> Given you do publish a git tree with these changes, is there any specific reason
> you're not using a real shortlog? Sorting and grouping would make it
> easier to see
> which patches of mine you have backported.

Many years ago Linus wanted it in this type of format as it was easier
to see what was being applied to the trees.  Given that it is a git
tree, you can see the shortlog yourself, and you are cc:ed on any of
your own patches directly, right?

thanks,

greg k-h
