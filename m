Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeCNJ3f (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:29:35 -0400
Received: from ozlabs.org ([103.22.144.67]:34009 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752377AbeCNJ2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:28:44 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1ff3b404019adf9d605224e1dce0677a0375d274
In-Reply-To: <20180304173132.19677-1-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: xmon: Clear all breakpoints when xmon is disabled via debugfs
Message-Id: <401RHG6psmz9sVP@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:33 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-03-04 at 17:31:32 UTC, Vaibhav Jain wrote:
> Presently when xmon is disabled by debugfs any existing
> instruction/data-access breakpoints set are not disabled. This may
> lead to kernel oops when those breakpoints are hit as the necessary
> debugger hooks aren't installed.
> 
> Hence this patch introduces a new function named clear_all_bpt()
> which is called when xmon is disabled via debugfs. The function will
> unpatch/clear all the trap and ciabr/dab based breakpoints.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1ff3b404019adf9d605224e1dce067

cheers
