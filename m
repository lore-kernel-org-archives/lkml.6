Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41616C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA992085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA992085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbeJKXVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:21:01 -0400
Received: from namei.org ([65.99.196.166]:33840 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727375AbeJKXVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:21:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w9BFqW2P020603;
        Thu, 11 Oct 2018 15:52:33 GMT
Date:   Fri, 12 Oct 2018 02:52:32 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LSM <linux-security-module@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
In-Reply-To: <CAGXu5jLzsYY1Ja8onnNdHXbenZ6vPrat_L8U_sbcCic0qk--qQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1810120252220.20563@namei.org>
References: <20181011001846.30964-1-keescook@chromium.org> <alpine.LRH.2.21.1810111443500.25845@namei.org> <CAGXu5jLzsYY1Ja8onnNdHXbenZ6vPrat_L8U_sbcCic0qk--qQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018, Kees Cook wrote:

> On Wed, Oct 10, 2018 at 8:45 PM, James Morris <jmorris@namei.org> wrote:
> > On Wed, 10 Oct 2018, Kees Cook wrote:
> >
> >> v5:
> >> - redesigned to use CONFIG_LSM= and lsm= for both ordering and enabling
> >> - dropped various Reviewed-bys due to rather large refactoring
> >
> > Patches 1-10 applied to
> > git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
> > and next-testing.
> 
> Very cool; thanks!
> 
> As for the rest, I could post some examples of how the new CONFIG_LSM
> and "lsm=..." work (and how they mix with the "legacy" options). Would
> that be helpful?

Yes, thanks.

-- 
James Morris
<jmorris@namei.org>

