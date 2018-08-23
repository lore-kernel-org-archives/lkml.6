Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F788C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B4B20671
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B4B20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbeHWS6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:58:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47956 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeHWS6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:58:37 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A7D5DCA0;
        Thu, 23 Aug 2018 15:28:28 +0000 (UTC)
Date:   Thu, 23 Aug 2018 17:28:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott French <stfrench@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: Re: [PATCH 4.17 015/324] smb3: increase initial number of credits
 requested to allow write
Message-ID: <20180823152826.GA28336@kroah.com>
References: <20180823074955.885811006@linuxfoundation.org>
 <20180823074956.669164546@linuxfoundation.org>
 <CAMXdgSCTnXuR=N052yAJt2YEmCX4k=k35gD0cncx7TgM9-S9Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMXdgSCTnXuR=N052yAJt2YEmCX4k=k35gD0cncx7TgM9-S9Lg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 09:38:31AM -0400, Scott French wrote:
> Please remove the stfrench @ gmail address.  I am not Steve

Now removed, sorry for the noise.

greg k-h
