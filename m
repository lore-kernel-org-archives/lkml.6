Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884E0C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B83216F8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B83216F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gherkin.frus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbeHNCUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 22:20:01 -0400
Received: from gherkin.frus.com ([192.158.254.49]:37208 "EHLO gherkin.frus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729478AbeHNCUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 22:20:01 -0400
Received: by gherkin.frus.com (Postfix, from userid 500)
        id C76D73CFF4; Mon, 13 Aug 2018 18:35:31 -0500 (CDT)
Date:   Mon, 13 Aug 2018 18:35:31 -0500
From:   Bob Tracy <rct@gherkin.frus.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Subject: Re: [BUG] 4.18-rcX iptables regression
Message-ID: <20180813233531.GA1138@gherkin.frus.com>
References: <20180807010049.GA1345@gherkin.frus.com>
 <20180807134230.2b20d73e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807134230.2b20d73e@canb.auug.org.au>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 01:42:30PM +1000, Stephen Rothwell wrote:
> Hi Bob,
> 
> [Juts cc'ing the netfilter and netdev mailing lists]
> 
> On Mon, 6 Aug 2018 20:00:49 -0500 Bob Tracy <rct@gherkin.frus.com> wrote:
> >
> > With iptables v1.6.0 and kernel version 4.18-rc7, "iptables [-t table] -L"
> > produces diagnostic output to the effect of not being able to find the table.
> > Kernel version 4.17.0 and earlier work fine.

Problem fixed no later than 4.18.0: running on that kernel as I type
this.  Thanks for the quick repair.  Apologies for the "linux-net"
noise: a list by that name hasn't existed for a while, and I missed that
somehow.

--Bob
