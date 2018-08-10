Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9DCC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1EE223C9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1EE223C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbeHKAlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 20:41:20 -0400
Received: from ms.lwn.net ([45.79.88.28]:33404 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbeHKAlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 20:41:20 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C645B9B0;
        Fri, 10 Aug 2018 22:09:35 +0000 (UTC)
Date:   Fri, 10 Aug 2018 16:09:34 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Antonino A. Daplas" <adaplas@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Documentation: corrections to console/console.txt
Message-ID: <20180810160934.4298ae99@lwn.net>
In-Reply-To: <933b90be-5fff-d0c7-a7a1-4e4362713846@infradead.org>
References: <933b90be-5fff-d0c7-a7a1-4e4362713846@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2018 16:24:55 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix typos, line length, grammar, punctuation, and capitalization
> in console.txt.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied, thanks.  First patch to that file in over five years...

jon
