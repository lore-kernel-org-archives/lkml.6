Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2493C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101D825EAB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101D825EAB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934212AbeFYRFb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:05:31 -0400
Received: from namei.org ([65.99.196.166]:32938 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934048AbeFYRFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:05:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w5PH5NUI029476;
        Mon, 25 Jun 2018 17:05:23 GMT
Date:   Tue, 26 Jun 2018 03:05:23 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>
Subject: Re: [PULL] Smack: Mark inode instant in smack_task_to_inode
In-Reply-To: <813ecc0b-4a9e-22c9-b893-504936bab342@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1806260304580.26153@namei.org>
References: <813ecc0b-4a9e-22c9-b893-504936bab342@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018, Casey Schaufler wrote:

> James, would you please pull this change for 4.18.

I already have it queued for Linus, I'll send it up probably today.

> 
> Al Viro's /proc clean-up in commit 1bbc55131e59bd099fdc568d3aa0b42634dbd188
> created a regression in Smack xattr behavior in /proc. This fixes that problem
> with a minimum of fuss.
> 
> 
> The following changes since commit 0f8983cf97d3327531b7843c831517cac3a1b9ed:
> 
>   Smack: Fix memory leak in smack_inode_getsecctx (2018-06-05 12:16:01 -0700)
> 
> are available in the Git repository at:
> 
>   git://github.com/cschaufler/next-smack smack-for-4.18
> 
> for you to fetch changes up to aabfe8e2d9f49153bafefc82d10bcb6e1e12828d:
> 
>   Smack: Mark inode instant in smack_task_to_inode (2018-06-22 13:55:28 -0700)
> 
> ----------------------------------------------------------------
> Casey Schaufler (1):
>       Smack: Mark inode instant in smack_task_to_inode
> 
>  security/smack/smack_lsm.c | 1 +
>  1 file changed, 1 insertion(+)
> 

-- 
James Morris
<jmorris@namei.org>

