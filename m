Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DF9ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD22208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD22208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbeGOLJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 07:09:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35434 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeGOLJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 07:09:48 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ABF32899;
        Sun, 15 Jul 2018 10:47:15 +0000 (UTC)
Date:   Sun, 15 Jul 2018 12:47:13 +0200
From:   gregkh <gregkh@linuxfoundation.org>
To:     baoyou xie <baoyou.xie@gmail.com>
Cc:     davem <davem@davemloft.net>, willemb <willemb@google.com>,
        viro <viro@zeniv.linux.org.uk>,
        pombredanne <pombredanne@nexb.com>,
        tklauser <tklauser@distanz.ch>, matthew <matthew@mjdsystems.ca>,
        scxby@163.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Fwd: [PATCH v1] datagram: return from __skb_recv_datagram() as
 soon as possible
Message-ID: <20180715104713.GA14636@kroah.com>
References: <1531645098-5791-1-git-send-email-baoyou.xie@aliyun.com>
 <e2282412-5bea-4cb5-83ce-55b996fd4592.baoyou.xie@aliyun.com>
 <CAPTX1NRsaLK9YmphwoiRyOLD+MxWJE2ZzEWOKQVzW-YS7T-vaA@mail.gmail.com>
 <20180715093259.GB16003@kroah.com>
 <CAPTX1NQAMDE-5+4jnCmf+YKY1tTPTPJshE0VaUhgeU9RM3Zv_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTX1NQAMDE-5+4jnCmf+YKY1tTPTPJshE0VaUhgeU9RM3Zv_g@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 06:27:16PM +0800, baoyou xie wrote:
> Thanks for gregkh's reply:-)
> It's sure that the mail was sent with git, so guys may commit this patch in
> this mail.

You are still sending html email, and you need to properly resend the
patch without that in order for anyone to even be able to see it.

greg k-h
