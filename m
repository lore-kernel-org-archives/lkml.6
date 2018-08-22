Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AA3C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E799121480
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E799121480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeHVNYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:24:03 -0400
Received: from namei.org ([65.99.196.166]:43846 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727396AbeHVNYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:24:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w7M9xJ3w032085;
        Wed, 22 Aug 2018 09:59:19 GMT
Date:   Wed, 22 Aug 2018 19:59:19 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Jordan Glover <Golden_Miller83@protonmail.ch>,
        Sargun Dhillon <sargun@sargun.me>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Subject: Re: [PATCH v1 00/22] LSM: Full security module stacking
In-Reply-To: <8e2bdc10-3142-9e8d-ff05-70fa4d862dd5@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1808221958170.29682@namei.org>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com> <CAMp4zn94SzqK_Q=de2E+Fpv5yeAhYv62XW-KU3=ghRma9d7Jvw@mail.gmail.com> <a287800e-bd4d-2b99-8c4c-bd61ba87fab1@schaufler-ca.com> <kubjHWMWfFDu8Rk19x79iMDKVbewTUMWwSjOA7vFGIbYsWYcGb50jb-Z-PSXxmcby3ZFMZWi0HCeuFgo3F8BRskxo_JUdSHFhdIsIlBxHyQ=@protonmail.ch>
 <8e2bdc10-3142-9e8d-ff05-70fa4d862dd5@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018, Casey Schaufler wrote:

> On 8/14/2018 4:22 PM, Jordan Glover wrote:
> > On August 14, 2018 8:28 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > On the other hand there is concern that those security modules might
> > be abandoned if they have to wait until everything is finished :)
> 
> There is some truth to that. If we can get commitment from the developers
> of those security module to push for getting upstream, a statement of
> intent to support additional modules (e.g. Landlock, S.A.R.A.) from a
> significant distribution (e.g. Fedora, Ubuntu, SuSE) and ACKs from the
> maintainers of the existing modules we should be able to breeze right in.
> 

Sounds reasonable. Please focus on what's needed for Landlock and SARA.


-- 
James Morris
<jmorris@namei.org>

