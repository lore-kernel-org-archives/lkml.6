Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0233CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78CB208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78CB208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbeGJVSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:18:50 -0400
Received: from ms.lwn.net ([45.79.88.28]:35486 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732268AbeGJVSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:18:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0028C97D;
        Tue, 10 Jul 2018 21:08:56 +0000 (UTC)
Date:   Tue, 10 Jul 2018 15:08:54 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] docs: kernel-parameters.txt: document xhci-hcd.quirks
 parameter
Message-ID: <20180710150854.3ccb51f6@lwn.net>
In-Reply-To: <20180705133142.18844-1-laurentiu.tudor@nxp.com>
References: <20180705133142.18844-1-laurentiu.tudor@nxp.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Jul 2018 16:31:42 +0300
Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:

> This parameter introduced several years ago in the XHCI host controller
> driver was somehow left undocumented. Add a few lines in the kernel
> parameters text.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Applied, thanks.

jon
