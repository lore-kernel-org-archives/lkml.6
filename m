Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62890C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE7C214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE7C214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeIZUGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:06:51 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:37738 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeIZUGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:06:51 -0400
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 4B0642213;
        Wed, 26 Sep 2018 13:53:47 +0000 (UTC)
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id 69DE966;
        Wed, 26 Sep 2018 13:53:46 +0000 (UTC)
Received: from hpe.com (ben.americas.hpqcorp.net [10.33.153.7])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id C079B56;
        Wed, 26 Sep 2018 13:53:45 +0000 (UTC)
Date:   Wed, 26 Sep 2018 08:53:45 -0500
From:   Russ Anderson <rja@hpe.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     Justin Ernst <justin.ernst@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "russ.anderson@hpe.com" <russ.anderson@hpe.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Raise maximum number of memory controllers
Message-ID: <20180926135345.rtp2mxm74xe2jvts@hpe.com>
Reply-To: Russ Anderson <rja@hpe.com>
References: <20180925143449.284634-1-justin.ernst@hpe.com>
 <E6AF1AFDEA62A94A97508F458CBDD47F6F70517B@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E6AF1AFDEA62A94A97508F458CBDD47F6F70517B@SHSMSX101.ccr.corp.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 07:55:39AM +0000, Zhuo, Qiuxu wrote:
> Hi Justin,
> 
> > [ 3401.987556] EDAC MC15: Giving out device to module skx_edac controller Skylake Socket#1 IMC#1
>     Just curious, has the system(two memory controllers per socket) got more than 8 sockets?
>     Normally, the number "1" in the above string "Skylake Socekt#1 IMC#1" should be 7 (that was 15/2), but it was 1 here.

Yes, that is from a 32 socket system.

Thanks.
-- 
Russ Anderson,  SuperDome Flex Linux Kernel Group Manager
HPE - Hewlett Packard Enterprise (formerly SGI)  rja@hpe.com
