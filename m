Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED85C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0081120868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWpTCLWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0081120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeLAGgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:36:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbeLAGgF (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:36:05 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7204F20868;
        Fri, 30 Nov 2018 19:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543605946;
        bh=pZP9k70lbrleRft8mNWFS9MFlZPIdx0DrrwWsqpW5Nk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWpTCLWrX1ciINSOoUqG/dkUArGYTgPAVu3VieugEyybgWBl1IKCrNWGoXJTl91w8
         OWmFQuJpjvfeTOlQjdmgKGdXINNJMLna/PqmuwZ3IqfOhZHRTr/dsurjqHTAZpIsC9
         mJnMtaWs8HjN8O2z9JndS+i6/gtPHaYAMOmkEDTQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2CFBA40BF1; Fri, 30 Nov 2018 16:25:44 -0300 (-03)
Date:   Fri, 30 Nov 2018 16:25:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 0/4] perf report/annotate: Support average IPC and IPC
 coverage for function
Message-ID: <20181130192544.GD19230@kernel.org>
References: <1543586097-27632-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543586097-27632-1-git-send-email-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 30, 2018 at 09:54:53PM +0800, Jin Yao escreveu:
> Add supporting of displaying the average IPC and IPC coverage
> percentage per function.

<SNIP>
 
> v5:
> ---
>     Update documentation according to Ingo's comments.
> 
>     Only the patch "perf report: Documentation average IPC and
>     IPC coverage" is changed. Others are not changed.

Thanks, applied.

- Arnaldo
