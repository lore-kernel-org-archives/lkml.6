Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B81ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE282089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE282089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbeGOMYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 08:24:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38368 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbeGOMYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 08:24:33 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 693E3BC8;
        Sun, 15 Jul 2018 12:01:49 +0000 (UTC)
Date:   Sun, 15 Jul 2018 14:01:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Subject: Re: [PATCH v7 00/29] FPGA Device Feature List (DFL) Device Drivers
Message-ID: <20180715120130.GA20467@kroah.com>
References: <1530320016-24712-1-git-send-email-hao.wu@intel.com>
 <CANk1AXQ0crNX2u_=XLEakhhfO8dcTED0OO6fHU10uAx0yOJewg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXQ0crNX2u_=XLEakhhfO8dcTED0OO6fHU10uAx0yOJewg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 11:34:20AM -0500, Alan Tull wrote:
> On Fri, Jun 29, 2018 at 7:53 PM, Wu Hao <hao.wu@intel.com> wrote:
> > Hi All,
> >
> > Here is v7 patch-series adding drivers for FPGA DFL devices.
> 
> Hi Greg,
> 
> Could you please take this v7 patchset for 4.19?

All now queued up, thanks.

greg k-h
