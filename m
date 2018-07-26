Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40318C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D7D20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D7D20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbeGZLuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:50:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:42562 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729271AbeGZLuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:50:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 112D2ADA5;
        Thu, 26 Jul 2018 10:33:49 +0000 (UTC)
Received: from shadow.suse.cz (shadow.suse.cz [10.100.13.111])
        by dark.suse.cz (Postfix) with ESMTP id C5A4312CC0C;
        Thu, 26 Jul 2018 12:33:48 +0200 (CEST)
Received: by shadow.suse.cz (Postfix, from userid 10002)
        id AF6DE4464F; Thu, 26 Jul 2018 12:33:48 +0200 (CEST)
Date:   Thu, 26 Jul 2018 12:33:48 +0200
From:   Vojtech Pavlik <vojtech@suse.cz>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: stop telling users to snail-mail Vojtech
Message-ID: <20180726103348.et4mxhfcjvigz2ji@suse.cz>
References: <20180724184554.GA74150@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724184554.GA74150@dtor-ws>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 11:45:54AM -0700, Dmitry Torokhov wrote:

> I do not think Vojtech wants snail mail these days, even if the
> address were correct (I do not know if it is), so let's remove
> snail-mail instructions from the sources.
 
Thanks. Nobody has ever sent me mail this way, but nevertheless, the
address isn't valid anymore, so removing it makes good sense.

-- 
Vojtech Pavlik
Director SUSE Labs
