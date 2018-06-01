Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeFAPzN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:55:13 -0400
Received: from ozlabs.org ([203.11.71.1]:53893 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752969AbeFAPzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:55:00 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1f7256e7dddef49acf9f6c9fe3f93522a8a2a4c2
In-Reply-To: <20180525021145.4520-1-bauerman@linux.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [v2, 1/2] selftests/powerpc: Add ptrace tests for Protection Key registers
Message-Id: <40y86V72r1z9s1b@ozlabs.org>
Date: Sat,  2 Jun 2018 01:54:58 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-25 at 02:11:44 UTC, Thiago Jung Bauermann wrote:
> This test exercises read and write access to the AMR, IAMR and UAMOR.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1f7256e7dddef49acf9f6c9fe3f935

cheers
