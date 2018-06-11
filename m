Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id S5kiMiQbHluMHQAAmS7hNA
	; Mon, 11 Jun 2018 06:48:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7484060792; Mon, 11 Jun 2018 06:48:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 18BBA601D2;
	Mon, 11 Jun 2018 06:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18BBA601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbeFKGso (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:48:44 -0400
Received: from verein.lst.de ([213.95.11.211]:57394 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754016AbeFKGsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:48:42 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7B6A668CEE; Mon, 11 Jun 2018 08:56:37 +0200 (CEST)
Date: Mon, 11 Jun 2018 08:56:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Avi Kivity <avi@scylladb.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH v1] aio: mark __aio_sigset::sigmask const
Message-ID: <20180611065637.GA748@lst.de>
References: <20180608145505.29063-1-avi@scylladb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608145505.29063-1-avi@scylladb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 05:55:05PM +0300, Avi Kivity wrote:
> io_pgetevents() will not change the signal mask. Mark it const
> to make it clear and to reduce the need for casts in user code.
> 
> Signed-off-by: Avi Kivity <avi@scylladb.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
