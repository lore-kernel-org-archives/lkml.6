Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D3CC65BBA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B962084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B962084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeJFBWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:22:41 -0400
Received: from namei.org ([65.99.196.166]:35868 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbeJFBWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:22:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w95IMjgX014777;
        Fri, 5 Oct 2018 18:22:45 GMT
Date:   Sat, 6 Oct 2018 04:22:45 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] tpmdd updates for Linux 4.20
In-Reply-To: <20181005105219.GA23402@linux.intel.com>
Message-ID: <alpine.LRH.2.21.1810060422280.8957@namei.org>
References: <20181005105219.GA23402@linux.intel.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2018, Jarkko Sakkinen wrote:

> Hi James,
> 
> These are the updates to v4.20. The only new feature is non-blocking
> operation for /dev/tpm0.

Thanks, pulled to next-tpm and next-testing.

-- 
James Morris
<jmorris@namei.org>

