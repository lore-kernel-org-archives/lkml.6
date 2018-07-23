Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3D6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17E320854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17E320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388668AbeGWQfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:35:06 -0400
Received: from ms.lwn.net ([45.79.88.28]:34840 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387995AbeGWQfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:35:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D89439B0;
        Mon, 23 Jul 2018 15:33:19 +0000 (UTC)
Date:   Mon, 23 Jul 2018 09:33:18 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Siddaraju DH <siddarajudh@gmail.com>
Cc:     john.stultz@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] timekeeping.txt: Correct maxCount of n-bit binary
 counter
Message-ID: <20180723093318.136fd72b@lwn.net>
In-Reply-To: <20180719163651.19360-1-siddarajudh@gmail.com>
References: <20180719163651.19360-1-siddarajudh@gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018 22:06:51 +0530
Siddaraju DH <siddarajudh@gmail.com> wrote:

> A n-bit binary counter can count a maximum of 2^n events and the count
> value ranges from 0 to (2^n)-1
> 
> Signed-off-by: Siddaraju DH <siddarajudh@gmail.com>

Applied, thanks.

jon
