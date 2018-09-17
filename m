Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19E3ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CBC214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CBC214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeIQMjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 08:39:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36074 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeIQMjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 08:39:08 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1FBA7516;
        Mon, 17 Sep 2018 07:13:02 +0000 (UTC)
Date:   Mon, 17 Sep 2018 09:12:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [GIT PULL] kselftest fixes update for Linux 4.19-rc5
Message-ID: <20180917071259.GA27405@kroah.com>
References: <ce9af2b4-86e1-6603-cd36-b900fb583e6f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce9af2b4-86e1-6603-cd36-b900fb583e6f@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 02:22:21PM -0600, Shuah Khan wrote:
> Hi Linus,
> 
> Please pull the following Kselftest update for Linux 4.19-rc5
> 
> linux-kselftest-4.19-rc5
> 
> This Kselftest fixes update for 4.19-rc5 consists of:
> 
> -- fixes to build failures
> -- fixes to add missing config files to increase test coverage
> -- fixes to cgroup test and a new cgroup test for memory.oom.group
> 
> Please note that the selftests: add headers_install to lib.mk patch changes
> the main Makefile. Some tests can't build without headers installed. This 
> fixes such test build failures.

I've merged these now, thanks.

greg k-h
