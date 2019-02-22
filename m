Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D3FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48272070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfBVR6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:58:06 -0500
Received: from namei.org ([65.99.196.166]:53646 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfBVR6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:58:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x1MHviVm014713;
        Fri, 22 Feb 2019 17:57:44 GMT
Date:   Sat, 23 Feb 2019 04:57:44 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
cc:     John Johansen <john.johansen@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] security: mark expected switch fall-throughs and add
 a missing break
In-Reply-To: <20190208205453.GA3232@embeddedor>
Message-ID: <alpine.LRH.2.21.1902230457250.27514@namei.org>
References: <20190208205453.GA3232@embeddedor>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2019, Gustavo A. R. Silva wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> security/integrity/ima/ima_template_lib.c:85:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
> security/integrity/ima/ima_policy.c:940:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
> security/integrity/ima/ima_policy.c:943:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> security/integrity/ima/ima_policy.c:972:21: warning: this statement may fall through [-Wimplicit-fallthrough=]
> security/integrity/ima/ima_policy.c:974:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> security/smack/smack_lsm.c:3391:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
> security/apparmor/domain.c:569:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

-- 
James Morris
<jmorris@namei.org>

