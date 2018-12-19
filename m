Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9FEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6E62133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545209030;
	bh=C7oOCI8MYHOL4AJ+V+8j09nfwZ5LornLxvKrW8rdIFw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=S4axdVNTxDr3kZJ4j6JmD2nlsI+QD3SgaQSr6pRjc73sk27ggHKTeJWwUK9A8qs3J
	 UHIC/9RhJfH8kacKP0Ki33BVodmG/csgR2dK8SidbMfLbEHmqqzHg2A3cexzrnnqYk
	 YHUAcm9KlUa7l5KZWuNfvUJ69Lg3Kyw3ajNk2blo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeLSInt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:43:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:47716 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726631AbeLSInt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:43:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D4CEAED6;
        Wed, 19 Dec 2018 08:43:47 +0000 (UTC)
Date:   Wed, 19 Dec 2018 09:43:45 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Zhou Chengming <zhouchengming1@huawei.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V2 3/9] x86/jump_label: Move checking code away from
 __jump_label_transform()
In-Reply-To: <1d1a40fec7285eaf47b8055a26684508109eefb7.1545149539.git.bristot@redhat.com>
Message-ID: <nycvar.YFH.7.76.1812190942360.17216@cbobk.fhfr.pm>
References: <cover.1545149539.git.bristot@redhat.com> <1d1a40fec7285eaf47b8055a26684508109eefb7.1545149539.git.bristot@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018, Daniel Bristot de Oliveira wrote:

> This patch creates a new functions 

I am not a native speaker, but this doesn't sound like proper english to 
me.

> to check the current code before updating a jump_entry.

It should also be stated that this is equivalent code transformation, I 
think.

Thanks,

-- 
Jiri Kosina
SUSE Labs

