Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A58C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CC020851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544735710;
	bh=NOT3M6HPJd8HMQ8qUmmJoQpD5J0d6MOQ+4FcfRsByoE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bjQFjflxctv+toxbEgAEx646b7wc9blU+eAbgqHpYFIjbUV8sLw81KeJnvLsaTPDb
	 9R0zz0jkEbyGpHuBkxBvrxEUOOOPdabdJxYa6cP6iGIat7qGXswewlyoKWNukGJUos
	 Nq0AR0ed9WXzL4kMp6BZGzBvf1JNBFwfW+OcR+Bw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CC020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeLMVPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:15:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728820AbeLMVPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:15:04 -0500
Subject: Re: [GIT PULL] kselftest update for Linux 4.20-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544735703;
        bh=NOT3M6HPJd8HMQ8qUmmJoQpD5J0d6MOQ+4FcfRsByoE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vbQ/ypwfo8Ghzabg3hjhdEVW/uD1ImtK7mtvHpZvVPd75xoyh7J4H2i0Tunttccbo
         +l/ER3WOU/Ki4LyTKp+hGIGikCW+iRlWOBn2xs5HCJN50JdJRCHlePVngmTMR1ZwTN
         yM3ukyeC36QTe5/MiKvMRwFm+hN/njgmHtEpveGI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <fe1c6815-c338-e264-cd77-7d92457acf4c@kernel.org>
References: <fe1c6815-c338-e264-cd77-7d92457acf4c@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <fe1c6815-c338-e264-cd77-7d92457acf4c@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-4.20-rc7
X-PR-Tracked-Commit-Id: 2bd61abead58c82714a1f6fa6beb0fd0df6a6d13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65e08c5e86311143f45c3e4389561af3107fc8f6
Message-Id: <20181213211503.3163.10294.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 13 Dec 2018 21:15:03 +0000
To:     shuah <shuah@kernel.org>
Cc:     torvalds@linux-foundation.org, shuah <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Dec 2018 13:37:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-4.20-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65e08c5e86311143f45c3e4389561af3107fc8f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
