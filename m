Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_TVD_FUZZY_SECTOR autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49562C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114AA20850
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114AA20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbeKZGUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 01:20:38 -0500
Received: from ms.lwn.net ([45.79.88.28]:57848 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeKZGUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 01:20:37 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 874C797E;
        Sun, 25 Nov 2018 19:28:51 +0000 (UTC)
Date:   Sun, 25 Nov 2018 12:28:50 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shreyans Devendra Doshi <0xinfosect0r@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: dev-tools: Fix typos in index.rst
Message-ID: <20181125122850.442e1688@lwn.net>
In-Reply-To: <20181122153456.24413-1-0xinfosect0r@gmail.com>
References: <20181122153456.24413-1-0xinfosect0r@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 10:34:56 -0500
Shreyans Devendra Doshi <0xinfosect0r@gmail.com> wrote:

> Fixes a spelling error and removes an extra whitespace character.
> 
> Signed-off-by: Shreyans Devendra Doshi <0xinfosect0r@gmail.com>

I've applied this for the typo fix, but let me echo Willy's comments about
the whitespace change.  There is no official policy on spaces after
periods in kernel documentation, and I have no interest in adding one;
I'll not be accepting patches making such changes in the future.

Thanks,

jon
