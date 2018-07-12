Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186E2ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A212124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A212124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=online.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbeGLUrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:47:55 -0400
Received: from mout02.posteo.de ([185.67.36.142]:36233 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeGLUrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:47:55 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jul 2018 16:47:54 EDT
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id A9E1C20E79
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 22:29:40 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 41RSDy2J1KzyZZ;
        Thu, 12 Jul 2018 22:28:18 +0200 (CEST)
Date:   Thu, 12 Jul 2018 22:28:18 +0200
From:   Felix Siegel <felix.siegel@online.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felix Siegel <felix.siegel@posteo.de>, devel@driverdev.osuosl.org,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] staging: gasket: add SPDX-License-Identifier tag
Message-Id: <20180712222818.28784f4535a1a7b62bcdec0d@online.de>
In-Reply-To: <20180712194249.GA5492@kroah.com>
References: <1531423694-22478-1-git-send-email-felix.siegel@posteo.de>
        <20180712194249.GA5492@kroah.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 21:42:49 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Jul 12, 2018 at 09:27:12PM +0200, Felix Siegel wrote:
> > Use GPL-2.0 based on the license text in each of the files.
> > Remove license "boiler-plate".
> > 
> > Signed-off-by: Felix Siegel <felix.siegel@posteo.de>
> 
> I sent this same patch 1 1/2 days ago :)
> 
> sorry,
> 
> greg k-h

My bad, I should have checked before sending it.

Regards,
Felix

