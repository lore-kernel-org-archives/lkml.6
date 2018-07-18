Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0575AECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F0020854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F0020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbeGROrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:47:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55005 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbeGROrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:47:47 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EE17C20732; Wed, 18 Jul 2018 16:09:39 +0200 (CEST)
Received: from bootlin.com (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 91040203EC;
        Wed, 18 Jul 2018 16:09:39 +0200 (CEST)
Date:   Wed, 18 Jul 2018 16:09:39 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mvpp2: debugfs: fix incorrect bitwise operator
Message-ID: <20180718160939.5650559b@bootlin.com>
In-Reply-To: <20180718130846.GA5380@embeddedor.com>
References: <20180718130846.GA5380@embeddedor.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Wed, 18 Jul 2018 08:08:46 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

>The use of the | operator always leads to true, which looks rather
>suspect in this case.
>
>Fix this by using & instead.
>

Acked-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Good catch, thanks.

Maxime
