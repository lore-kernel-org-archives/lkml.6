Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934910AbeE1WEm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 18:04:42 -0400
Received: from mail.us.es ([193.147.175.20]:35850 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934805AbeE1WEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 18:04:39 -0400
Date: Tue, 29 May 2018 00:04:35 +0200
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iptables-compat: homogenize error message
Message-ID: <20180528220435.rzd4lahsa25h2xe7@salvia>
References: <20180527130901.GA18320@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180527130901.GA18320@seema-Inspiron-15-3567>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2018 at 06:39:01PM +0530, Arushi Singhal wrote:
> There is a difference between error messages in iptables and
> iptables-compat:
> 
> #sudo iptables-compat -D INPUT 4
> iptables: No chain/target/match by that name.
> 
> #sudo iptables -D INPUT 4
> iptables: Index of deletion too big.
> 
> Now, will show same error message.

Applied, thanks Arushi.

P.S: Just Cc: netfilter-devel@vger.kernel.org next time. Thanks.
