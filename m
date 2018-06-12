Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0BBADC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A85208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A85208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934060AbeFLUdO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:33:14 -0400
Received: from namei.org ([65.99.196.166]:59300 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754302AbeFLUdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:33:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w5CKWYo9015370;
        Tue, 12 Jun 2018 20:32:34 GMT
Date:   Wed, 13 Jun 2018 06:32:34 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Joe Perches <joe@perches.com>,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [-next PATCH] security: use octal not symbolic permissions
In-Reply-To: <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1806130631400.13763@namei.org>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com> <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2018, Casey Schaufler wrote:

> If you want to break this up by security module I would take
> the Smack part as soon as James does the tree update. If James
> wants to take the whole thing at once you can add my:
> 
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> 
> for the Smack changes.

It's probably simplest for me to take them as one patch.

-- 
James Morris
<jmorris@namei.org>

