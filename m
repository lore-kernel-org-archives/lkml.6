Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEA1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4B6217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545304168;
	bh=AUMD6xG4FNidtWBMRPymNHB8K1weUx2OgcyJwHvb8Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dtaoZObIiOxtvwKxlHlzeiM/EHYh7Bxld4D2HVO7Me4P1o27//6zYRYEYOIYWX3tQ
	 1SHor0EUlSstZren+pFrnvs4FB/efKM5RPPQjI2UJodZp4VcvkGpfvEdZzoDfGY0m6
	 j/O4eOCzmeEctwUwcDuAf49w4bEQTbu9427o1fTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbeLTLJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:09:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730001AbeLTLJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:09:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA41121741;
        Thu, 20 Dec 2018 11:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545304166;
        bh=AUMD6xG4FNidtWBMRPymNHB8K1weUx2OgcyJwHvb8Uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1DDZnYi/4Ga2f3IcTylb0VEwyEo/ZztKKWkgzunpAPdq9KCaCapNGnMOD3QYq0P1k
         sgHTcBnfDzyRT2r7AAm+bfLg+KUKFbG88qfToYwn8aJ2E9GJf16joppqgkWOGV0n7u
         tJESTzaBjyBL8/VN5aIErdqtcW0Xou5zD4MWS9P8=
Date:   Thu, 20 Dec 2018 12:09:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     tkjos@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update Android binder
Message-ID: <20181220110923.GA10786@kroah.com>
References: <20181220104057.18628-1-christian@brauner.io>
 <20181220105444.GB8548@kroah.com>
 <B16ED4A7-5C64-4285-A076-1CBFEFE47DDB@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B16ED4A7-5C64-4285-A076-1CBFEFE47DDB@brauner.io>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 11:59:17AM +0100, Christian Brauner wrote:
> On December 20, 2018 11:54:44 AM GMT+01:00, Greg KH <gregkh@linuxfoundation.org> wrote:
> >On Thu, Dec 20, 2018 at 11:40:57AM +0100, Christian Brauner wrote:
> >> As briefly discussed with Greg and Todd, add Christian as maintainer
> >for
> >> binder{fs}.
> >> 
> >> Signed-off-by: Christian Brauner <christian@brauner.io>
> >> ---
> >>  MAINTAINERS | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 3318f30903b2..3c78cfa08c47 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -950,6 +950,7 @@ M:	Arve Hjønnevåg <arve@android.com>
> >>  M:	Todd Kjos <tkjos@android.com>
> >>  M:	Martijn Coenen <maco@android.com>
> >>  M:	Joel Fernandes <joel@joelfernandes.org>
> >> +M:	Christian Brauner <christian@brauner.io>
> >
> >Do you really want to be a maintainer for all of binder?  (which is
> >fine
> >with me, up to Todd and others), or do you just want to be responsible
> >for the binderfs code?
> 
> As I mentioned off-list once: I'm fine with both.

Ok, no objection from me, Todd/Martijn/Joel/Arve, can I get an ack from
someone?

thanks,

greg k-h
