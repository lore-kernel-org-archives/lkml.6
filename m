Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42ECC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C002184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545209358;
	bh=4v3yZcTbxAfsLKNaVX8Fl46kBWtBT40YysRZtAfiIG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UF4Hn8JgE+0x4WAbbWg1judyM4jCe+BNptF9kaRodh1PPSjWlrhdlgvge+AlOP7AP
	 2Bkf6dJhn4CgTnmTXbotrjMnnXsvgvBDqcPK42naRSUCnUCxm1TUiLWnC7Gf56z1Om
	 W0XFT6Y2Oi/3c1zKu9HMyVYzadfWczZfrsSQIYPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbeLSItR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:49:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:49098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbeLSItR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:49:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10A002133F;
        Wed, 19 Dec 2018 08:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545209356;
        bh=4v3yZcTbxAfsLKNaVX8Fl46kBWtBT40YysRZtAfiIG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y0mIyJNq4AbfmnZUNwDbZFmnVJanZlFQGt+LRu6lv3x0czU0Zk+duWONDMcjeoAB9
         rSBcolQNJN4pP27gl5IqKt79C11LndLKk9uzaNdEi3hdvXSfGa+uakjH59EuaHmoCu
         +DQaUyKwrbDPdiBFq2Z+lh0i96NNU8I6X4koqz+8=
Date:   Wed, 19 Dec 2018 09:49:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 1/3] stm class: Fix a module refcount leak in policy
 creation error path
Message-ID: <20181219084914.GA28855@kroah.com>
References: <20181214155347.75722-1-alexander.shishkin@linux.intel.com>
 <20181214155347.75722-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214155347.75722-2-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 05:53:45PM +0200, Alexander Shishkin wrote:
> Commit ccddbbf4ef27 ("stm class: Introduce framing protocol drivers")

I don't see that commit id in Linus's tree, are you sure it is correct?

thanks,

greg k-h
