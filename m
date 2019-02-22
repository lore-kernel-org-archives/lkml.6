Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEA4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEB52086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="JflAuq+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfBVJnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:43:22 -0500
Received: from ozlabs.org ([203.11.71.1]:42351 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfBVJnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:43:21 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 445RGv0NRfz9sBF; Fri, 22 Feb 2019 20:43:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1550828599; bh=1IrIxLEzMatc1BhQV23HaHeNgTi9r2eI+hYlJcZZi90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JflAuq+6J8yaJ9Y16qG/B3medErolHLIYZI2JzAkDKCCPZtOtGv5LA5ExnEo3kMXb
         R3EiS4gu6jXTxuS3EczXpp3IJJx6k4sPbAGl2v0Ycu/a8dMeul/tmccG/2iqslSPzT
         Vdj/MFHecvwHXtdsSuSVI15PlKTjwBh4LhdmabR+NltVlbEy4Zq2GmsZ2HDkW3K5bk
         KWjx/+kMfcjBZZ+N0Iltl4MV5ORVtV1pMgq8yUTujI3xsQLLFu2ksHWcl5L+eJw9kk
         OaFsrx13jec4nLdAPJ49EWZk4/19p6gPWxk5ln1r0u5JvRDADI2RATrnZ3qeD4g3Ao
         GrW6We21LCEGA==
Date:   Fri, 22 Feb 2019 20:38:19 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     wangbo <wdjjwb@163.com>
Cc:     linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        wang.bo116@zte.com.cn
Subject: Re: [PATCH] KVM: PPC: Book3S: Replace kmalloc_node+memset with
 kzalloc_node
Message-ID: <20190222093819.GA6006@blackberry>
References: <1546863352-23593-1-git-send-email-wdjjwb@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546863352-23593-1-git-send-email-wdjjwb@163.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 08:15:52PM +0800, wangbo wrote:
> Replace kmalloc_node and memset with kzalloc_node
> 
> Signed-off-by: wangbo <wang.bo116@zte.com.cn>

Thanks, applied to my kvm-ppc-next tree.

Paul.
