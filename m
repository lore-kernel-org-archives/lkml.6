Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0D4C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC4C20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC4C20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeJDA5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:57:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40158 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJDA5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:57:14 -0400
Received: from localhost (unknown [104.132.0.111])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D27194A4;
        Wed,  3 Oct 2018 18:07:46 +0000 (UTC)
Date:   Wed, 3 Oct 2018 11:07:45 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        mathieu.desnoyers@efficios.com
Subject: Re: [GIT PULL] kselftest fixes update for Linux-4.19-rc7
Message-ID: <20181003180745.GA28575@kroah.com>
References: <ec2d8d2b-c5ac-5ac2-57fd-74efaa7ed0b6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec2d8d2b-c5ac-5ac2-57fd-74efaa7ed0b6@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 08:42:13AM -0600, Shuah Khan wrote:
> Hi Greg,
> 
> Please pull the following kselftest for 4.19-rc7.
> 
> linux-kselftest-4.19-rc7
> 
> This fixes update for 4.19-rc7 consists one fix to rseq test to prevent
> it from seg-faulting when compiled with -fpie.

Now merged, thanks.

greg k-h
