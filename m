Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480F5C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221A920823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfAUIJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:09:55 -0500
Received: from ms.lwn.net ([45.79.88.28]:33080 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbfAUIJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:09:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ADD90ACC;
        Mon, 21 Jan 2019 02:14:03 +0000 (UTC)
Date:   Sun, 20 Jan 2019 19:13:59 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Otto Sabart <ottosabart@seberm.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 1/1] doc: networking: integrate scaling document into
 doc tree
Message-ID: <20190120191359.41e5de0c@lwn.net>
In-Reply-To: <3eddcfcf3916ef8e89230971359fc9b6bef35d20.1547843156.git.ottosabart@seberm.com>
References: <cover.1547843156.git.ottosabart@seberm.com>
        <3eddcfcf3916ef8e89230971359fc9b6bef35d20.1547843156.git.ottosabart@seberm.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 21:38:32 +0100
Otto Sabart <ottosabart@seberm.com> wrote:

> Convert scaling document into reStructuredText and add reference to
> scaling document into main table of contents in network documentation.
> 
> There are no semantic changes.
> 
> There are no references to "scaling.txt" file. Whole kernel tree was
> checked using:
> $ grep -r "scaling\.txt"
> 
> Signed-off-by: Otto Sabart <ottosabart@seberm.com>

So this didn't apply cleanly to docs-next due to a conflict with
commit d96bedb2b248 ("doc: networking: add offload documents into main
index file") by one Otto Sabart.  I've fixed that up, but in the future
it will be helpful if you can be sure that your patches are against the
docs tree if you want me to merge them.

Thanks,

jon
