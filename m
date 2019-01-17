Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BB1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C4120851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547731427;
	bh=eqAhFsI//HQZc6XqQPTkY5chhqZ0aTVmfTQDjkz56hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=09/Vpf4hYK1C8ZCB4yr7aQIo5rCKDIOjDSi/Nm7NqNeykD3u7+qpMzhyN1eFJDO95
	 HnAG24LmGdTE5Yl3XfMq7Ya9wL8SGD4P88gExxJINzTROwIHCYelh/Plac9zSQW+Ww
	 WTNE3gITdgkqQxCF5l33DdbN5s02+H82E89f9SsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfAQNXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:23:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfAQNXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:23:44 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3184D20851;
        Thu, 17 Jan 2019 13:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547731424;
        bh=eqAhFsI//HQZc6XqQPTkY5chhqZ0aTVmfTQDjkz56hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kf/CVF7oBMmKDRjPg4KTxQmA7+HqFViCDk3Pz91xHpPrpnt5WORkLeONDXS8Myd58
         bU5cp6AqT6Gsi4/ojMwwEiK1YkRgJg3er4tqaczO8NtVkObFDc15dge1S9DuHZ+em2
         zIyhlA7M3LAnNjNbbCuwfJQxGO5b48zO2/I87oSA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DD8FF41AB5; Thu, 17 Jan 2019 10:23:41 -0300 (-03)
Date:   Thu, 17 Jan 2019 10:23:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, namhyung@kernel.org, colin.king@canonical.com,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Subject: Re: [PATCH] tools/perf: Remove duplicate header
Message-ID: <20190117132341.GH11922@kernel.org>
References: <20190115135916.GA3629@hp-pavilion-15-notebook-pc-brajeswar>
 <CAFqt6zYyWANuBt773x64QDuvqsH4qsNE1yz9APo2Xxjdfm0pXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zYyWANuBt773x64QDuvqsH4qsNE1yz9APo2Xxjdfm0pXg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 17, 2019 at 11:25:52AM +0530, Souptick Joarder escreveu:
> On Tue, Jan 15, 2019 at 7:29 PM Brajeswar Ghosh
> <brajeswar.linux@gmail.com> wrote:
> >
> > Remove duplicate headers which are included more than once
> >
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> 
> Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

Thanks, applied.

- Arnaldo
