Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C36ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC5B21473
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC5B21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJRGD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:03:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53242 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeJRGD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:03:29 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BB9B83A01;
        Wed, 17 Oct 2018 22:05:47 +0000 (UTC)
Date:   Wed, 17 Oct 2018 15:05:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        tj@kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] serial: set suppress_bind_attrs flag only if
 builtin
Message-Id: <20181017150546.0d451252950214bec74a6fc8@linux-foundation.org>
In-Reply-To: <20181017140311.28679-1-anders.roxell@linaro.org>
References: <20181017140311.28679-1-anders.roxell@linaro.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 16:03:10 +0200 Anders Roxell <anders.roxell@linaro.org> wrote:

> Cc: Arnd Bergmann <arnd@arndb.de>
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

This should have Arnd's Signed-off-by: as well.


