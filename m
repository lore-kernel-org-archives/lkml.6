Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F10ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E721420854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E721420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388626AbeGWQdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:33:50 -0400
Received: from ms.lwn.net ([45.79.88.28]:34824 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388273AbeGWQdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:33:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 743039B0;
        Mon, 23 Jul 2018 15:32:04 +0000 (UTC)
Date:   Mon, 23 Jul 2018 09:32:03 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     valdis.kletnieks@vt.edu
Cc:     Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH scripts/kernel-doc
Message-ID: <20180723093203.3216b47f@lwn.net>
In-Reply-To: <50400.1531846649@turing-police.cc.vt.edu>
References: <50400.1531846649@turing-police.cc.vt.edu>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018 12:57:29 -0400
valdis.kletnieks@vt.edu wrote:

> Fix a warning whinge from Perl introduced by "scripts: kernel-doc: parse next structs/unions"
> 
> Unescaped left brace in regex is deprecated here (and will be fatal in Perl 5.32), passed through in regex; marked by <-- HERE in m/({ <-- HERE [^\{\}]*})/ at ./scripts/kernel-doc line 1155.
> Unescaped left brace in regex is deprecated here (and will be fatal in Perl 5.32), passed through in regex; marked by <-- HERE in m/({ <-- HERE )/ at ./scripts/kernel-doc line 1179.

Applied, thanks.

jon
