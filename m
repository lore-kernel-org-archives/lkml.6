Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFC2ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 02:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31084214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 02:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31084214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeIQHfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 03:35:52 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:58646 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727749AbeIQHfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 03:35:51 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1843878|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03310;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.CrlojTG_1537150217;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CrlojTG_1537150217)
          by smtp.aliyun-inc.com(10.147.42.198);
          Mon, 17 Sep 2018 10:10:18 +0800
Date:   Mon, 17 Sep 2018 10:10:17 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V5 2/3] dt-bindings: interrupt-controller: C-SKY APB intc
Message-ID: <20180917021017.GB22452@guoren-Inspiron-7460>
References: <a70337117db84f6e1091d0b3fc28acb691ac9b35.1537087118.git.ren_guo@c-sky.com>
 <162f7f98697cd9d806a1a843c6177bb943ea2b33.1537087118.git.ren_guo@c-sky.com>
 <86h8ipmeey.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86h8ipmeey.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 08:27:01PM +0100, Marc Zyngier wrote:
> On Sun, 16 Sep 2018 09:50:03 +0100,
> Guo Ren <ren_guo@c-sky.com> wrote:
> > 
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> 
> Please write a commit message. Same thing for the following patch.
Ok.

Best Regards
 Guo Ren
