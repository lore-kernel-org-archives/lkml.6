Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA9DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080972083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080972083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeIACg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:36:27 -0400
Received: from ms.lwn.net ([45.79.88.28]:33884 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbeIACg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:36:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1673C906;
        Fri, 31 Aug 2018 22:26:49 +0000 (UTC)
Date:   Fri, 31 Aug 2018 16:26:36 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: dev-tools: kselftest.rst: update config file
 location
Message-ID: <20180831162636.791d4146@lwn.net>
In-Reply-To: <55c84596-0e12-0211-dbee-9eddb9a0ab28@kernel.org>
References: <20180824124744.9842-1-anders.roxell@linaro.org>
        <55c84596-0e12-0211-dbee-9eddb9a0ab28@kernel.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018 11:57:58 -0600
Shuah Khan <shuah@kernel.org> wrote:

> Jo Jon,
> 
> This patch looks good. Here is my Ack for it go through doc tree.
> 
> Acked-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

Applied, thanks.

jon
