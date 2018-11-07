Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9E6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6107320882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6107320882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbeKHIEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:04:38 -0500
Received: from ms.lwn.net ([45.79.88.28]:45874 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbeKHIEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:04:36 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 884462ED;
        Wed,  7 Nov 2018 22:32:09 +0000 (UTC)
Date:   Wed, 7 Nov 2018 15:32:08 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joris Gutjahr <joris.gutjahr@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc-guide:kernel-doc.rst: Reference to foobar
Message-ID: <20181107153208.22c0ac5e@lwn.net>
In-Reply-To: <20181028192827.19136-1-joris.gutjahr@gmail.com>
References: <20181028192827.19136-1-joris.gutjahr@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Oct 2018 20:28:28 +0100
Joris Gutjahr <joris.gutjahr@gmail.com> wrote:

> In the Function documentation Section of kernel-doc.rst
> there is a function_name() function as an example for
> how to make a comment about a function.
> 
> But at the end of that example there is a reference to foobar 
> instead of function_name.
> 
> I think that should rather be function_name, because that
> was the placeholder the whole example was using.
> 
> Signed-off-by: Joris Gutjahr <joris.gutjahr@gmail.com>

Sure, make sense.  Applied, thanks.

jon
