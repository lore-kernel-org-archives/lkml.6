Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11B0C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840C8206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840C8206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeJBUGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:06:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59682 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJBUGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:06:09 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 92EFAA67;
        Tue,  2 Oct 2018 13:22:49 +0000 (UTC)
Date:   Tue, 2 Oct 2018 06:22:48 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] fbdev fixes for v4.19-rc7
Message-ID: <20181002132248.GB9097@kroah.com>
References: <CGME20181002101812eucas1p28c4a9b388a99a32b9a292fb0cdcce816@eucas1p2.samsung.com>
 <20181002101812eucas1p28c4a9b388a99a32b9a292fb0cdcce816~Zw089uDZp3206032060eucas1p2t@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002101812eucas1p28c4a9b388a99a32b9a292fb0cdcce816~Zw089uDZp3206032060eucas1p2t@eucas1p2.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 12:18:11PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Hi Greg,
> 
> Please pull fbdev fixes for v4.19-rc7 (please see the signed tag
> description for details).

Now merged, thanks.

greg k-h
