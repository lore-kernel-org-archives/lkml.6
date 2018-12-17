Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1844EC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E527C21473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbeLQWLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:11:44 -0500
Received: from namei.org ([65.99.196.166]:52246 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbeLQWLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:11:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBHMBb1q006474;
        Mon, 17 Dec 2018 22:11:37 GMT
Date:   Tue, 18 Dec 2018 09:11:37 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] integrity: Remove references to module keyring
In-Reply-To: <1545077031.10804.8.camel@linux.ibm.com>
Message-ID: <alpine.LRH.2.21.1812180911040.6212@namei.org>
References: <20181213013909.25737-1-bauerman@linux.ibm.com>  <alpine.LRH.2.21.1812180633290.29218@namei.org> <1545077031.10804.8.camel@linux.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018, Mimi Zohar wrote:

> On Tue, 2018-12-18 at 06:33 +1100, James Morris wrote:
> > On Wed, 12 Dec 2018, Thiago Jung Bauermann wrote:
> > 
> > > >From what I can tell, it has never been used.
> 
> This was introduced prior to Rusty's decision to use appended
> signatures for kernel modules.
> 
> > > 
> > > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > 
> > Mimi, can I add your acked-by?
> 
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-integrity
and next-testing


-- 
James Morris
<jmorris@namei.org>

