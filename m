Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbeCTPsr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:48:47 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:46492 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751186AbeCTPsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:48:46 -0400
Date: Tue, 20 Mar 2018 16:48:42 +0100
From: Florian Westphal <fw@strlen.de>
To: valdis.kletnieks@vt.edu
Cc: Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: linux-next: ip6tables *broken* - last base chain position %u
 doesn't match underflow %u (hook %u
Message-ID: <20180320154842.GC24075@breakpoint.cc>
References: <24374.1521559053@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24374.1521559053@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

valdis.kletnieks@vt.edu <valdis.kletnieks@vt.edu> wrote:
> (Resending because I haven't heard anything)
[ ip6tables broken ]

Sorry, did not see this email before.

I'll investigate asap, thanks for the detailed report.
