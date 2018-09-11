Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28262C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C797A206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C797A206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeIKXtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:49:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35774 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeIKXtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:49:05 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 45C7513E3;
        Tue, 11 Sep 2018 18:47:58 +0000 (UTC)
Date:   Tue, 11 Sep 2018 20:47:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Elie Roudninski <xademax@gmail.com>
Subject: Re: [RFC PATCH 0/4] Add specific vt input's key map
Message-ID: <20180911184755.GA2562@kroah.com>
References: <cover.1534972811.git.repk@triplefau.lt>
 <20180905172022.GA30233@voidbox.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905172022.GA30233@voidbox.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 07:20:23PM +0200, Remi Pommarel wrote:
> Hi,
> 
> Just a gentle ping.
> 
> Any comments on this patchset that adds a way to have multiple
> keyboards with different keymap on a VT would be nice.

Normally I do not review "RFC" patches as it implies the submitter does
not think they are a valid solution.  How about resending them as if you
think this is something ready to be merged?

thanks,

greg k-h
