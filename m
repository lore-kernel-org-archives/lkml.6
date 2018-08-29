Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF6FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407D620844
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407D620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeH2LLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:11:42 -0400
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:52619 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH2LLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:11:42 -0400
Received: from [109.168.11.45] (port=33460 helo=[192.168.101.125])
        by srv-hp10.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1fuui4-003nZC-DD; Wed, 29 Aug 2018 09:16:12 +0200
Subject: Re: [PATCH 0/1] Fix ADI axi-i2s + Xilinx AXI-DMA capture
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
References: <20180824160430.10222-1-luca@lucaceresoli.net>
 <20180828185829.GL2414@sirena.org.uk>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <f11d102e-7a72-30f3-e308-394ad20b9bc0@lucaceresoli.net>
Date:   Wed, 29 Aug 2018 09:16:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828185829.GL2414@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 28/08/2018 20:58, Mark Brown wrote:
> On Fri, Aug 24, 2018 at 06:04:29PM +0200, Luca Ceresoli wrote:
>> Hi,
>>
>> here is a fix for a nasty audio capture problem when the axi-i2s
>> output stream is fed to a Xilinx AXI-DMA.
> 
> Please don't send cover letters for single patches, if there is anything
> that needs saying put it in the changelog of the patch or after the ---
> if it's administrative stuff.  This reduces mail volume and ensures that 
> any important information is recorded in the changelog rather than being
> lost. 

OK, will do. Actually I usually do as you suggest, but in this case I
thought it deserved a little extra visibility. Sorry about that.

-- 
Luca
