Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A50C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E25520651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390864AbfAPRC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:02:26 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:36457 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbfAPRC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:02:26 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x0GH2Afi008033;
        Wed, 16 Jan 2019 18:02:10 +0100
Date:   Wed, 16 Jan 2019 18:02:10 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/8] libertas: change snprintf to scnprintf for possible
 overflow
Message-ID: <20190116170210.GA8030@1wt.eu>
References: <20190112152844.26550-1-w@1wt.eu>
 <20190112152844.26550-2-w@1wt.eu>
 <878szma2hz.fsf@codeaurora.org>
 <20190115203503.GA7117@1wt.eu>
 <87a7k04kua.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7k04kua.fsf@codeaurora.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 06:40:29PM +0200, Kalle Valo wrote:
> Ok, I'll queue this for 5.0 and apply it to wireless-drivers instead.

Thank you!

Willy
