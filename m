Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE837C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5189208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5189208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeJBCfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:35:42 -0400
Received: from namei.org ([65.99.196.166]:34536 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbeJBCfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:35:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w91Ju81k014959;
        Mon, 1 Oct 2018 19:56:08 GMT
Date:   Tue, 2 Oct 2018 05:56:08 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH security-next v3 02/29] vmlinux.lds.h: Avoid copy/paste
 of security_init section
In-Reply-To: <20180925001832.18322-3-keescook@chromium.org>
Message-ID: <alpine.LRH.2.21.1810020555570.14406@namei.org>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-3-keescook@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2018, Kees Cook wrote:

> Avoid copy/paste by defining SECURITY_INIT in terms of SECURITY_INITCALL.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>

