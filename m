Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F4DECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8FF206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFN4avy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8FF206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732816AbeITTYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:24:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732441AbeITTYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:24:52 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7CB0206B6;
        Thu, 20 Sep 2018 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537450878;
        bh=0hMiuPiW8EThronEf0LpURkAQyWo6COY13p1+zQ6Eyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFN4avy/FmHrHo3jnkn+Cwwk8vv8f36g8saDas1OIc9r64MqyjiDy1e4trc7jgXII
         1V+9kNfvniHIxsSFby4zPF7EVcKYupY70NFU6F423JTmDzOXzq2sU2ACsb335jBKss
         zLJMvpCjhJI4Wu8YcTqxhM+ACAIIMdZPpaskEABI=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id AB81A140260; Thu, 20 Sep 2018 10:41:16 -0300 (-03)
Date:   Thu, 20 Sep 2018 10:41:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] perf intel-pt: Improve the data displayed when
 using address filters
Message-ID: <20180920134116.GC19861@kernel.org>
References: <20180920130048.31432-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920130048.31432-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 20, 2018 at 04:00:42PM +0300, Adrian Hunter escreveu:
> Here is V2 of some Intel PT patches to improve the data displayed when using
> address filters.

<SNIP>

> Changes in V2:
> 
> 	Improve commit messages

Thanks a lot, helps a lot,

- Arnaldo
