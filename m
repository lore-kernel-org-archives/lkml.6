Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F73C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D5F20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfAQRJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:09:12 -0500
Received: from verein.lst.de ([213.95.11.211]:38574 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728971AbfAQRJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:09:11 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 171C168CEB; Thu, 17 Jan 2019 18:09:10 +0100 (CET)
Date:   Thu, 17 Jan 2019 18:09:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: SUBDIRS= replacement
Message-ID: <20190117170909.GB31280@lst.de>
References: <20190117145531.GA21429@lst.de> <20190117162921.GB31768@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117162921.GB31768@ravnborg.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 05:29:21PM +0100, Sam Ravnborg wrote:
> Try:
> 
> make -j4 fs/xfs/
> 
> This is the recommend way to do so.
> Let us know if you see problem with this approach.

Yes, that seems to work.  I think the warning should suggest that as
well, as it probably is the more common use compare to building
external modules.
