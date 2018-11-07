Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCF2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128CF20883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQUL1FRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128CF20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeKGX4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:56:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbeKGX4U (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:56:20 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8186A2085B;
        Wed,  7 Nov 2018 14:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541600744;
        bh=riGsYXlw0olLv/AITf0+IPxaRD7H4pcXc5HRQRXwM8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TQUL1FRIyyzieNTEq1rCiku6mJdp1IMClnxOh1TLB6teA5ot5iHzKiXZYW5A7kGNO
         2L4rCf9gF6DNyJNv/0ySUVGEushUMfAZ3t+jjUxiONLOnJQPepUygJcnHhOb0tPEsU
         eWMkBtgtULqPnVxPoUc3cJ3FmR2EC3A6Gqg3tQgg=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 24456142D18; Wed,  7 Nov 2018 11:25:41 -0300 (-03)
Date:   Wed, 7 Nov 2018 11:25:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     jolsa@kernel.org, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf script: add newline after uregs output
Message-ID: <20181107142541.GD18346@kernel.org>
References: <20181107093705.16346-1-milian.wolff@kdab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107093705.16346-1-milian.wolff@kdab.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 07, 2018 at 10:37:05AM +0100, Milian Wolff escreveu:
> This change makes it much easier to easily distinguish
> between consecutive samples by keeping the empty line
> between them, like we see when we do not enable uregs
> output.

Thanks, applied.

- Arnaldo
