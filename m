Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C23C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2EE2802A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2EE2802A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936442AbeF2PC3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:02:29 -0400
Received: from ms.lwn.net ([45.79.88.28]:33054 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936375AbeF2PC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:02:26 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 76E1CC36;
        Fri, 29 Jun 2018 15:02:25 +0000 (UTC)
Date:   Fri, 29 Jun 2018 09:02:24 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] doc: dev-tools: kselftest.rst: update contributing
 new tests
Message-ID: <20180629090224.772ee423@lwn.net>
In-Reply-To: <20180629125201.24025-1-anders.roxell@linaro.org>
References: <20180629100248.11560-1-anders.roxell@linaro.org>
        <20180629125201.24025-1-anders.roxell@linaro.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2018 14:52:01 +0200
Anders Roxell <anders.roxell@linaro.org> wrote:

> Add a description that kernel config options should be added into a
> config file that is placed next to the newly added test.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied, thanks.

jon
