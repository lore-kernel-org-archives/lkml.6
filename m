Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D784C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6DE21A0D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6DE21A0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeHHQqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:46:36 -0400
Received: from ozlabs.org ([203.11.71.1]:45823 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbeHHQqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:46:35 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41ltx75dhJz9s9l; Thu,  9 Aug 2018 00:26:28 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1bb07b593adc1934a526eb04acfe8bf786decfd2
In-Reply-To: <b3d7b6cdb89a48be06a2630bf0d762d9d17d931f.1531511429.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, wei.guo.simon@gmail.com,
        segher@kernel.crashing.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v8,1/4] selftests/powerpc: add test for 32 bits memcmp
Message-Id: <41ltx75dhJz9s9l@ozlabs.org>
Date:   Thu,  9 Aug 2018 00:26:28 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 09:01:10 UTC, Christophe Leroy wrote:
> This patch renames memcmp test to memcmp_64 and adds
> a memcmp_32 test for testing the 32 bits version of memcmp()
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1bb07b593adc1934a526eb04acfe8b

cheers
