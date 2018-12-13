Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0338AC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6D120811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6D120811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbeLMBFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 20:05:43 -0500
Received: from namei.org ([65.99.196.166]:51520 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbeLMBFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 20:05:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBD08iIm009513;
        Thu, 13 Dec 2018 00:08:44 GMT
Date:   Thu, 13 Dec 2018 11:08:44 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     linux-kernel@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [GIT PULL] seccomp updates for next
In-Reply-To: <20181212231630.GA31584@beast>
Message-ID: <alpine.LRH.2.21.1812131108130.7600@namei.org>
References: <20181212231630.GA31584@beast>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018, Kees Cook wrote:

> Hi James,
> 
> Please pull these seccomp changes for next.
> 

Pulled to next-seccomp and next-testing in:

git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git


-- 
James Morris
<jmorris@namei.org>

