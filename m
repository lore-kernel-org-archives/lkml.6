Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeFAPzK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:55:10 -0400
Received: from ozlabs.org ([203.11.71.1]:35321 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752669AbeFAPzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:55:01 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 39b91dd625f15438859204a489ab62ef41d2be39
In-Reply-To: <20180525021145.4520-2-bauerman@linux.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [v2, 2/2] selftests/powerpc: Add core file test for Protection Key registers
Message-Id: <40y86W6jNmz9s3x@ozlabs.org>
Date: Sat,  2 Jun 2018 01:54:59 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-25 at 02:11:45 UTC, Thiago Jung Bauermann wrote:
> This test verifies that the AMR, IAMR and UAMOR are being written to a
> process' core file.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/39b91dd625f15438859204a489ab62

cheers
