Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48153C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F120823F47
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="eLEOPHCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F120823F47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932910AbeGFMND (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:13:03 -0400
Received: from 8bytes.org ([81.169.241.247]:53534 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932483AbeGFMNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:13:01 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 836DD1F0; Fri,  6 Jul 2018 14:12:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1530879179; bh=JcCmCeGG7XeAUOjfxIq+BlMmaeRHRfDZVp1uEiFJS78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLEOPHCPaz0qBq+I8UAil75vYLLAuOmcW+NQu5BD9Z5OIwcy5NHjCEPBHjTw6HwcZ
         Qz+3e1j4CSsmvouUUxWy+UOjTLTxipPMdYoOzXaIZej7PIZAD1anXaaX6tflQPEifM
         8PSxnfiJqwaGCJzwXX/otieSNLi2pQ7zwPjkChx7qnlBS5gNhnNrhn5zyz8TZzJhoN
         hKUwQiucZKe2hA8/hyBYwyZmNo9f1ULix1EJ6evDXkh+KTOugiacuT1PG+8q0GqSjB
         sUhwpO8RINgWMbvO5QzT+iBgfiCKLKeqLy+EraFMi1lKnpvf9tVOoWGzscszx4fdXK
         +w8o/GSAb4E2g==
Date:   Fri, 6 Jul 2018 14:12:55 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        yoshihiro.shimoda.uh@renesas.com,
        linux-renesas-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND 0/6] iommu: ipmmu-vmsa: Add more Gen3 SoCs support
Message-ID: <20180706121254.m5tyyzpxsyqqo73d@8bytes.org>
References: <1528973306-7962-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528973306-7962-1-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 12:48:20PM +0200, Jacopo Mondi wrote:
> Jacopo Mondi (2):
>   dt-bindings: iommu/ipmmu-vmsa: Add R-Car M3-N (R8A77965)
>   iommu/ipmmu-vmsa: Hook up R8A77965 DT matching code
> 
> Magnus Damm (3):
>   iommu/ipmmu-vmsa: Increase maximum micro-TLBS to 48
>   iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code
>   iommu/ipmmu-vmsa: Document R-Car V3H and E3 IPMMU DT bindings
> 
> Simon Horman (1):
>   iommu/ipmmu-vmsa: Hook up r8a779(70|95) DT matching code

Applied for v4.19, thanks.
