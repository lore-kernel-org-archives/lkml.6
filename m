Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B59C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEFE20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733248AbfAORbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:31:03 -0500
Received: from ale.deltatee.com ([207.54.116.67]:53104 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730613AbfAORbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:31:03 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gjSY4-0000RU-LA; Tue, 15 Jan 2019 10:30:50 -0700
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Rob Herring <robh@kernel.org>, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190109203911.7887-1-logang@deltatee.com>
 <20190109203911.7887-2-logang@deltatee.com>
 <20190115135819.GK28946@infradead.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c5dee13b-3458-c195-eba9-c968db908a71@deltatee.com>
Date:   Tue, 15 Jan 2019 10:30:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190115135819.GK28946@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dan.j.williams@intel.com, hch@lst.de, linux-riscv@lists.infradead.org, sbates@raithlin.com, linux-kernel@vger.kernel.org, palmer@sifive.com, ysato@users.sourceforge.jp, dalias@libc.org, robh@kernel.org, hch@infradead.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 1/2] sh: mm: make use of new memblocks_present() helper
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-01-15 6:58 a.m., Christoph Hellwig wrote:
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Probably no need to keep this in a series with the RISC-V code, this can
> be queued up by the sh folks independently.

Oh, yeah, sorry, I obviously didn't pay enough attention to this when I
resent it. I sent the similar Arm changes to the appropriate list and,
yes, the sh ones should go to that maintainer.

@Palmer: if you can just look at taking the second patch, I'll resubmit
the first one to the appropriate list.

Thanks,

Logan
