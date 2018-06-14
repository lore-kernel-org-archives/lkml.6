Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 12F9AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D50208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D50208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754680AbeFNH3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:29:51 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:47522 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752748AbeFNH3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:29:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 748F4609197B;
        Thu, 14 Jun 2018 09:29:49 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 28wWeCNIsRbS; Thu, 14 Jun 2018 09:29:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2733F6094C2F;
        Thu, 14 Jun 2018 09:29:49 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ghJnpb2jyAa0; Thu, 14 Jun 2018 09:29:49 +0200 (CEST)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 0819C609197B;
        Thu, 14 Jun 2018 09:29:49 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     dedekind1@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 2/2] ubi: introduce ubi.nocheck parameter to skip CRC check when attaching ubi vol
Date:   Thu, 14 Jun 2018 09:29:42 +0200
Message-ID: <1588647.N1yrutfcI7@blindfold>
In-Reply-To: <20180611102037.n5kkdq4mcoixmvti@qschulz>
References: <95e04a201ac4ef82e68ce8e0c4f548b193e51b55.1524214122.git-series.quentin.schulz@bootlin.com> <2085970.qGmQXvoWho@blindfold> <20180611102037.n5kkdq4mcoixmvti@qschulz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quentin,

Am Montag, 11. Juni 2018, 12:20:37 CEST schrieb Quentin Schulz:
> If we go for a per-image flag, adding nocheck to the ioctl makes sense,
> otherwise we have to find a way to select only one or more volumes for
> which the nocheck flag should be set. That being said, I'm not sure a
> per-image flag is the way we want to go.
> 
> What are your thoughts on this?

I like that approach a lot more, please send a patch. :-)
Having a volume flag will reduce complexity a lot.

Thanks,
//richard

