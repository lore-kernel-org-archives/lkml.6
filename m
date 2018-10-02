Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D115C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B5F206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B5F206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbeJBW6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:58:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbeJBW6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:58:45 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B53C1307C716
        for <linux-kernel@vger.kernel.org>; Tue,  2 Oct 2018 16:14:37 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 736D89D7E5;
        Tue,  2 Oct 2018 16:14:35 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 2EC422E6A; Tue,  2 Oct 2018 13:14:32 -0300 (BRT)
Date:   Tue, 2 Oct 2018 13:14:32 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Sanskriti Sharma <sansharm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH 0/5] perf tool: small coverity clean ups
Message-ID: <20181002161432.GG9457@redhat.com>
References: <1538490554-8161-1-git-send-email-sansharm@redhat.com>
 <20181002160213.GA16200@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002160213.GA16200@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 02 Oct 2018 16:14:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 02, 2018 at 06:02:13PM +0200, Jiri Olsa escreveu:
> On Tue, Oct 02, 2018 at 10:29:09AM -0400, Sanskriti Sharma wrote:
> > This patch set fixes a few coverity static code analyzer complaints. Build 
> > tested only.
> > 
> > Sanskriti Sharma (5):
> >   perf strbuf: match va_{add,copy} with va_end
> >   perf tools: cleanup trace-event-info 'tdata' leak
> >   perf tools: free 'printk' string in parse_ftrace_printk()
> >   perf tools: avoid double free in read_event_file()
> >   perf tools: free temporary 'sys' string in read_event_files()
> 
> nice, thanks for posting those
> 
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>

yeah, thanks a lot!

Adding your r-by tag now.

- Arnaldo
