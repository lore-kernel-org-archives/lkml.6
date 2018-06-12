Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6C06AC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291C6208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291C6208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933216AbeFLLFN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:05:13 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:39554 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932433AbeFLLFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:05:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 841DE6094C39;
        Tue, 12 Jun 2018 13:05:10 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PvtFOFlWG2DR; Tue, 12 Jun 2018 13:05:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 470CC60A04B4;
        Tue, 12 Jun 2018 13:05:10 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aknzHjZj_mQa; Tue, 12 Jun 2018 13:05:10 +0200 (CEST)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 271C7608D699;
        Tue, 12 Jun 2018 13:05:10 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philipp Rosenberger <p.rosenberger@linutronix.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 2/2] mtd: rawnand: denali: add more clocks
Date:   Tue, 12 Jun 2018 13:05:03 +0200
Message-ID: <3063058.uoHcm7uEyX@blindfold>
In-Reply-To: <20180612130329.1c17311f@bbrezillon>
References: <1528799515-1356-1-git-send-email-yamada.masahiro@socionext.com> <CAK7LNASM53scdd-OZOj_7404Eru3a98uNLagip_GdkrSSaG3-Q@mail.gmail.com> <20180612130329.1c17311f@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 12. Juni 2018, 13:03:29 CEST schrieb Boris Brezillon:
> On Tue, 12 Jun 2018 19:36:06 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> 
> > Maybe, the commit title should be:
> > 
> > mtd: rawnand: denali: add more clocks and improve setup_data_interface
> 
> Or you split that in 2 commits, one retrieving the new clks, and the
> other one fixing/improving ->setup_data_interface().

Yeah, please split the patch. It needs to go into -stable as well.
One patch should just unbreak the driver.

Thanks,
//richard

