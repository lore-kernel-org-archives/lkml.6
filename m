Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 23C39C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3293208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3293208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935419AbeFMMcI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:32:08 -0400
Received: from smtprelay0211.hostedemail.com ([216.40.44.211]:53564 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754467AbeFMMcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:32:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 549358368EEF;
        Wed, 13 Jun 2018 12:32:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: birds49_122f8bfbc231b
X-Filterd-Recvd-Size: 1471
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 13 Jun 2018 12:32:04 +0000 (UTC)
Message-ID: <b34abe879f77c55d29ef8a2b1cd9aa0e09ee2a3b.camel@perches.com>
Subject: Re: [PATCH] Fixed an indentation error
From:   Joe Perches <joe@perches.com>
To:     Parth Y Shah <sparth1292@gmail.com>, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 13 Jun 2018 05:32:03 -0700
In-Reply-To: <1528892710-14928-1-git-send-email-sparth1292@gmail.com>
References: <1528892710-14928-1-git-send-email-sparth1292@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-13 at 17:55 +0530, Parth Y Shah wrote:
> Signed-off-by: Parth Y Shah <sparth1292@gmail.com>

-ENOCHANGELOG

Why do you think this is an error?
Why is the dev_dbg useful at all?

> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
[]
> @@ -1217,8 +1217,8 @@ static void purge_configs_funcs(struct gadget_info *gi)
>  			list_move_tail(&f->list, &cfg->func_list);
>  			if (f->unbind) {
>  				dev_dbg(&gi->cdev.gadget->dev,
> -				         "unbind function '%s'/%p\n",
> -				         f->name, f);
> +						"unbind function '%s'/%p\n",
> +						f->name, f);
>  				f->unbind(c, f);
>  			}
>  		}
