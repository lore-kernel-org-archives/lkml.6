Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85015C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B929214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9cxTk0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B929214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbeKUXog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:59238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbeKUXog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:44:36 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B27AC214C4;
        Wed, 21 Nov 2018 13:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542805816;
        bh=kLuL0FVnoD3N1FQ/JTWasgEtoAOABM52i8DIVU76uhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X9cxTk0N74+J4ZnQi8sU1GVtQGa7tNtlJ0Kbrg6H4/qxHF2xbqzoVMzrRz7A60hDB
         2wKJNuXIVKxlDaXh1aYAXSHdiGiNUiU23phRs6i3AE60+rKuJsN7q/+kIayckVcDZp
         KddW9JUWc38msS2IpDxfw2Mpec8yTO0qKAm6SEbM=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id DC2D61443D6; Wed, 21 Nov 2018 10:10:13 -0300 (-03)
Date:   Wed, 21 Nov 2018 10:10:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 2/2] perf vendor events: Add JSON metrics for Cascadelake
 server
Message-ID: <20181121131013.GF6248@kernel.org>
References: <20181114212416.15665-1-kan.liang@linux.intel.com>
 <20181114212416.15665-2-kan.liang@linux.intel.com>
 <20181115132116.GH9600@krava>
 <3ab97c73-c197-8555-1a35-b54636e667e6@linux.intel.com>
 <20181115151442.GK9600@krava>
 <20181121125130.GD6248@kernel.org>
 <20181121125408.GE6248@kernel.org>
 <20181121130202.GA22611@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121130202.GA22611@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 21, 2018 at 02:02:02PM +0100, Jiri Olsa escreveu:
> On Wed, Nov 21, 2018 at 09:54:08AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Nov 21, 2018 at 09:51:30AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Thu, Nov 15, 2018 at 04:14:42PM +0100, Jiri Olsa escreveu:
> > > > On Thu, Nov 15, 2018 at 08:33:27AM -0500, Liang, Kan wrote:
> > > > > The patch is attached. Can it be applied?

> > > > yep, that one works

> > > Can I have your reviewed-by for this one as well?

> > I turned the "yep, that one works" into an Acked-by, please let me know
> > if that is enough.

> yes, if it applies it's ok for me.. but can't judge the events inside ;-)

Ok, Acked-by kept then. Thanks!

- Arnaldo
