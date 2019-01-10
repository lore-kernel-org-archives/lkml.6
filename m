Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8B6C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863FD20879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfAJUed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:34:33 -0500
Received: from namei.org ([65.99.196.166]:55394 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728818AbfAJUed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:34:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x0AKYMoG009128;
        Thu, 10 Jan 2019 20:34:22 GMT
Date:   Fri, 11 Jan 2019 07:34:22 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Subject: Re: [GIT PULL] blob-stacking updates for security-next
In-Reply-To: <20190108213504.GA32901@beast>
Message-ID: <alpine.LRH.2.21.1901110733060.7043@namei.org>
References: <20190108213504.GA32901@beast>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019, Kees Cook wrote:

> Hi James,
> 
> Please pull these blob-stacking changes for security-next.
> 
> Thanks!

Merged to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
and next-testing.

This passes the SELinux testsuite on my system, and I'm now running this 
on my laptop.

Please test!


-- 
James Morris
<jmorris@namei.org>

