Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeEQODz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:03:55 -0400
Received: from ozlabs.org ([203.11.71.1]:56835 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbeEQODy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:03:54 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] selftests/powerpc: Add core file test for Protection Key registers
In-Reply-To: <20180223183344.21038-2-bauerman@linux.vnet.ibm.com>
References: <20180223183344.21038-1-bauerman@linux.vnet.ibm.com> <20180223183344.21038-2-bauerman@linux.vnet.ibm.com>
Date: Fri, 18 May 2018 00:03:51 +1000
Message-ID: <87r2mamla0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> This test verifies that the AMR, IAMR and UAMOR are being written to a
> process' core file.
>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  tools/testing/selftests/powerpc/ptrace/Makefile    |   5 +-
>  tools/testing/selftests/powerpc/ptrace/core-pkey.c | 460 +++++++++++++++++++++

Also failing w/out pkeys:

  test: core_pkey
  tags: git_version:52e7d87
  [FAIL] Test FAILED on line 117
  [FAIL] Test FAILED on line 265
  failure: core_pkey


cheers
