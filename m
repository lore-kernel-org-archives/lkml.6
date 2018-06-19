Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6BFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA70220652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0JIwu9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA70220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937750AbeFSPNy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755616AbeFSPNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:13:52 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F36A020652;
        Tue, 19 Jun 2018 15:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529421232;
        bh=yYNVv63HAaIcU1oiWWk6u9EILQoAz3VMZZZHIQF5F6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0JIwu9Fw2bN89rf2mQ4pAKTSM8rQ2eDSyZ+uCkIZu/ZellOe6DjkDE2U/0T7pZuy
         qt7kyFnVCrVm1MuMU1XTc4VPoUnvbU6kF7MTySgBVJdLM5nmmnEFsiImBUOS6d3LMQ
         zA2xcg3fL7UfykSogHeSj22ve4sxdN8jYhRZ38iY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id D7BA81401E5; Tue, 19 Jun 2018 12:13:49 -0300 (-03)
Date:   Tue, 19 Jun 2018 12:13:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/3 v2] perf alias: Remove trailing newline when reading
 sysfs files
Message-ID: <20180619151349.GG20477@kernel.org>
References: <20180615101105.47047-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615101105.47047-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 15, 2018 at 12:11:03PM +0200, Thomas Richter escreveu:
> Remove a trailing newline when reading sysfs file contents
> such as /sys/devices/cpum_cf/events/TX_NC_TEND.
> This shows when verbose option -v is used.
> 
> Output before:
> tx_nc_tend -> 'cpum_cf'/'event=0x008d
> '/

Thanks, applied.

- Arnaldo
