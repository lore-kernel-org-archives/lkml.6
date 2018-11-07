Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5DFC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5CD2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5CD2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeKHH7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:59:08 -0500
Received: from ms.lwn.net ([45.79.88.28]:45814 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbeKHH7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:59:07 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3277C6E8;
        Wed,  7 Nov 2018 22:26:42 +0000 (UTC)
Date:   Wed, 7 Nov 2018 15:26:41 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Will Korteland <will@korte.land>
Subject: Re: [PATCH v2] Documentation: dynamic-debug: fix wildcard
 description
Message-ID: <20181107152641.275f2816@lwn.net>
In-Reply-To: <c3bedde3-4653-f66d-c30f-4772d3d8bae2@infradead.org>
References: <c3bedde3-4653-f66d-c30f-4772d3d8bae2@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2018 18:10:58 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Fix grammar about wildcards and insert a space between sentences.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jason Baron <jbaron@akamai.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Will Korteland <will@korte.land>

Applied, thanks.

jon
