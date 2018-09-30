Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C19FC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5602920833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5602920833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeI3WOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 18:14:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55104 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeI3WOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 18:14:09 -0400
Received: from localhost (c-73-221-170-44.hsd1.wa.comcast.net [73.221.170.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D3518E95;
        Sun, 30 Sep 2018 15:40:38 +0000 (UTC)
Date:   Sun, 30 Sep 2018 08:40:37 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     stable <stable@vger.kernel.org>,
        kernel <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: ovl: hash non-dir by lower inode for fsnotify
Message-ID: <20180930154037.GA8525@kroah.com>
References: <2630a5c0-ef57-a4cf-a6f4-b4996c64043b@android.com>
 <20180802060549.GB3272@kroah.com>
 <8c38c2fc-36e6-9aa7-5924-51d7bc2c3d73@android.com>
 <20180907095132.GC13327@kroah.com>
 <2ec8884f-4572-967e-c16c-cb59cfc5f352@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ec8884f-4572-967e-c16c-cb59cfc5f352@android.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 10:24:34AM -0700, Mark Salyzyn wrote:
> On 09/07/2018 02:51 AM, Greg KH wrote:
> > As this patch is deemed "good", can you please resend it in a
> > non-corrupted way so that I can apply it to the 4.14.y tree?
> > 
> > thanks,
> > 
> > greg k-h
> 
> The toll of numerous vacations, and manic priorities that resulted, sorry
> for the delay, composed and resent.

No worries, thanks for the patch, now queued up.

greg k-h
