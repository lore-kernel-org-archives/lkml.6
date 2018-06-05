Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeFEPTe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:19:34 -0400
Received: from ozlabs.org ([203.11.71.1]:44881 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751885AbeFEPTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:19:33 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b0c4acb1dd7c653f78391661079af544429b1f22
In-Reply-To: <20180526151531.10920-1-colin.king@canonical.com>
To: Colin King <colin.king@canonical.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc-opal: fix spelling mistake "Uniterrupted" -> "Uninterrupted"
Message-Id: <410b7l5m3cz9s1w@ozlabs.org>
Date: Wed,  6 Jun 2018 01:19:31 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-05-26 at 15:15:31 UTC, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in hmi_error_types text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Reviewed-by: Stewart Smith <stewart@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b0c4acb1dd7c653f78391661079af5

cheers
