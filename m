Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E374ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0E82145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0E82145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeJSIZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:25:03 -0400
Received: from namei.org ([65.99.196.166]:45726 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbeJSIZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:25:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w9J0LPNN029762;
        Fri, 19 Oct 2018 00:21:25 GMT
Date:   Fri, 19 Oct 2018 11:21:25 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] loadpin updates for security-next
In-Reply-To: <20181018230542.GA48284@beast>
Message-ID: <alpine.LRH.2.21.1810191121050.29701@namei.org>
References: <20181018230542.GA48284@beast>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018, Kees Cook wrote:

> Hi James,
> 
> Please pull these loadpin changes for security-next. This is a small
> reporting improvement and the param change needed for the ordering
> series (but since the loadpin change is desired and separable, I'm
> putting it here).
> 
> Thanks!
> 
> -Kees
> 
> The following changes since commit 57361846b52bc686112da6ca5368d11210796804:
> 
>   Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/loadpin-security-next
> 

Thanks, pulled to next-loadpin and next-testing.

-- 
James Morris
<jmorris@namei.org>

