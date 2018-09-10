Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6144BC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1510720833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1510720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeIJNDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:03:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41006 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIJNDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:03:19 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 935BECEA;
        Mon, 10 Sep 2018 08:10:30 +0000 (UTC)
Date:   Mon, 10 Sep 2018 10:10:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: erofs: use explicit unsigned int type
Message-ID: <20180910081027.GA31845@kroah.com>
References: <5c44a63b-041d-1fce-0748-53c0b44f5983@huawei.com>
 <20180909183753.11021-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180909183753.11021-1-linux@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2018 at 08:37:53PM +0200, Thomas Weißschuh wrote:
> Changes since v1:
> 
> * Removed changes that conflicted with
>   [PATCH 1/6] staging: erofs: formatting fix in unzip_vle_lz4.c
> * Added patch description
> 
> Changes since v2:
> 
> * Fixed conflicts with other patchsets
> * Don't introduce new style issues
> 

These changes belong below the --- line, not above it.  I'm not sure if
git will handle this line:

> -- >8 --

Correctly or not, have you tried it?

thanks,

greg k-h
