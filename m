Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63D0C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 23:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDB4205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 23:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDB4205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=80x24.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbeKYKNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 05:13:02 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:39212 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbeKYKNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 05:13:02 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 29F011F97E;
        Sat, 24 Nov 2018 23:23:27 +0000 (UTC)
Date:   Sat, 24 Nov 2018 23:23:27 +0000
From:   Eric Wong <e@80x24.org>
To:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Shuduo Sang <shuduo.sang@canonical.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-kernel@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: add adaptive_kbd_modes
 parameter
Message-ID: <20181124232327.t3awc6dnjqdtvzwu@dcvr>
References: <20181115073429.z44czywrf7f65ndb@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181115073429.z44czywrf7f65ndb@dcvr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> The above setting with this change and the following keymap
> preserves my sanity on the atrocious adaptive keyboard on
> the 2nd-gen X1 Carbon:

Any comments on this patch?  The Esc and F-keys on the keyboard
are still numb and I'll be getting rid of the laptop in a few
days; but maybe my patch can still be useful to others...
