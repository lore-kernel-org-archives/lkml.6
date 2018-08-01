Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECE5C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D328F208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D328F208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbeHAVWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:22:03 -0400
Received: from namei.org ([65.99.196.166]:41410 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387396AbeHAVWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:22:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w71JYcVv010827;
        Wed, 1 Aug 2018 19:34:38 GMT
Date:   Thu, 2 Aug 2018 05:34:38 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Micah Morton <mortonm@chromium.org>
cc:     linux-security-module@vger.kernel.org, serge@hallyn.com,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] security: Add LSM fixup hooks to set*gid syscalls.
In-Reply-To: <CAJ-EccOMdg370kMfU2=gMbSEyOE3sRVLpca86BHgr+i0_C=J9Q@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1808020534330.7346@namei.org>
References: <CAJ-EccNNCNrA7to85WrYFjRUP7Z1XC+sJ2JXkargiEvXd11AVg@mail.gmail.com> <alpine.LRH.2.21.1808010608080.8072@namei.org> <CAJ-EccOMdg370kMfU2=gMbSEyOE3sRVLpca86BHgr+i0_C=J9Q@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018, Micah Morton wrote:

> The ChromiumOS LSM used by ChromeOS will provide a hook for this, in
> order to enforce ChromeOS-specific policies regarding which UIDs/GIDs a
> process with CAP_SET{UID/GID} can transition to

Will you be submitting this LSM to mainline?  It's a policy generally of 
the kernel that we only add features to support in-tree code.


-- 
James Morris
<jmorris@namei.org>

