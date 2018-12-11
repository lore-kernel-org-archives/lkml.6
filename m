Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F07FC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642552084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642552084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeLKS5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:57:48 -0500
Received: from namei.org ([65.99.196.166]:59046 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeLKS5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:57:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBBIvSPJ013151;
        Tue, 11 Dec 2018 18:57:28 GMT
Date:   Wed, 12 Dec 2018 05:57:28 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Subject: Re: [PATCH v5 00/38] LSM: Module stacking for SARA and Landlock
In-Reply-To: <CAGXu5jLUJYM3nDDhFeBOKkTnyCR-tXAv-rteBJFMBn_J7kVkqA@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1812120556040.11653@namei.org>
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com> <CAGXu5jLUJYM3nDDhFeBOKkTnyCR-tXAv-rteBJFMBn_J7kVkqA@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018, Kees Cook wrote:

> On Mon, Nov 26, 2018 at 3:22 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > v5: Include Kees Cook's rework of the lsm command
> >     line interface. Stacking is not conditional.
> 
> Can you resend this series with corrected "From:" lines in the body, etc?
> 
> Beyond that, I obviously like it. James, what's needed for this to move forward?

If there are no outstanding issues, I plan to merge this for 4.21.


-- 
James Morris
<jmorris@namei.org>

