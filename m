Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D17FECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 09:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEA720882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 09:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFEA720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeGOJzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 05:55:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34328 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeGOJzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 05:55:21 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8C8BDA92;
        Sun, 15 Jul 2018 09:33:01 +0000 (UTC)
Date:   Sun, 15 Jul 2018 11:32:59 +0200
From:   gregkh <gregkh@linuxfoundation.org>
To:     baoyou xie <baoyou.xie@gmail.com>
Cc:     davem <davem@davemloft.net>, willemb <willemb@google.com>,
        viro <viro@zeniv.linux.org.uk>,
        pombredanne <pombredanne@nexb.com>,
        tklauser <tklauser@distanz.ch>, matthew <matthew@mjdsystems.ca>,
        scxby@163.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Fwd: [PATCH v1] datagram: return from __skb_recv_datagram() as
 soon as possible
Message-ID: <20180715093259.GB16003@kroah.com>
References: <1531645098-5791-1-git-send-email-baoyou.xie@aliyun.com>
 <e2282412-5bea-4cb5-83ce-55b996fd4592.baoyou.xie@aliyun.com>
 <CAPTX1NRsaLK9YmphwoiRyOLD+MxWJE2ZzEWOKQVzW-YS7T-vaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTX1NRsaLK9YmphwoiRyOLD+MxWJE2ZzEWOKQVzW-YS7T-vaA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 05:16:50PM +0800, baoyou xie wrote:
> The raw mail was posted back by linux-kernel@vger.kernel.org and 
> netdev@vger.kernel.org, so resend it by this email address.

You are sending HTML email, which is rejected by all kernel mailing
lists.

Please fix up your email client and try again.

greg k-h
