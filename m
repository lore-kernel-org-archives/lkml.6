Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23573ECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8412147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8412147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbeIQNwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:52:02 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:44037 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeIQNwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:52:02 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1FBB130002236;
        Mon, 17 Sep 2018 10:25:40 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id EE81721C7CC; Mon, 17 Sep 2018 10:25:39 +0200 (CEST)
Date:   Mon, 17 Sep 2018 10:25:39 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH AUTOSEL 4.14 87/87] PCI: Whitelist Thunderbolt ports for
 runtime D3
Message-ID: <20180917082539.pikwd2n27ah6xy35@wunner.de>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
 <20180917030220.245686-87-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917030220.245686-87-alexander.levin@microsoft.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On Mon, Sep 17, 2018 at 03:03:19AM +0000, Sasha Levin wrote:
> From: Lukas Wunner <lukas@wunner.de>
> 
> [ Upstream commit 47a8e237ed443c174f8f73402755c458c56eb611 ]
> 
> Thunderbolt controllers can be runtime suspended to D3cold to save ~1.5W.
> This requires that runtime D3 is allowed on its PCIe ports, so whitelist
> them.

This commit was at the end of a series with 30+ patches and depends on
all the preceding patches.  It cannot be backported on its own I'm afraid,
hence should be removed from the 4.14 and 4.18 stable queue.

Thanks,

Lukas
