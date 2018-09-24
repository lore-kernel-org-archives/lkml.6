Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73D1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E2020C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E2020C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeIXOHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:07:39 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:48210 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeIXOHi (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 24 Sep 2018 10:07:38 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Mon, 24 Sep 2018 10:06:45 +0200
Received: from suse.de ([10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Mon, 24 Sep 2018 09:06:17 +0100
Date:   Mon, 24 Sep 2018 12:06:20 +0200
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     Will Deacon <will.deacon@arm.com>
Cc:     marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robert.richter@cavium.com,
        cwu@amperecomputing.com
Subject: Re: [PATCH RESEND 0/6] arm64: add support for generic cpu
 vulnerabilities
Message-ID: <20180924100620.GA19083@suse.de>
References: <20180827143310.641-1-ykaukab@suse.de>
 <20180905092533.GB17376@suse.de>
 <20180917133508.GE23040@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180917133508.GE23040@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 02:35:08PM +0100, Will Deacon wrote:
> On Wed, Sep 05, 2018 at 11:25:33AM +0200, Mian Yousaf Kaukab wrote:
> > On Mon, Aug 27, 2018 at 04:33:04PM +0200, Mian Yousaf Kaukab wrote:
> > > GENERIC_CPU_VULNERABILITIES provide a common way to figure out if a
> > > system is affected by vulnerabilities like meltdown and other variants
> > > of spectre. This small series adds support for it in arm64.
> > 
> > Marc, Will, Can you please review this series?
> 
> Sorry it took so long to get to this, it's just consistently failed to
> get to the top of my review queue. I had a quick look just now and there
> are a few things to address before we can take the series.
Thank you for the review. I will get back to you after fixing the comments as soon as possible.

> 
> Cheers,
> 
> Will

Thanks,
Yousaf
