Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C75C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E780221A4C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbfBOR74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:59:56 -0500
Received: from ale.deltatee.com ([207.54.116.67]:47386 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730324AbfBOR7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:59:55 -0500
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.205])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1guhmC-0000Vz-BC; Fri, 15 Feb 2019 10:59:53 -0700
To:     "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>
Cc:     "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1550222224-26475-1-git-send-email-Sanju.Mehta@amd.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <83d5071f-cbf6-b382-8ebe-5184af044bb8@deltatee.com>
Date:   Fri, 15 Feb 2019 10:59:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550222224-26475-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, Shyam-sundar.S-k@amd.com, Sanju.Mehta@amd.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 0/4] bug fixes in ntb_hw_amd and ntb_perf
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-02-15 2:17 a.m., Mehta, Sanju wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> Add bug fix for ntb_perf and ntb_hw_amd
> 
> Sanjay R Mehta (4):
>   NTB: ntb_perf: Increased the number of message retries to 1000
>   NTB: ntb_perf: Disable NTB link after clearing peer XLAT registers
>   NTB: ntb_perf: Clear stale values in doorbell and command SPAD
>     register
>   NTB: ntb_hw_amd: set peer limit register
> 
>  drivers/ntb/hw/amd/ntb_hw_amd.c |  8 ++++----
>  drivers/ntb/test/ntb_perf.c     | 14 +++++++++++---
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 


Looks fine to me. Thanks.

For all the ntb_perf changes:

Acked-by: Logan Gunthorpe <logang@deltatee.com>

Logan
