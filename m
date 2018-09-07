Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183E3C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABDD2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABDD2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeIGLVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:21:45 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:46934 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbeIGLVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:21:45 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1168613|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03273;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.CnaPd4m_1536302509;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CnaPd4m_1536302509)
          by smtp.aliyun-inc.com(10.147.44.118);
          Fri, 07 Sep 2018 14:41:49 +0800
Date:   Fri, 7 Sep 2018 14:41:49 +0800
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
Subject: Re: [PATCH V3 19/26] dt-bindings: timer: gx6605s SOC timer
Message-ID: <20180907064149.GA18512@guoren>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <768ac390f9eee8acb4dc9ca85a489a1d2fd00628.1536138304.git.ren_guo@c-sky.com>
 <CABGGiszuo3gpjmutYzOpQUmGaNjq88_5pDj2TjXveX9x2+Rsig@mail.gmail.com>
 <20180906020229.GB29405@guoren-Inspiron-7460>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906020229.GB29405@guoren-Inspiron-7460>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 10:02:29AM +0800, Guo Ren wrote:
> On Wed, Sep 05, 2018 at 07:47:29PM -0500, Rob Herring wrote:
> > On Wed, Sep 5, 2018 at 7:09 AM Guo Ren <ren_guo@c-sky.com> wrote:
> > >
> > > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > > ---
> > >  .../bindings/timer/csky,gx6605s-timer.txt          | 46 ++++++++++++++++++++++
> > >  1 file changed, 46 insertions(+)

> Ok, change to "timer0: timer@0x0020a000"
  Ok, change to "timer0: timer@20a000"

