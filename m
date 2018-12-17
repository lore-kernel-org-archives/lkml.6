Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425FBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137362146E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545055151;
	bh=kgZIdNab3amusrOlRbbsVpVlUchIOp35m8ljurhQpk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XTfjjSYwM5cGgXj4ugvvuDk3HiuqmpYgElPsFAo2N3uJyR4ODqVmbTT7aQjfPtCP4
	 iWWV2z5wO33lbLMbTTGonyRJtDy+PkPd9XTKMoJ5froTyf1CDnT7m1jreuxHX7+yqn
	 I1xBQMZ5dSBoWLFYeyC9YAFn4SGC9wDwAJHCrSa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733014AbeLQN7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:59:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:58044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732181AbeLQN7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:59:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BABB2133F;
        Mon, 17 Dec 2018 13:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545055148;
        bh=kgZIdNab3amusrOlRbbsVpVlUchIOp35m8ljurhQpk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WLrk2H1kXpoiCUcTW5UFciJjMes8cCj5D3KBPk3PJEin6W4qddU/FUitTXJJ+1oPs
         bYomNp+rmRKrwAjGCGLk/ezDN2r9iVhI3VngCAYZbJQdlFW+tJ+yTstp1gUOMfViX5
         S7v2ajb/+wtxc6AL4/mKDG6EQZuo50WurUGjEtg4=
Date:   Mon, 17 Dec 2018 14:59:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     arnd@arndb.de, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/3]  misc/pvpanic : add pci interface for pvpanic
Message-ID: <20181217135906.GA12339@kroah.com>
References: <1545043394-19417-1-git-send-email-peng.hao2@zte.com.cn>
 <1545043394-19417-2-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545043394-19417-2-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 06:43:13PM +0800, Peng Hao wrote:
> +	pvpanic_unregister_pci_drvier();

"driver", not "drvier" please.

thanks,

greg k-h
