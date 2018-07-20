Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151D2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14FF20850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14FF20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeGTIqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:46:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:44164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727108AbeGTIqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:46:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2224DAE21;
        Fri, 20 Jul 2018 07:59:42 +0000 (UTC)
Date:   Fri, 20 Jul 2018 09:59:33 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Subject: Re: [PATCH 00/39 v8] PTI support for x86-32
Message-ID: <20180720075933.fegnjnhgouclitft@suse.de>
References: <1531906876-13451-1-git-send-email-joro@8bytes.org>
 <alpine.DEB.2.21.1807200114130.1693@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807200114130.1693@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Jul 20, 2018 at 01:21:33AM +0200, Thomas Gleixner wrote:
> On Wed, 18 Jul 2018, Joerg Roedel wrote:
> > 
> > here is version 8 of my patches to enable PTI on x86-32. The
> > last version got some good review which I mostly worked into
> > this version.
> 
> I went over the whole set once again and did not find any real issues. As
> the outstanding review comments are addressed, I decided that only broader
> exposure can shake out eventually remaining issues. Applied and pushed out,
> so it should show up in linux-next soon.
> 
> The mm regression seems to be sorted, so there is no immeditate fallout
> expected.
> 
> Thanks for your patience in reworking this over and over. Thanks to Andy
> for putting his entry focssed eyes on it more than once. Great work!

Thanks a lot too! Let's hope things will go smooth from here...
I will also continue testing and improving the code, currently I am
working on a relaxed paranoid entry/exit path suggested by Andy.


Regards,

	Joerg

