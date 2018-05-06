Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeEFVcw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 17:32:52 -0400
Received: from mail.us.es ([193.147.175.20]:36390 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751854AbeEFVct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 17:32:49 -0400
Date: Sun, 6 May 2018 23:32:45 +0200
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Ahmed Abdelsalam <amsalam20@gmail.com>
Cc: fw@strlen.de, davem@davemloft.net, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [nf-next v2] netfilter: extend SRH matching for previous, next
 and last SID
Message-ID: <20180506213245.r2zazxfnapnwq6po@salvia>
References: <1524652224-1702-1-git-send-email-amsalam20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524652224-1702-1-git-send-email-amsalam20@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 05:30:24AM -0500, Ahmed Abdelsalam wrote:
> IPv6 Segment Routing Header (SRH) contains a list of SIDs to be crossed
> by SR encapsulated packet. Each SID is encoded as an IPv6 prefix.
> 
> When a Firewall receives an SR encapsulated packet, it should be able
> to identify which node previously processed the packet (previous SID),
> which node is going to process the packet next (next SID), and which
> node is the last to process the packet (last SID) which represent the
> final destination of the packet in case of inline SR mode.
> 
> An example use-case of using these features could be SID list that
> includes two firewalls. When the second firewall receives a packet,
> it can check whether the packet has been processed by the first firewall
> or not. Based on that check, it decides to apply all rules, apply just
> subset of the rules, or totally skip all rules and forward the packet to
> the next SID.
> 
> This patch extends SRH match to support matching previous SID, next SID,
> and last SID.

Applied, thanks Ahmed.
