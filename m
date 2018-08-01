Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2200EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07CA208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07CA208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbeHAHIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:08:04 -0400
Received: from ozlabs.org ([203.11.71.1]:41333 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733304AbeHAHID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:08:03 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41gMDb4Ry7z9s4V; Wed,  1 Aug 2018 15:24:15 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 04baaf28f40c68c35a413cd9d0db7139c67e6caf
In-Reply-To: <1532423589-18730-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
To:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        linux@roeck-us.net
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-hwmon@vger.kernel.org, ego@linux.vnet.ibm.com,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, stewart@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [v8, 1/2] powernv:opal-sensor-groups: Add support to enable sensor groups
Message-Id: <41gMDb4Ry7z9s4V@ozlabs.org>
Date:   Wed,  1 Aug 2018 15:24:15 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-24 at 09:13:08 UTC, Shilpasri G Bhat wrote:
> Adds support to enable/disable a sensor group at runtime. This
> can be used to select the sensor groups that needs to be copied to
> main memory by OCC. Sensor groups like power, temperature, current,
> voltage, frequency, utilization can be enabled/disabled at runtime.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/04baaf28f40c68c35a413cd9d0db71

cheers
