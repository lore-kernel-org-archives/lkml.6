Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987F6C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3697820815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="sXHsJIDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbfACKMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:12:16 -0500
Received: from owa.iluvatar.ai ([103.91.158.24]:40795 "EHLO owa.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728530AbfACKMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:12:16 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1546510320; h=from:subject:to:date:message-id;
        bh=iq2hEaWVE4xd0CcujXJRJx7YjVxyGPAoFoRO5dQc5SY=;
        b=sXHsJIDkep19VXw1uzZi4aI+7N9KzMsGbN6+OExMoxdrJ78a703NaaMmeXG6/yN7LOMgY5r3sI1
        XmBOfXO8h524J2dSR15q3H00Y99bMsRZ6riiVbAbtEZDMM38W1qxc0g+lOE0BYTQbfwGm6TpM4MMl
        meaomEL9aJP+7m/viRg=
Received: from hsj-Precision-5520 (10.101.1.99) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Thu, 3 Jan 2019 18:12:00 +0800
Date:   Thu, 3 Jan 2019 18:11:59 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     Christoph Hellwig <hch@infradead.org>
CC:     <akpm@linux-foundation.org>, <sfr@canb.auug.org.au>,
        <alexey.skidanov@intel.com>, <linux-kernel@vger.kernel.org>,
        <shijie8@gmail.com>
Subject: Re: [PATCH 2/2] lib/genalloc.c: export symbol addr_in_gen_pool
Message-ID: <20190103101159.GA8656@hsj-Precision-5520>
References: <20181224070622.22197-1-sjhuang@iluvatar.ai>
 <20181224070622.22197-2-sjhuang@iluvatar.ai>
 <20190103075550.GA11147@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20190103075550.GA11147@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.101.1.99]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 11:55:50PM -0800, Christoph Hellwig wrote:
> On Mon, Dec 24, 2018 at 03:06:22PM +0800, Huang Shijie wrote:
> > We may use the addr_in_gen_pool() in the driver module.
> > So export the addr_in_gen_pool for the compiling.
> 
> Please send this along with the driver that plans to use it.
The driver is still under develop with the FPGA, and our hardware chip maybe
tape out at next year.

Thanks
Huang Shijie


