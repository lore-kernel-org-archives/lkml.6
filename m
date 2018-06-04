Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbeFDOLV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:11:21 -0400
Received: from ozlabs.org ([203.11.71.1]:51115 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751473AbeFDOLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:11:18 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a377514519b9a20fa1ea9adddbb4129573129cef
In-Reply-To: <20180528131914.32231-1-msuchanek@suse.de>
To: Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Michal Suchanek <msuchanek@suse.de>,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/64s: Enhance the information in cpu_show_spectre_v1()
Message-Id: <40zxgS4kkwz9s5R@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:08 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-28 at 13:19:14 UTC, Michal Suchanek wrote:
> We now have barrier_nospec as mitigation so print it in
> cpu_show_spectre_v1 when enabled.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a377514519b9a20fa1ea9adddbb412

cheers
