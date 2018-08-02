Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987BBC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C5C2145D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C5C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbeHBKB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:01:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbeHBKB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:01:56 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A565CCC3;
        Thu,  2 Aug 2018 08:11:56 +0000 (UTC)
Date:   Thu, 2 Aug 2018 10:11:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] tty: Replace goldfish_tty_line_count with a
 #define
Message-ID: <20180802081154.GA27413@kroah.com>
References: <20180725005133.107823-1-rkir@google.com>
 <20180725005133.107823-3-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725005133.107823-3-rkir@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 05:51:33PM -0700, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> The driver never mutates this variable - no benefits of
> keeping it mutable.
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
> Changes in v2:
>  - Replaced "const u32" with "#define".
> 
>  drivers/tty/goldfish.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Does not apply to my tree :(
