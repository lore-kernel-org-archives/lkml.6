Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FVohO7sYG1s3VgAAmS7hNA
	; Sat, 09 Jun 2018 00:05:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0FAB26089E; Sat,  9 Jun 2018 00:05:14 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oHgYHQVW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8A551601D3;
	Sat,  9 Jun 2018 00:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A551601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753116AbeFIAFL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 20:05:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752624AbeFIAFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 20:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mvLQRCldXxqTNJFbXrJ3ineQpU1s6G6uop+ZZQpmS7w=; b=oHgYHQVWb42yYIUco7iAxd1y5
        +CUvQooB24b3lkAi6EaGq68Pp4TzUudKP1fJGVI3KcM96jg8pybp2IkD73W/61i4ewCRiIRmlmBDA
        00eBotENHJYTZxXNrHwKtWgz8sbuKgwZSHQl0u5x0l9WxnD6AEDkjkZwtcgYTE0IoKEhYt3VrK/xW
        g7DqIMVu646BC0w6tpirmf5xvoSwyLjIpuvWb9yv7ytBbNTp1O9/RD5rPR/uhOrsxH3zEEBNWozH4
        h5qf9prlpqE9k7qjpB2yvAvn9NGFotfrPD5zZqr5OzrbyPqyM/1hIexntA3Oeo+5dwKpXnxt2ueVE
        0SMoyEdbQ==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fRRNS-0003Z8-LD; Sat, 09 Jun 2018 00:05:06 +0000
Date: Fri, 8 Jun 2018 17:05:04 -0700
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com
Subject: Re: [PATCH v5 8/8] Documentation/ABI: Add documentation mlxreg-io
 sysfs interfaces
Message-ID: <20180609000504.GC111314@localhost.localdomain>
References: <1528203501-129092-1-git-send-email-vadimp@mellanox.com>
 <1528203501-129092-3-git-send-email-vadimp@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528203501-129092-3-git-send-email-vadimp@mellanox.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 12:58:21PM +0000, Vadim Pasternak wrote:
> Add documentation for mlxreg-io platform driver sysfs interfaces to allow
> user space access for system resets control, reset causes monitoring,
> programmable devices version reading and device selection control.
> 
> Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>

No further comments on patch 7 or 8. Thanks for the updates.
-- 
Darren Hart
VMware Open Source Technology Center
