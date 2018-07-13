Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E83ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 01:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C8B214C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 01:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EGyq8MgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C8B214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387981AbeGMBtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 21:49:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52466 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387916AbeGMBtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 21:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lLDiETTR0tN50tdEx/pNwuaW1E+idO73QbxRWt6Pltc=; b=EGyq8MgVIPEIwMyLXV2UbtAbSP
        6uUSam5i1ua16U5IoMNAI7M1ODkiv25/8t5N3X6kJ6v3W5avtohxOXiTTolaAJceGEiSGrmt9iklQ
        HEUGuH/FbIB3FQbKe3RPVLqtcejwAM3ONwAoNSOt1Rzsg6RcproWTlw/EsUUbZYl2vPWsBqbFZTTk
        tcxIA548QlOPGFqSdvy0GMq24WwSYTH3wvLvnk8yvvBXQrbNrIEp0Y6f+sNNDgT/dMUZk6WHy1N5O
        5uwUZwP6lN6tN+2ZE5XDu1E6ablQ1qLYdD0QaNCUNXU7leSUQ9gsGAb7bXWCGU30GAPqjEh4kK/vL
        7csC5Yug==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdn14-0007Fl-24; Fri, 13 Jul 2018 01:37:02 +0000
Subject: Re: [PATCH 22/32] vfs: Provide documentation for new mount API [ver
 #9]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126263703.14533.5276559268411477268.stgit@warthog.procyon.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4239f2b9-4aa3-cd01-b445-bba055a52693@infradead.org>
Date:   Thu, 12 Jul 2018 18:37:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153126263703.14533.5276559268411477268.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 03:43 PM, David Howells wrote:
> Provide documentation for the new mount API.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  Documentation/filesystems/mount_api.txt |  439 +++++++++++++++++++++++++++++++
>  1 file changed, 439 insertions(+)
>  create mode 100644 Documentation/filesystems/mount_api.txt

Hi,

I would review this but it sounds like I should just wait for the
next version.

-- 
~Randy
