Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39A1C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797AB2466C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797AB2466C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965728AbeFZOeW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:34:22 -0400
Received: from ms.lwn.net ([45.79.88.28]:35196 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965304AbeFZOeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:34:21 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D58152F3;
        Tue, 26 Jun 2018 14:34:20 +0000 (UTC)
Date:   Tue, 26 Jun 2018 08:34:19 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     tytso@mit.edu, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: add description to dirtytime_expire_seconds
Message-ID: <20180626083419.7f129fe1@lwn.net>
In-Reply-To: <1527724613-17768-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1527724613-17768-1-git-send-email-yang.shi@linux.alibaba.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2018 07:56:53 +0800
Yang Shi <yang.shi@linux.alibaba.com> wrote:

> commit 1efff914afac8a965ad63817ecf8861a927c2ace ("fs: add
> dirtytime_expire_seconds sysctl") introduced dirtytime_expire_seconds
> knob, but there is not description about it in
> Documentation/sysctl/vm.txt.
> 
> Add the description for it.

Applied to the docs tree, sorry for taking so long to get to it.

Thanks,

jon
