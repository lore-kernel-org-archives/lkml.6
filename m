Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83095C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0A220C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbfBYXXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:23:43 -0500
Received: from namei.org ([65.99.196.166]:54198 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbfBYXXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 18:23:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x1PNNb9Q019939;
        Mon, 25 Feb 2019 23:23:37 GMT
Date:   Tue, 26 Feb 2019 10:23:37 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] LSM: Ignore "security=" when "lsm=" is specified
In-Reply-To: <20190212182318.GA16669@beast>
Message-ID: <alpine.LRH.2.21.1902261023140.19242@namei.org>
References: <20190212182318.GA16669@beast>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019, Kees Cook wrote:

> To avoid potential confusion, explicitly ignore "security=" when "lsm=" is
> used on the command line, and report that it is happening.
> 
> Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general



-- 
James Morris
<jmorris@namei.org>

