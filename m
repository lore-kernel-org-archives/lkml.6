Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0854EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C762070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfBVP4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:56:39 -0500
Received: from ms.lwn.net ([45.79.88.28]:52644 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfBVP4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:56:39 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E566D35A;
        Fri, 22 Feb 2019 15:56:38 +0000 (UTC)
Date:   Fri, 22 Feb 2019 08:56:37 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] docs: Explicitly state that the 'Fixes:' tag shouldn't
 split lines
Message-ID: <20190222085637.39f02baa@lwn.net>
In-Reply-To: <20190219152715.5674-1-sean.j.christopherson@intel.com>
References: <20190219152715.5674-1-sean.j.christopherson@intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 07:27:15 -0800
Sean Christopherson <sean.j.christopherson@intel.com> wrote:

> ...and use a commit with an obnoxiously long summary in the example to
> make it abundantly clear that keeping the tag on a single line takes
> priority over wrapping at 75 columns.  Without the explicit exemption,
> one might assume splitting the tag is acceptable, even encouraged, e.g.
> due to being conditioned by checkpatch's line length warning.
> 
> Per Stephen's scripts[1] and implied by commit bf4daf12a9fb ("checkpatch:
> avoid some commit message long line warnings"), splitting the 'Fixes:'
> tag across multiple lines is a no-no, presumably because parsing multi-
> line tags is unnecessarily painful.
> 
> [1] https://lkml.kernel.org/r/20190216183433.71b7cfa7@canb.auug.org.au
> 
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Applied, thanks.

jon
