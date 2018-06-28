Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59D2C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4F224205
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4F224205
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbeF1BFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:05:40 -0400
Received: from smtprelay0076.hostedemail.com ([216.40.44.76]:37849 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751177AbeF1BFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:05:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 4C714181D341A;
        Thu, 28 Jun 2018 01:05:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: nail39_886f17f90ca5a
X-Filterd-Recvd-Size: 1525
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Jun 2018 01:05:37 +0000 (UTC)
Message-ID: <99aa610d5052b986dca67daaa7e102a57096bd42.camel@perches.com>
Subject: Re: [PATCH] proc: condemn myself to MAINTAINERS
From:   Joe Perches <joe@perches.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 27 Jun 2018 18:05:35 -0700
In-Reply-To: <20180627194840.GA18113@avx2>
References: <20180627194840.GA18113@avx2>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-27 at 22:48 +0300, Alexey Dobriyan wrote:
> I know I'll regret it.

This wasn't applied back in February?

> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  MAINTAINERS |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11481,6 +11481,15 @@ W:	http://wireless.kernel.org/en/users/Drivers/p54
>  S:	Obsolete
>  F:	drivers/net/wireless/intersil/prism54/
>  
> +PROC FILESYSTEM
> +R:	Alexey Dobriyan <adobriyan@gmail.com>
> +L:	linux-kernel@vger.kernel.org
> +L:	linux-fsdevel@vger.kernel.org
> +S:	Maintained
> +F:	fs/proc/
> +F:	include/linux/proc_fs.h
> +F:	tools/testing/selftests/proc/
> +
>  PROC SYSCTL
>  M:	"Luis R. Rodriguez" <mcgrof@kernel.org>
>  M:	Kees Cook <keescook@chromium.org>
