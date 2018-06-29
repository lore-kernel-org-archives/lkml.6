Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321BFC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12BE2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12BE2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935838AbeF2S2h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:28:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58720 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933086AbeF2S2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:28:35 -0400
Received: from localhost (unknown [65.196.126.174])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B42FDBAC;
        Fri, 29 Jun 2018 18:28:34 +0000 (UTC)
Date:   Fri, 29 Jun 2018 14:28:32 -0400
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Jiri Slaby <jslaby@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, Anton Zinoviev <anton@lml.bas.bg>
Subject: Re: [PATCH] kbd: complete dead keys definitions
Message-ID: <20180629182832.GB17562@kroah.com>
References: <20180603181858.dtyhhmb7f43cqg3d@var.youpi.perso.aquilenet.fr>
 <20180628222653.uqeh2cqo6izo5j6i@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628222653.uqeh2cqo6izo5j6i@var.youpi.perso.aquilenet.fr>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 12:26:53AM +0200, Samuel Thibault wrote:
> Hello,
> 
> Ping?

It's in my to-review queue please be patient.

thanks,

greg k-h
