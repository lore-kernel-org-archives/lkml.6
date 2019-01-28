Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13681C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD9420881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfA1HEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:04:25 -0500
Received: from verein.lst.de ([213.95.11.211]:38123 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfA1HEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:04:25 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B326D7F07E; Mon, 28 Jan 2019 08:04:22 +0100 (CET)
Date:   Mon, 28 Jan 2019 08:04:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20190128070422.GA2772@lst.de>
References: <20190118125500.GA15657@lst.de> <e11e61b1-6468-122e-fc2b-3b3f857186bb@xenosoft.de> <f39d4fc6-7e4e-9132-c03f-59f1b52260e0@xenosoft.de> <b9e5e081-a3cc-2625-4e08-2d55c2ba224b@xenosoft.de> <20190119130222.GA24346@lst.de> <20190119140452.GA25198@lst.de> <bfe4adcc-01c1-7b46-f40a-8e020ff77f58@xenosoft.de> <8434e281-eb85-51d9-106f-f4faa559e89c@xenosoft.de> <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de> <1dec2fbe-f654-dac7-392a-93a5d20e3602@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dec2fbe-f654-dac7-392a-93a5d20e3602@xenosoft.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 02:13:09PM +0100, Christian Zigotzky wrote:
> Christoph,
>
> What shall I do next?

I'll need to figure out what went wrong with the new zone selection
on powerpc and give you another branch to test.
