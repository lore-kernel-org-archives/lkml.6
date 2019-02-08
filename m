Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2529DC4151A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 03:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69952146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 03:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfBHDM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 22:12:59 -0500
Received: from mout.gmx.net ([212.227.17.22]:39305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbfBHDM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 22:12:59 -0500
Received: from homer.simpson.net ([185.221.151.12]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIiHs-1gpkjs0koq-002GV0; Fri, 08
 Feb 2019 04:12:52 +0100
Message-ID: <1549595571.26710.16.camel@gmx.de>
Subject: Re: Kernel panics with recent 4.9 Kernels
From:   Mike Galbraith <efault@gmx.de>
To:     Michael Brunnbauer <brunni@netestate.de>,
        linux-kernel@vger.kernel.org
Date:   Fri, 08 Feb 2019 04:12:51 +0100
In-Reply-To: <1549595398.26710.14.camel@gmx.de>
References: <20190205091239.GA3687@netestate.de>
         <20190207191359.GA14298@netestate.de> <1549595398.26710.14.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:C+/l55Ifjpn+ALPQeiAGLerPO8d73374CC0AzxwK56uw/7GvST6
 xjko7VgEMGsGvPBBXQrUvELbznC1SuLi/hvDrmx3N0mzn8T23+9tLMgcQA4j1tl6pwYYq1P
 3CptXWMJjHUQhh7xx88YCcEK5p4wCMvd4uUxvsdvgZe805Q3dIsshqSLdP8QAjhH5x2hxdE
 F6B0z/WATGLIlZvTDAI1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uIf/xKDobNA=:SiUWWgCcbyQCb6l6YChwi4
 jHIuhX3SymBTdl6kzjsoGC09UvP7v+4drEk5LMtSL1VeXVrYDA+Y9umo2EQuOxUMGQ0cdZPHj
 GraLXvxETrjZ1LW95ZuYfWBnwksfBqQMvC3WCfrCoaIG82ljc44CgTLCL4d+t+5kSzDrFQYsY
 dsJCpx2AK/iRZqK4oUZvFUEO+/V9E/Cm+F/4L8JxVgvGK5BkveIN3ZKO4S6G/Sr+xkxwEkMhu
 L8mpxUhX6tCLa41msYastdNHOBizQ9Jx1v/xfPrGkGPDuKpx8nJWyGrqR0saAdJR0XDjyr5bA
 acHvS3rzLK5XSDEzyEMAGcNmjbsxPY+L+9lYqCfjx2q+6Zpj4ARHrfJEfH03fXWNxBPbD/y6V
 4LpuPbFIF9Mlvxs7ah9GsxvZmHGM4sJlLXsT9d6ZAt8imxfzvZgY/CJkfsb2kqceut9q/0Sk9
 l/PrKXzOmOjk6WN3S0+i0M8uF6rIBWB0+5mCcxA2gzBEaqMbTtqZ52F1bOOofGhTkO/bSmeJq
 XB1VbgCIY2mLR0+0TtX0j7pp4l7qwrpkGHyQHHXSbchYhQEEv0VRf3Xyk8OZNJ9u/4MFS2Z7Z
 F1YTICFOA5+9JUGmbrgwP/u/jg7F0MZMRnIVmQQD5ScgSo8NPzypTb2O2TcYDqLBhLt9Bupjs
 SBe50h6zgRThF8ZP5WbOpNvlG+J0BwRDqkWVW2SM1s9pEaAfLJ7D7MFgNPCfHys49Cd/jPbDE
 KpyZUpzGHGybHYwjt/FN5p04GvjF3I1bD7+XEBjm4oNGIrPnagw7GOB1Ngg9Yypm2Cdnh49yt
 UWTLU/uDngZrvq8wasHUzhHIWpMTwnkl+DW2uDjNbho9rgSOvh8663cIFVxxzC3vYNfzXSRTH
 xqpLA/W+wpxyO3sAo75JLNn4KtZRsWSTNWKGwk3HHNCBdt6dr63QufhnK8E+/K
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-08 at 04:09 +0100, Mike Galbraith wrote:
> On Thu, 2019-02-07 at 20:13 +0100, Michael Brunnbauer wrote:
> > hi,
> > 
> > no replies to my mail. Any suggestions what I should do or where I
> > could ask for help?
> 
> I'd suggest trying to capture events with something better than an
> incomplete screenshot, ie serial console, netconsole, anything that
> will let you show the full event and a few lines leading up to it.

P.S. CONFIG_PRINTK_TIME improves log quality as well.
