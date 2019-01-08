Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA8FC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE19214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfAHVGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:06:21 -0500
Received: from namei.org ([65.99.196.166]:55088 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728794AbfAHVGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:06:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x08L5jjV025472;
        Tue, 8 Jan 2019 21:05:45 GMT
Date:   Wed, 9 Jan 2019 08:05:45 +1100 (AEDT)
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
In-Reply-To: <CAGXu5jJOGKAFrFF7HSPnqLpLz0no2Ae_z0TkWPeRt1WWqhqFOA@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1901090805121.24546@namei.org>
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com> <CAGXu5jLUJYM3nDDhFeBOKkTnyCR-tXAv-rteBJFMBn_J7kVkqA@mail.gmail.com> <alpine.LRH.2.21.1812120556040.11653@namei.org> <CAGXu5j+bx7nJBMdFYigYnJFRyCvz0NAxfiWF8yP9EhRESLnn+Q@mail.gmail.com>
 <CAGXu5jJOGKAFrFF7HSPnqLpLz0no2Ae_z0TkWPeRt1WWqhqFOA@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019, Kees Cook wrote:

> On Tue, Dec 11, 2018 at 1:19 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Dec 11, 2018 at 10:57 AM James Morris <jmorris@namei.org> wrote:
> > >
> > > On Tue, 4 Dec 2018, Kees Cook wrote:
> > >
> > > > On Mon, Nov 26, 2018 at 3:22 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > > > v5: Include Kees Cook's rework of the lsm command
> > > > >     line interface. Stacking is not conditional.
> > > >
> > > > Can you resend this series with corrected "From:" lines in the body, etc?
> > > >
> > > > Beyond that, I obviously like it. James, what's needed for this to move forward?
> > >
> > > If there are no outstanding issues, I plan to merge this for 4.21.
> >
> > Yeah, it looks good to me. (Excepting getting the authorship sorted.)
> 
> I didn't see this actually get merged? Was there something that needed
> fixing? Should I send you a direct pull request for v5.1?

Yep, please send a new pull request.

-- 
James Morris
<jmorris@namei.org>

