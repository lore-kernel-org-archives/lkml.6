Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A9FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB679218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900395;
	bh=lsvBGqne0jJBcAN651CWc+0g/0g8Ws2zq9S61GO5sss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=zB2Cw4Fx4JTIux7Ci/x/Ql3gfsoE681SPyiyB3vYtcEvan1375WbBR9MX2dW/lDC1
	 XVuUR5eoi0QSvyCswoGb+ug4vdLfyWeUMJiid1gbpnt2W6ylCKmiqZthzKaEUwFMpw
	 BWCVJwm8gdAPYJmvDWgjXVN2at7sRJpSq3DY5bfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbfBKPxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:53:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729891AbfBKPxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:53:12 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 253AA21855;
        Mon, 11 Feb 2019 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549900391;
        bh=lsvBGqne0jJBcAN651CWc+0g/0g8Ws2zq9S61GO5sss=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RDFzanuTkcknjtWvhhJSkF8nJV15SyVeSsxLwOd6UG24gmVYn5iNWnmvPDMdGMNo2
         e4f0fbrMcvogEu2oNDPwc+s/a+QyVlWoHR3rDx91NU2IRjtSc1jCLFOHPQjb0AtfqN
         4h7HB8e8xaPT7iuvo7s56yUivxcZC7CYC1yyDq5Q=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0457E410D5; Mon, 11 Feb 2019 12:53:09 -0300 (-03)
Date:   Mon, 11 Feb 2019 12:53:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Paul Clarke <pc@us.ibm.com>
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org, ananth@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        sukadev@linux.ibm.com, mpe@ellerman.id.au, cel@us.ibm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 0/4] [powerpc] perf vendor events: Add JSON metrics
 for POWER9
Message-ID: <20190211155308.GE3269@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209181429.23950-1-pc@us.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Feb 09, 2019 at 01:14:25PM -0500, Paul Clarke escreveu:
> [Note this is for POWER*9* and is different content than a
> previous patchset for POWER*8*.]
> 
> The patches define metrics and metric groups for computation by "perf"
> for POWER9 processors.

Applied, thanks.

- Arnaldo
