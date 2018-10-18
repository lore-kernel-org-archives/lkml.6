Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B08C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8832145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8832145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeJSEsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbeJSEsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:48:47 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B15E20658;
        Thu, 18 Oct 2018 20:46:00 +0000 (UTC)
Date:   Thu, 18 Oct 2018 16:45:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] selftests: ftrace: Add synthetic event syntax
 testcase
Message-ID: <20181018164558.30de909a@gandalf.local.home>
In-Reply-To: <7cf20a84-841b-de35-939c-03314e0ac0d3@kernel.org>
References: <153986829702.18251.1286066460999338772.stgit@devbox>
        <153986838264.18251.16627517536956299922.stgit@devbox>
        <20181018163427.6e0f823d@gandalf.local.home>
        <7cf20a84-841b-de35-939c-03314e0ac0d3@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 14:38:22 -0600
Shuah Khan <shuah@kernel.org> wrote:

> On 10/18/2018 02:34 PM, Steven Rostedt wrote:
> > 
> > Hi Masami,
> > 
> > Thanks! I pulled this into my urgent queue and will be running tests on
> > it over night.
> > 
> > Shuah, can you ack this patch, as I want to add it to this release,
> > along with the other changes.
> >   
> 
> Acked-by: Shuah Khan <shuah@kernel.org>
> 

Thanks for the quick response!

-- Steve
