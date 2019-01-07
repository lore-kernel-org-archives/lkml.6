Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D178C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB9B206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfAGWAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:00:07 -0500
Received: from ms.lwn.net ([45.79.88.28]:53518 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbfAGWAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:00:07 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C8C5D9A9;
        Mon,  7 Jan 2019 22:00:06 +0000 (UTC)
Date:   Mon, 7 Jan 2019 15:00:05 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Miller <davem@davemloft.net>
Cc:     ottosabart@seberm.com, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] doc: network: integrate offload documents into
 doc tree
Message-ID: <20190107150005.64bcc7e0@lwn.net>
In-Reply-To: <20190107.073029.563146149237352062.davem@davemloft.net>
References: <cover.1546730285.git.ottosabart@seberm.com>
        <20190107.073029.563146149237352062.davem@davemloft.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Jan 2019 07:30:29 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> Jon, do you want to integrate these?  I'm fine with that and I don't anticiapte
> any serious conflicts.

I'll do that shortly, thanks.

jon
