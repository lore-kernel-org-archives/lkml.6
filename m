Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56164C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56CC21473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56CC21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeJDEKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:10:08 -0400
Received: from namei.org ([65.99.196.166]:35524 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbeJDEKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:10:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w93LJibv023350;
        Wed, 3 Oct 2018 21:19:44 GMT
Date:   Thu, 4 Oct 2018 07:19:44 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     John Johansen <john.johansen@canonical.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
In-Reply-To: <CAGXu5jLBHN=YSs3Uh49bBJ1SRA1Km2UUD4j37GJJXiKhQq+KPA@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1810040719060.16168@namei.org>
References: <20181002005505.6112-1-keescook@chromium.org> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com> <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com> <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com> <alpine.LRH.2.21.1810030758460.23596@namei.org>
 <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com> <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <alpine.LRH.2.21.1810040416500.13517@namei.org> <CAGXu5j+oPR58oJ06-n7e96-Rmu+ywTW0hud5LhOZ_3UXG5s12w@mail.gmail.com>
 <alpine.LRH.2.21.1810040427550.13517@namei.org> <CAGXu5jJmVR4Wsdti=aFaDhCBaxsVu1KTJOdsJOtFvZOV1ZhdvQ@mail.gmail.com> <CAGXu5jLBHN=YSs3Uh49bBJ1SRA1Km2UUD4j37GJJXiKhQq+KPA@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018, Kees Cook wrote:

> I should also note that I don't want to leave CONFIG_DEFAULT_SECURITY
> in, since it's just a way to disable all the other majors.

Right, default doesn't make sense anymore.


-- 
James Morris
<jmorris@namei.org>

