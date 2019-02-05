Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFFBC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE700217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfBEV3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:29:24 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:38864 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfBEV3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:29:23 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gr8HR-0005Rm-Gn; Tue, 05 Feb 2019 14:29:21 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gr8HH-0004Lo-1w; Tue, 05 Feb 2019 14:29:21 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190206073330.6e266351@canb.auug.org.au>
Date:   Tue, 05 Feb 2019 15:29:04 -0600
In-Reply-To: <20190206073330.6e266351@canb.auug.org.au> (Stephen Rothwell's
        message of "Wed, 6 Feb 2019 07:33:30 +1100")
Message-ID: <87bm3pzzz3.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gr8HH-0004Lo-1w;;;mid=<87bm3pzzz3.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19DyLmJDWzIjs03+L/d5W/JCcWewsy+9JM=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: linux-next: Fixes tag needs some work in the userns tree
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi Eric,
>
> In commit
>
>   a692933a8769 ("signal: Always attempt to allocate siginfo for SIGSTOP")
>
> Fixes tag
>
>   Fixes: 6dfc88977e42 ("[PATCH] shared thread signals")
>
> has these problem(s):
>
>   - Target SHA1 does not exist

The SHA1 tag does exist and I have another tag:
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
That lists the tree it actually came from.

That is the best way I can see to handle bugs that predate v2.6.12 that
Linus first put into git.

Would it make sense to graft you tree that you check for the existence
of bad sha1s to Thomas's import of the bk tree into git?

Is there a better way to refer to old commits that I haven't seen?

Eric

