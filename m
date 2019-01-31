Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1D7C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E4E218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbfAaDXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:23:47 -0500
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:52148 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725535AbfAaDXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:23:47 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 735DB837F242;
        Thu, 31 Jan 2019 03:23:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: skirt86_3be7e75e494e
X-Filterd-Recvd-Size: 1541
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 31 Jan 2019 03:23:45 +0000 (UTC)
Message-ID: <df314ee9176095b5d59af8659c95a274fb0613c4.camel@perches.com>
Subject: Re: Fwd: [PATCH v14 0/3] PPS: pps-gpio PPS ECHO implementation
From:   Joe Perches <joe@perches.com>
To:     tom burkart <tom@aussec.com>,
        Rodolfo Giometti <giometti@enneenne.com>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Date:   Wed, 30 Jan 2019 19:23:44 -0800
In-Reply-To: <20190131124008.64023l78rw406lfc@www.aussec.com>
References: <20190129124357.17396k708szaibbx@www.aussec.com>
         <7abdee30-91fb-4d11-52e1-1778e418c7b8@enneenne.com>
         <20190131124008.64023l78rw406lfc@www.aussec.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-31 at 12:40 +1100, tom burkart wrote:
> Quoting Rodolfo Giometti <giometti@enneenne.com>:
> --------
> Subject	Re: [PATCH v14 2/3] dt-bindings: pps: pps-gpio PPS ECHO implementation
> 
> I think this patch it's OK but I'm asking to myself if it should be  
> merged with
> next one... logically it describes what patch 3/3 does so why do we keep them
> separated?
> -------
> I have separated it because scripts/checkpatch.pl insists it needs to  
> be separated.

checkpatch doesn't insist on anything.  It's a stupid script.

Always prefer your best judgment over a stupid script.


