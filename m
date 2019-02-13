Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49831C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28527218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436569AbfBMUGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:06:40 -0500
Received: from namei.org ([65.99.196.166]:52048 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbfBMUGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:06:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x1DK6bcb002548;
        Wed, 13 Feb 2019 20:06:37 GMT
Date:   Thu, 14 Feb 2019 07:06:37 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.1
In-Reply-To: <20190213084921.GA8208@linux.intel.com>
Message-ID: <alpine.LRH.2.21.1902140706180.1992@namei.org>
References: <20190213084921.GA8208@linux.intel.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019, Jarkko Sakkinen wrote:

> James,
> 
> Quite a fat release this time. I'll try to enumerate the highlights.

Thanks!

Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tpm


-- 
James Morris
<jmorris@namei.org>

