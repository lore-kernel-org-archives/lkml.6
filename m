Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61748C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB86B2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB86B2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeIFGXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:23:08 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:55923 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbeIFGXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:23:06 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1417857|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03296;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.Cn3X9WR_1536198579;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Cn3X9WR_1536198579)
          by smtp.aliyun-inc.com(10.147.41.178);
          Thu, 06 Sep 2018 09:49:40 +0800
Date:   Thu, 6 Sep 2018 09:49:38 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Rob Herring <rob.herring@linaro.org>
Cc:     linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH V3 18/26] dt-bindings: csky CPU Bindings
Message-ID: <20180906014937.GA29405@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <aab0c4b467f69c693ed1e24e9fc47ba20b3f9f4a.1536138304.git.ren_guo@c-sky.com>
 <CABGGiszyQpJCB+QAoYwNwsDAhgdWQ3Ud1eR7U1xh9BMYzMKzjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABGGiszyQpJCB+QAoYwNwsDAhgdWQ3Ud1eR7U1xh9BMYzMKzjw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 07:37:50PM -0500, Rob Herring wrote:
> On Wed, Sep 5, 2018 at 7:08 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > ---
> >  Documentation/devicetree/bindings/csky/cpus.txt | 70 +++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/csky/cpus.txt
> 
> Please make sure DT bindings are sent to DT list.
Oh, I forgot add devicetree@vger.kernel.org. Thx for mentioned.

 Guo Ren
