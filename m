Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F15ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BC921476
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BC921476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeIWTtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 15:49:19 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:48038 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbeIWTtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 15:49:19 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1g44nK-0000bL-OV; Sun, 23 Sep 2018 15:51:30 +0200
Date:   Sun, 23 Sep 2018 15:51:30 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Christian =?iso-8859-15?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        davem@davemloft.net, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@paul-moore.com,
        sds@tycho.nsa.gov, eparis@parisplace.org, jmorris@namei.org,
        serge@hallyn.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/2] netfilter: nf_tables: add requirements for
 connsecmark support
Message-ID: <20180923135130.evm36ouzsrdzb35l@breakpoint.cc>
References: <20180923091611.19815-1-cgzones@googlemail.com>
 <20180923091611.19815-2-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180923091611.19815-2-cgzones@googlemail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Göttsche <cgzones@googlemail.com> wrote:
> Add ability to set the connection tracking secmark value.
> Add ability to set the meta secmark value.

Looks good to me.
Acked-by: Florian Westphal <fw@strlen.de>
