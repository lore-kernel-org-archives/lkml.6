Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5318EC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EB922447
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="A/sp6DLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EB922447
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933690AbeFUVkM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:40:12 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:35241 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933382AbeFUVkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:40:11 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jun 2018 17:40:11 EDT
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 41BZgN5hhgz1f;
        Thu, 21 Jun 2018 23:33:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1529616785; bh=da03iqFR1drudyeDxfwrrA0HVzieNB3djTk8o+Ceah0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A/sp6DLietiQRfm+yYrtBwxVE9LmRLuew0Z/LNl2A6eYVr6vOU14Jzm0HCbhiHqBd
         n3qxpYtLwOi0v41RZ/yveVyD5t7ISCleIOdQXrUwk6FYN/LMnVwzlgbjUtVK9Gztnb
         tdyXcPjs9GBNnWFwzE3A8EkMXr+9ZQQSq+TGUzltuy2gWtQZDwjgLA6AxGFZUvj14X
         zK/iEL5pt83x4DVLipDmCKG7dOWSXaV4PWDjxHhWy4nCsjWxo4d/vVFxIlBwZvDQcZ
         uQugH05izeC/pMtvVPM/yu3B+38omeTRUAJSaalEjYL7TIHQrF1J6zMSyltaPWGLIU
         eJjP9d5nd2wxQ==
Date:   Thu, 21 Jun 2018 23:33:27 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 11/26] cb710: Convert to new IDA API
Message-ID: <20180621213327.GA6340@qmqm.qmqm.pl>
References: <20180621212835.5636-1-willy@infradead.org>
 <20180621212835.5636-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180621212835.5636-12-willy@infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 02:28:20PM -0700, Matthew Wilcox wrote:
> Eliminates the custom spinlock and the call to ida_pre_get.
> 
> Signed-off-by: Matthew Wilcox <willy@infradead.org>

Acked-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
