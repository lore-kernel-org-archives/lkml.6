Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93626C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69832206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfAGPac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:30:32 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56938 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbfAGPac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:30:32 -0500
Received: from localhost (unknown [144.121.20.163])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 12D8214C83723;
        Mon,  7 Jan 2019 07:30:31 -0800 (PST)
Date:   Mon, 07 Jan 2019 07:30:29 -0800 (PST)
Message-Id: <20190107.073029.563146149237352062.davem@davemloft.net>
To:     ottosabart@seberm.com
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] doc: network: integrate offload documents into
 doc tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1546730285.git.ottosabart@seberm.com>
References: <cover.1546730285.git.ottosabart@seberm.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 07 Jan 2019 07:30:31 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Otto Sabart <ottosabart@seberm.com>
Date: Sun, 6 Jan 2019 00:28:45 +0100

> Changes in v2:
> - Patch #3 and #2 were combined into patch #2.

Jon, do you want to integrate these?  I'm fine with that and I don't anticiapte
any serious conflicts.

Acked-by: David S. Miller <davem@davemloft.net>
