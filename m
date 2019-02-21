Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475D92084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550765096;
	bh=OHq5vefh2eym4dQechHC/pITsPG/bFbcSLhLRqNCnN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BEY8r2ssCtm5ISvdv1jK22r6xGjX3Wx9DwdQrRVL7HyX2gVPDv+IcqrLcPwUU88Wb
	 U+tiF1lfQcuP+aOLLpH5mTR3cV1RCaVJCv/Kg9ZnjrMB4oCPbbaHC06yP7H5W9kz6n
	 jLNufneuKBviMhTfYpl9Gm/gx5Iz1K0m63bPDNJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfBUQEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:04:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfBUQEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:04:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C1C82083E;
        Thu, 21 Feb 2019 16:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550765093;
        bh=OHq5vefh2eym4dQechHC/pITsPG/bFbcSLhLRqNCnN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ywWQLb9R3gRcLEmJNnL2JVjUefvCGxxxck+EyzMGvgFAhVElD/0X8bP9ctuen/C72
         WgoiWlNUTQaQs56RHQ5H1XWWhyb/+oqb+Jpu/pTpCyeXtgMJXUib/u+1fFRDC7DGW0
         4vTPvBAwFahTl6b6YL5YbdFVXrySWHmlmrgOGX1M=
Date:   Thu, 21 Feb 2019 17:04:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH] staging/vboxvideo: Another FIXME item
Message-ID: <20190221160450.GA25800@kroah.com>
References: <20190221155951.19855-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221155951.19855-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 04:59:51PM +0100, Daniel Vetter wrote:
> Found while grepping around.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> ---
>  drivers/staging/vboxvideo/vbox_irq.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
